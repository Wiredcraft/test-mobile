//
//  WCTNetworkService.swift
//  WiredcraftTest
//
//  Created by Richard on 2020/7/24.
//  Copyright © 2020 RichardSheng. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift
import RxCocoa

let serverUrl: String = "https://api.github.com/search/users"

class WCTNetworkService {
  let disposeBag: DisposeBag = DisposeBag()
  
  var searchStr: String?
  var page: Int = 1
  
  func fetchUserData(isRefresh: Bool, search: String? = nil) -> Driver<FetchUserResponseData> {
    return Observable.create { [weak self] (observer) -> Disposable in
      guard let self = self else { return Disposables.create() }
      var parameters: [String: Any] = [:]
      
      if let searchString = search {
        parameters["q"] = searchString
      } else if let searchString = self.searchStr {
        parameters["q"] = searchString
      } else {
        return Disposables.create()
      }
      
      if isRefresh {
        parameters["page"] = 1
      } else {
        parameters["page"] = self.page + 1
      }

      RxAlamofire.requestJSON(.get, serverUrl, parameters: parameters).debug().observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (r, json) in
        guard let self = self else { return }
        guard let jsonDic = json as? [String: AnyObject], let responseData = FetchUserResponseData(JSON: jsonDic) else { return }
        self.searchStr = parameters["q"] as? String
        self.page = parameters["page"] as! Int
        observer.onNext(responseData)
        observer.onCompleted()
      }, onError: { (error) in

      }).disposed(by: self.disposeBag)
      return Disposables.create()
    }.asDriver(onErrorJustReturn: FetchUserResponseData())
  }
}
