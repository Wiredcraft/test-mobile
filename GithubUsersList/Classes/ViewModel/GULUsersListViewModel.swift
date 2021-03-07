//
//  GDHomeViewModel.swift
//  GithubDemo
//
//  Created by 裘诚翔 on 2021/3/3.
//

import Foundation
import Moya
import RxSwift

struct GULUsersListViewModel {
    let provider = MoyaProvider<GULService>()
    
    func fetchUsers() -> Observable<[GULUsersListItemModel]> {
        return Observable.create { (observer) -> Disposable in
            provider.rx.request(.usersList(1)).mapString().subscribe { (result) in
                switch result {
                case let .success(response):
                    guard let model = map(from: response, type: GULUsersListModel.self),
                          let list = model.items else {
                        return
                    }
                    observer.onNext(list)
                    observer.onCompleted()
                case let .error(error):
                    print(error.localizedDescription)
                }
            }
            return Disposables.create()
        }
    }
}
