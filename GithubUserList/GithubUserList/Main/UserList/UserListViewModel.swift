//
//  UserListViewModel.swift
//  GithubUserList
//
//  Created by zhaotianyang on 2022/3/30.
//

import Foundation
import RxSwift
import RxCocoa

final class UserListViewModel {
    private let bag = DisposeBag()
    private var pageIndex = 1
    private var searchKey = ""
    
    let userList = BehaviorRelay<[UserPage.User]>(value: [])
    let endRefresh = PublishSubject<Bool>()
    
    init() {
        loadData()
        
        AppGlobal.followSigle.subscribe(onNext: { [weak self] _ in
            self?.overloadData()
        }).disposed(by: bag)
    }
    
    func overloadData() {
        let users = userList.value
        userList.accept(users)
    }
    
    func loadNextPage() {
        loadData()
    }
    
    func followAction(_ user: UserItemData) {
        guard let uid = user.id else {return}
        if user.isFollow {
            AppGlobal.unFollowUser(id: uid)
        } else {
            AppGlobal.followUser(id: uid)
        }
    }
    
    func search(_ key: String?) {
        var text = ""
        if let keyText = key, keyText.count > 0 {
            text = keyText
        }
        searchKey = text
        pageIndex = 1
        loadData()
    }
    
    private func loadData() {
        let param: [String: Any] = [
            "q": searchKey.count > 0 ? searchKey : "c",
            "page": pageIndex
        ]
        
        let reqCase = GitHub.searchUser(param)
        API.request(UserPage.self, api: reqCase)
            .compactMap({$0.items})
            .subscribe(onNext: {[weak self] list in
                guard let this = self else {return}
                debugPrint("\(this.pageIndex)    \(list.count)")
                if this.pageIndex == 1 {
                    this.userList.accept(list)
                } else {
                    let users = this.userList.value
                    this.userList.accept(users+list)
                }
                if list.count > 0 {
                    this.pageIndex += 1
                }
            }, onError: { err in
                debugPrint(err.localizedDescription)
            }, onCompleted: {[weak self] in
                self?.endRefresh.onNext(true)
            }).disposed(by: bag)
    }
}
