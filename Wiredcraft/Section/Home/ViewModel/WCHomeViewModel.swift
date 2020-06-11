//
//  WCHomeViewModel.swift
//  Wiredcraft
//
//  Created by codeLocker on 2020/6/11.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WCHomeViewModel: WCBaseViewModel {

    /// the query input action Observable
    var querySearchAction: Observable<String>? {
        didSet {
            guard let querySearchAction = self.querySearchAction else {
                return
            }
            /// empty value won't initiate network request
            self.searchResult = querySearchAction.filter { (query) in
                self.query = query
                /// reset the footer, if footer is no more data status reset to nomal status
                self.refreshAction.resetFooterStatus()
                return !self.query.isEmpty
            }
            .flatMapLatest { _ in
                /// initiate network request
                self.usersListRequest()
            }
        }
    }
    
    /// the query result
    fileprivate var searchResult: Observable<WCUserListModel>? {
        didSet {
            guard let searchResult = self.searchResult else {
                return
            }
            let _ = searchResult.map({ (response) in
                if let _ = response.errors {
                    /// error happens
                    self.searchFail.onNext(response.message ?? "")
                    return
                }
                guard let userModels = response.items else {
                    return
                }
                /// inser data
                self.users.accept(userModels)
                
            }).subscribe(onNext: { _ in
                
            }).disposed(by: self.disposeBag)
        }
    }
    
    /// network fail Observable
    public var searchFail = PublishSubject<String>()
    
    /// displayed users's data
    public let users = BehaviorRelay<[WCUserModel]>(value: [])
    
    /// the refresh action
    fileprivate lazy var refreshAction = WCRxRefresh()
    
    /// page number
    fileprivate lazy var page: Int = 1
    
    /// the keyword to query
    fileprivate lazy var query: String = ""
    
    /// total count of all data, if have loaded data's count >= totalCount, the scrollView will show 'no more data'
    fileprivate lazy var totalCount: Int = 0
    
    /// enable the scrollView refresh ability
    /// - Parameter scrollView: target scrollView
    public func enableRefreshScrollView(_ scrollView: UIScrollView) {
        
        let _ = self.refreshAction.refreshStatusBind(to: scrollView, { [weak self] in
            /// header refresh
            guard let `self` = self else { return }
            self.page = 1
            self.refreshAction.set(observable: self.usersListRequest())
            self.refreshAction.reload.onNext(())
            
        }) { [weak self] in
            /// footer refresh
            guard let `self` = self else { return }
            self.page += 1
            self.refreshAction.set(observable: self.usersListRequest())
            self.refreshAction.more.onNext(false)
        }

        /// merge the refresh data to viewModel's user
        let _ = self.refreshAction.data.subscribe(onNext: { [weak self] (response) in
            
            guard let `self` = self else { return }
            /// set totalCount
            self.totalCount = (response as? WCUserListModel)?.total_count ?? 0
            let users = (response as? WCUserListModel)?.items ?? [WCUserModel]()
            
            if self.page == 1 {
                self.users.accept(users)
                if users.count == 0 {
                    self.refreshAction.refreshStatus.onNext(.none)
                }
            } else {
                self.users.accept(self.users.value + users)
            }
            // judge have more data
            if self.users.value.count > self.totalCount {
                self.refreshAction.setNoMoreDataStstus()
            }
            
        }).disposed(by: self.disposeBag)
    }
    
    
    /// the query users list request
    /// - Returns: network request Observable
    private func usersListRequest() -> Observable<WCUserListModel> {
        return WCHomeNetworkService.usersList(query: self.query, page: self.page)
            .observeOn(MainScheduler.instance)
            .catchError({ (error) -> Observable<WCUserListModel> in
                /// error happens
                self.searchFail.onNext(error.localizedDescription)
                return Observable<WCUserListModel>.empty()
            })
    }
}

//MARK: - Get Data
extension WCHomeViewModel {
    /// get userModel
    /// - Parameter index: location
    /// - Returns: userModel
    public func getUser(at index: Int) -> WCUserModel? {
        if index < 0 || index >= self.users.value.count {
            return nil
        }
        return self.users.value[index]
    }
    
    /// get the user's nickname
    /// - Parameter index: location
    /// - Returns: nickname
    public func getUserNickname(at index: Int) -> String? {
        return self.getUser(at: index)?.login
    }
    
    /// get the user's avatar
    /// - Parameter index: location
    /// - Returns: avatar's url
    public func getUserAvatar(at index: Int) -> String? {
        return self.getUser(at: index)?.avatar_url
    }
    
    /// get the user's score
    /// - Parameter index: location
    /// - Returns: score
    public func getUserScore(at index: Int) -> Int? {
        return self.getUser(at: index)?.score
    }
    
    /// get the user's homepage
    /// - Parameter index: location
    /// - Returns: homepage's url
    public func getUserHomepage(at index: Int) -> String? {
        return self.getUser(at: index)?.html_url
    }
}
