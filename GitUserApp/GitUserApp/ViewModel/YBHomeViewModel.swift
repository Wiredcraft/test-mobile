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

class YBHomeViewModel {
     
    var page = 1
    //表格数据序列
    let tableData = BehaviorRelay<[GitHubUser]>(value: [])

    let network : YBNetWorking
    let disposeBag : DisposeBag
    // 设置一个初始化默认值 如果不设置默认值进入页面是空白状态
    let keyword = BehaviorRelay(value: "Swift")
     
    //ViewModel初始化（根据输入实现对应的输出）
    init(disposeBag:DisposeBag,
         networkService: YBNetWorking ) {
            self.disposeBag = disposeBag
            self.network = networkService

    }
    
    func transform(input:(searchAction: Driver<String>,
        headerRefresh: Driver<Void>,
        footerRefresh: Driver<Void> )) -> (Driver<Bool>, Driver<Bool>){

        //搜索
       let searchData = input.searchAction.filter { !$0.isEmpty }.skip(1)
           .flatMapLatest({ s -> SharedSequence<DriverSharingStrategy, GitHubUsers> in
              self.page = 1
              return self.network.searchGitHubUsers(login: s, page: self.page)
           })
        
        input.searchAction.filter { !$0.isEmpty }.skip(1).debounce(DispatchTimeInterval.milliseconds(500)).distinctUntilChanged().asObservable()
        .bind(to: keyword).disposed(by: disposeBag)
        
       //下拉结果序列
       let headerRefreshData = input.headerRefresh
           .startWith(()) //启动时候加载一次数据
           .flatMapLatest({ s -> SharedSequence<DriverSharingStrategy, GitHubUsers> in
              self.page = 1
            return self.network.searchGitHubUsers(login: self.keyword.value, page: self.page)
           })
        
       //上拉结果序列
       let footerRefreshData = input.footerRefresh
           .flatMapLatest({ s -> SharedSequence<DriverSharingStrategy, GitHubUsers> in
              self.page += 1
              return self.network.searchGitHubUsers(login: self.keyword.value, page: self.page)
           })
       
       searchData.drive(onNext: { items in
           self.tableData.accept(items.items)
       }).disposed(by: self.disposeBag)
        
       //下拉刷新时，直接将查询到的结果替换原数据
       headerRefreshData.drive(onNext: { items in
           self.tableData.accept(items.items)
       }).disposed(by: self.disposeBag)
        
       //上拉加载时，将查询到的结果拼接到原数据底部
       footerRefreshData.drive(onNext: { items in
           self.tableData.accept(self.tableData.value + items.items )
       }).disposed(by: self.disposeBag)
        
        return (headerRefreshData.map{ _ in true }, footerRefreshData.map{ _ in true })
    }
}
