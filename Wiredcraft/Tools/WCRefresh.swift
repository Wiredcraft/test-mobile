//
//  WCRefresh.swift
//  Wiredcraft
//
//  Created by codeLocker on 2020/6/12.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh

/// the statu of refresh
public enum WCRefreshStatus {
    case none                                   // none
    case beingHeaderRefresh                     // header begin refresh
    case endHeaderRefresh                       // header end refresh
    case beginFooterRefresh                     // footer begin refresh
    case endFooterRefresh                       // footer end refresh
    case endFooterRefreshWithNoMoreData         // There is no more data
    case endAllRefresh                          // end all regresh
}


public protocol WCRefreshable {
     var refreshStatus: BehaviorSubject<WCRefreshStatus> { get }
}

public protocol WCRefreshResponse {
    // just a protocol for the list data which want to use the refresh function
}

extension WCRefreshable {
    
    /// set the header/footer refresh function
    /// - Parameters:
    ///   - scrollView: target scrollView
    ///   - header: header handle
    ///   - footer: footer handle
    /// - Returns:
    public func refreshStatusBind(to scrollView: UIScrollView, _ header: (() -> Void)? = nil,  _ footer: (() -> Void)? = nil) -> Disposable {
        
        if header != nil {
            scrollView.mj_header = MJRefreshNormalHeader {
                scrollView.mj_footer?.endRefreshing()
                header!()
            }
        }
        
        if footer != nil {
            scrollView.mj_footer = MJRefreshAutoNormalFooter {
                scrollView.mj_header?.endRefreshing()
                footer!()
            }
        }
        
        /// refresh status
        return refreshStatus.subscribe(onNext: { (status) in
            switch status {
            case .none:
                scrollView.mj_footer?.isHidden = false
                
            case .beingHeaderRefresh:
                scrollView.mj_header?.beginRefreshing()
                
            case .endHeaderRefresh:
                scrollView.mj_header?.endRefreshing()
                scrollView.mj_footer?.isHidden = false
                
            case .endFooterRefresh:
                scrollView.mj_footer?.endRefreshing()
                
            case .endFooterRefreshWithNoMoreData:
                scrollView.mj_footer?.endRefreshingWithNoMoreData()
                
            case .endAllRefresh:
                scrollView.mj_header?.endRefreshing()
                scrollView.mj_footer?.endRefreshing()
                
            case .beginFooterRefresh:
                break
            }
        })
    }
}

/*
 * refresh and result handle
 */
public class WCRxRefresh: WCRefreshable {
    
    /// the data get from refresh action
    public var data = PublishSubject<WCRefreshResponse>()
    
    /// refresh status
    public var refreshStatus = BehaviorSubject(value: WCRefreshStatus.none)
    
    /// pull refresh
    public var reload = PublishSubject<Void>()
    
    /// drag up load more
    public var more = PublishSubject<Bool>()
    
    /// dispose
    let disposeBag = DisposeBag()
    
    public init() {
        
    }
    
    /// reset footer from no more data status to nomal
    public func resetFooterStatus() {
        self.refreshStatus.onNext(.endFooterRefresh)
    }
    
    public func setNoMoreDataStstus() {
        self.refreshStatus.onNext(.endFooterRefreshWithNoMoreData)
    }
    
    /// set the network Observable
    /// - Parameter observable: network request
    public func set<T: WCRefreshResponse>(observable: Observable<T>?) {
        guard let observable = observable else {
            return
        }
    
        self.reload = PublishSubject<Void>()
        self.more = PublishSubject<Bool>()
        
        //pull down regresh
        self.reload.subscribe(onNext: { [weak self] (isReload) in
            guard let `self` = self else {
                return
            }
            
            /// takeUntil: if it is refreshing, and load more at the same time, refresh will be ignore
            let _ = observable.takeUntil(self.more).subscribe(onNext: { (items) in
                self.data.onNext((items))
                
            }, onError: { (error) in
            }, onCompleted: {
                /// change status
                self.refreshStatus.onNext(.endHeaderRefresh)
            }).disposed(by: self.disposeBag)
            
        }).disposed(by: self.disposeBag)
        
        //drag load more
        self.more.subscribe(onNext: { [weak self] (isNoMoreData) in
            guard let `self` = self else {
                return
            }
            
            /// takeUntil: if it is loading more, and refresh at the same time, loading more will be ignore
            let _ = observable.takeUntil(self.reload).subscribe(onNext: { (items) in
                self.refreshStatus.onNext(.endFooterRefresh)
                self.data.onNext((items))
            }, onError: { (error) in
                self.refreshStatus.onNext(.endFooterRefresh)
            }, onCompleted: {
            }).disposed(by: self.disposeBag)
            
        }, onError: { (error) in
        }).disposed(by: self.disposeBag)
    }
}


