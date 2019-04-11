//
//  HomeViewModel.swift
//  GitHubUsers
//
//  Created by lusheng tan on 2019/4/10.
//  Copyright © 2019 lusheng tan. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import Result
import RxCocoa

enum APIError: Error {
    case JsonParseError(String)
    case NetworkError(String)
}

class HomeViewModel {
    var users = BehaviorRelay<[User]>(value: [])
    var result = PublishSubject<Result<HomeResult,APIError>>()
    var page = BehaviorRelay<Int>(value: 1)
    var disposeBag = DisposeBag()
    init() {
        page.subscribe(onNext: { [weak self] pageIndex in
            let provider = MoyaProvider<APIManager>()
            _ = provider.rx.request(.SwiftUsers(pageIndex)).subscribe(onSuccess: { response in
                do {
                    let decoder = JSONDecoder()
                    let homeResult = try decoder.decode(HomeResult.self, from: response.data)
                    if pageIndex == 1 {
                        self?.users.accept(homeResult.items)
                    } else {
                        if let users = self?.users.value {
                            self?.users.accept(users + homeResult.items)
                        }
                    }
                    self?.result.onNext(Result.success(homeResult))
                } catch {
                    self?.result.onNext(Result.failure(.JsonParseError("json prase error")))
                }
            }, onError: { error in
                self?.result.onNext(Result.failure(.JsonParseError("network error")))
            })
        }).disposed(by: disposeBag)
    }
}
