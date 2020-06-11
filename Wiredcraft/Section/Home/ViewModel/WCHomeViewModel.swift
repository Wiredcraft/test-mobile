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
            self.searchResult = querySearchAction.filter { !$0.isEmpty }
                .flatMapLatest {
                    /// initiate network request
                    WCHomeNetworkService.usersList(query: $0, page: 1).observeOn(MainScheduler.instance).catchError { (error) -> Observable<WCUserListModel> in
                        /// send error Observable
                        self.searchFail.onNext(error.localizedDescription)
                        return Observable<WCUserListModel>.empty()
                    }
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
    
    
    //MARK: - Get Data
    
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
