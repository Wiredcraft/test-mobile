//
//  UserDetailViewModel.swift
//  GithubUserList
//
//  Created by zhaotianyang on 2022/3/31.
//

import Foundation
import RxSwift
import RxCocoa

final class UserDetailViewModel {
    private let bag = DisposeBag()
    private let userModel: UserItemData
    let userList = BehaviorRelay<[ReposItemModel]>(value: [])
    
    init(user: UserItemData) {
        userModel = user
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
    
    private func loadData() {
        guard let name = userModel.login else {return}
        let reqCase = GitHub.userRepositories(name)
        API.request([ReposItemModel].self, api: reqCase)
            .compactMap({$0})
            .subscribe(onNext: {[weak self] list in
                guard let this = self else {return}
                this.userList.accept(list)
            }, onError: { err in
                debugPrint(err.localizedDescription)
            }).disposed(by: bag)
    }
}

