//
//  WCTHomeViewModel.swift
//  WiredcraftTest
//
//  Created by Richard on 2020/7/24.
//  Copyright © 2020 RichardSheng. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class WCTHomeViewModel {

  let disposeBag: DisposeBag = DisposeBag()

  // MARK: - User Search Actions
  let searchBarText: Driver<String>

  // MARK: - MJRefresh
  let endHeaderRefresh: Driver<Bool>
  let endFooterLoad: Driver<Bool>

  let cellModels = BehaviorRelay<[WCTUserTableViewCellModel]>(value: [])

  init(searchBarText: Driver<String>, headerRefresh: Driver<Void>, footerLoad: Driver<Void>, networkService: WCTNetworkService) {
    self.searchBarText = searchBarText

    let searchResult = searchBarText.flatMapLatest { networkService.fetchUserData(isRefresh: true, search: $0) }

    let headerRefreshData = headerRefresh.flatMapLatest { (Void) -> Driver<FetchUserResponseData> in
      return networkService.fetchUserData(isRefresh: true)
    }
    
    self.endHeaderRefresh = headerRefreshData.map { _ in true }
    
    let footerLoadData = footerLoad.flatMapLatest { (Void) -> Driver<FetchUserResponseData> in
      return networkService.fetchUserData(isRefresh: false)
    }

    self.endFooterLoad = footerLoadData.map { _ in true }
    
    searchResult.asObservable().subscribe(onNext: { [weak self] (responseData) in
      guard let self = self else { return }
      if let userModels = responseData.items, userModels.count > 0 {
        let newCellModels: [WCTUserTableViewCellModel] = userModels.map {
          return WCTUserTableViewCellModel(with: $0)
        }
        self.cellModels.accept(newCellModels)
      }
    }).disposed(by: disposeBag)


    headerRefreshData.asObservable().subscribe(onNext: { [weak self] (responseData) in
      guard let self = self else { return }
      if let userModels = responseData.items, userModels.count > 0 {
        let newCellModels: [WCTUserTableViewCellModel] = userModels.map {
          return WCTUserTableViewCellModel(with: $0)
        }
        self.cellModels.accept(newCellModels)
      }
    }).disposed(by: disposeBag)
    

    
    footerLoadData.asObservable().subscribe(onNext: { [weak self] (responseData) in
      guard let self = self else { return }
      if let userModels = responseData.items, userModels.count > 0 {
        let newCellModels: [WCTUserTableViewCellModel] = userModels.map {
          return WCTUserTableViewCellModel(with: $0)
        }
        self.cellModels.accept(self.cellModels.value + newCellModels)
      }
    }).disposed(by: disposeBag)
    
  }
}



