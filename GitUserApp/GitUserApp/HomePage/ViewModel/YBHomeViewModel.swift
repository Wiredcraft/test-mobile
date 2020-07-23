//
//  YBHomeViewModel.swift
//  GitUserApp
//
//  Created by Rock on 7/22/20.
//  Copyright © 2020 Rock. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class YBHomeViewModel : NSObject{
    // request data page
    var page = 1
    // tableData for tableView
    let tableData = BehaviorRelay<[GitHubUser]>(value: [])
    // net request Tool
    let network : YBNetWorking
    //  memory collection
    let disposeBag : DisposeBag
    // search content. default value is Swift
    let keyword = BehaviorRelay(value: "Swift")
     
    init (disposeBag:DisposeBag,
          networkService: YBNetWorking ) {
        self.disposeBag = disposeBag
        self.network = networkService
    }
    
    /// transform singnal
    /// - Parameter input: (searchAction, heaserRefresh, footerRefresh)
    func transform(input:(searchAction: Driver<String>,
           headerRefresh: Driver<Void>,
           footerRefresh: Driver<Void> ))
        -> (headerRefresh: Driver<Bool>, footerRefresh: Driver<Bool>){

        // search result sequence
       let searchData = input.searchAction
           .filter { !$0.isEmpty }
           .flatMapLatest({ [weak self] keyword -> Driver<GitHubUsers> in
                guard let self = self else { return Driver.empty() }
                self.page = 1
                return self.network.searchGitHubUsers(login: keyword, page: self.page)
           })
            
        // bind search content to keyword
        input.searchAction
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
            .asObservable()
            .bind(to: keyword).disposed(by: disposeBag)
        
       // headerRefresh result sequence
       let headerRefreshData = input.headerRefresh
           .startWith(()) 
           .flatMapLatest({ [weak self] _ -> Driver<GitHubUsers> in
                guard let self = self else { return Driver.empty() }
                self.page = 1
                return self.network.searchGitHubUsers(login: self.keyword.value, page: self.page)
        }).asDriver { (error) -> Driver<GitHubUsers> in
                YBProgressHUD.showError(error.localizedDescription)
                return Driver.empty()
           }
        
       // footerRefresh result sequence
       let footerRefreshData = input.footerRefresh
           .flatMapLatest({ [weak self] _ -> Driver<GitHubUsers> in
                guard let self = self else { return Driver.empty() }
                self.page += 1
                return self.network.searchGitHubUsers(login: self.keyword.value, page: self.page)
           })
       
        // searchData replace tableData
        searchData.drive(onNext: { [weak self] items in
            guard let self = self else { return }
            self.tableData.accept(items.items)
        }).disposed(by: self.disposeBag)
        
        // headerRefreshData replace tableData
        headerRefreshData.drive(onNext: { [weak self] items in
            guard let self = self else { return }
            self.tableData.accept(items.items)
        }).disposed(by: self.disposeBag)

        // footerRefreshData merge tableData
        footerRefreshData.drive(onNext: { [weak self] items in
            guard let self = self else { return }
            self.tableData.accept(self.tableData.value + items.items )
        }).disposed(by: self.disposeBag)
        
        return (headerRefreshData.map{ _ in true }, footerRefreshData.map{ _ in true })
    }
    
}
