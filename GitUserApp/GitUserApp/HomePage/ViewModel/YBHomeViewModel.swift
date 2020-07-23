//
//  ViewModel.swift
//  GitUserApp
//
//  Created by Rock on 7/23/20.
//  Copyright © 2020 Rock. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya_ObjectMapper

class YBHomeViewModel : NSObject{
    // request data page
    var page = 1
    // tableData for tableView
    let tableData = BehaviorRelay<[GitHubUser]>(value: [])
    //  memory collection
    let disposeBag : DisposeBag
    // search content. default value is Swift
    let keyword = BehaviorRelay(value: "Swift")
    
    let headerLoading = ActivityIndicator()
    let footerLoading = ActivityIndicator()
     
    init (disposeBag:DisposeBag) {
        self.disposeBag = disposeBag
    }
    
    /// transform singnal
    /// - Parameter input: (searchAction, heaserRefresh, footerRefresh)
    func bindAction(input:(searchAction: Observable<String>,
                          headerRefresh: Observable<Void>,
                          footerRefresh: Observable<Void> )){

        // search result sequence
        input.searchAction
           .filter { !$0.isEmpty }
           .flatMapLatest({ [weak self] keyword -> Observable<GitHubUsers> in
                guard let self = self else { return Observable.empty() }
                self.page = 1
                return self.request(login: keyword, page: self.page)
           }).subscribe(onNext: { [weak self] (gitHubUsers) in
                guard let self = self else { return }
                self.tableData.accept(gitHubUsers.items)
           }, onError: { (error) in
                YBProgressHUD.showError(error.localizedDescription)
            
        }).disposed(by: disposeBag)
            
        // bind search content to keyword
        input.searchAction
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
            .asObservable()
            .bind(to: keyword).disposed(by: disposeBag)
        
       // headerRefresh result sequence
       input.headerRefresh
        .startWith(()) // when app launched start once
           .flatMapLatest({ [weak self] _ -> Observable<GitHubUsers> in
                guard let self = self else { return Observable.empty() }
                self.page = 1
                return self.request(login: self.keyword.value, page: self.page).trackActivity(self.headerLoading)
            
        }).subscribe(onNext: { [weak self] (gitHubUsers) in
                guard let self = self else { return }
                self.tableData.accept(gitHubUsers.items)
           }, onError: { (error) in
                
                YBProgressHUD.showError(error.localizedDescription)
            
        }).disposed(by: disposeBag)
        
       // footerRefresh result sequence
       input.footerRefresh
           .flatMapLatest({ [weak self] _ -> Observable<GitHubUsers> in
                guard let self = self else { return Observable.empty() }
                self.page += 1
            return self.request(login: self.keyword.value, page: self.page).trackActivity(self.footerLoading)
           }).subscribe(onNext: { [weak self] (gitHubUsers) in
                   guard let self = self else { return }
                   self.tableData.accept(self.tableData.value + gitHubUsers.items )
              }, onError: { (error) in
                   YBProgressHUD.showError(error.localizedDescription)
               
           }).disposed(by: disposeBag)

    }
    
    func request(login: String, page: Int) -> Observable<GitHubUsers> {
        return gitHubProvider.rx.request(.gitHubUsers(login: login, page: page))
            .filterSuccessfulStatusCodes()
            .mapObject(GitHubUsers.self)
            .asObservable()

    }
    
}
