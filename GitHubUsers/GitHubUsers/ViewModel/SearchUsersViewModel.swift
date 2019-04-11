//
//  SearchNewsViewModel.swift
//  GitHubUsers
//
//  Created by lusheng tan on 2019/4/11.
//  Copyright © 2019 lusheng tan. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import Result
import RxCocoa

class SearchUsersViewModel {
    var keyWord = PublishSubject<String?>()
    var users = BehaviorRelay<[User]>(value: [])
    var result = PublishSubject<Result<HomeResult,APIError>>()
    var disposBag = DisposeBag()
    init() {
        keyWord.map { text -> String in
            if let keyWord = text {
                return keyWord
            } else {
                return ""
            }
            }.filter { text -> Bool in
                if text.isEmpty {
                    return false
                }
                return true
            }.subscribe(onNext: { [weak self] text in
                let provider = MoyaProvider<APIManager>()
                _ = provider.rx.request(.SearchUsers(text)).subscribe(onSuccess: { response in
                    do {
                        let decoder = JSONDecoder()
                        let homeResult = try decoder.decode(HomeResult.self, from: response.data)
                        self?.users.accept(homeResult.items)
                        self?.result.onNext(Result.success(homeResult))
                    } catch {
                        self?.result.onNext(Result.failure(.JsonParseError("json prase error")))
                    }
                }, onError: { error in
                    self?.result.onNext(Result.failure(.JsonParseError("network error")))
                })
            }).disposed(by: disposBag)
    }
}
