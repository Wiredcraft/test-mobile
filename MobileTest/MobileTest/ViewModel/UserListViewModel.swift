//
//  UserListViewModel.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/26.
//

import RxSwift
import RxCocoa



final class UserListViewModel {
    
    /// input

    let searchAction: Driver<String>
    
    let headerRefresh: Driver<()>
    
    let footerRefresh: Driver<()>
    
    var endHeaderRefreshing: Driver<Bool>?
    
    var endFooterRefreshing: Driver<Bool>?
            
    /// output
    ///
    var searchResults = BehaviorRelay<UsersResponse>(value: [])
    
    /// networkservice
    private let usersService: UsersService
    
    /// bag
    private let bag = DisposeBag()
    
    
    public var currentText: String?

    
    init(searchAction: Driver<String>,
         headerRefresh: Driver<()>,
         footerRefresh: Driver<()>,
         usersService: UsersService) {
        self.searchAction = searchAction
        self.usersService = usersService
        self.headerRefresh = headerRefresh
        self.footerRefresh = footerRefresh
        
        process()
        
    }
    
    func process(){
        /// search
        let searchDriver =  searchAction
            .filter{ !$0.isEmpty }
            .flatMapLatest({ searchText in
                return self.usersService.fetchUsers(q: searchText,
                                                    page: 1)
                    .asDriver(onErrorJustReturn: [])
            })
        
        searchDriver.drive(onNext:{ response in
            self.searchResults.accept(response)
        }).disposed(by: bag)
        
        
        // clean
        let cleanResult = searchAction.filter{ $0.isEmpty }.map{ _ in Void() }
        
        // clean merge
        let cleanDriver = Driver.merge(
            searchDriver.map{ $0 },
            cleanResult.map{[]}
        )
        
        cleanDriver.drive(onNext:{ response in
            self.searchResults.accept(response)
        }).disposed(by: bag)
        
        
        // pull refresh
        searchAction.filter{ !$0.isEmpty }.drive(onNext:{ text in
            self.currentText = text
        }).disposed(by: bag)
        
        let headerRefreshData = self.headerRefresh.flatMapLatest { _ in
            return self.usersService.fetchUsers(q: self.currentText ?? "swift",
                                                page: 1)
                .asDriver(onErrorJustReturn: [])
        }
        
        // refresh header data accept
        
        headerRefreshData.drive(onNext: { data in
            self.searchResults.accept(data)
        }).disposed(by: bag)
        
        // refresh header state ending
        
        self.endHeaderRefreshing = headerRefreshData.map({ _ in
            return true
        })
        
        // footer refresh
        let footerRefreshData = self.footerRefresh.flatMapLatest { _ in
            return self.usersService.fetchUsers(q: self.currentText ?? "swift",
                                                page: 1)
                .asDriver(onErrorJustReturn: [])
        }
        
        /// refresh data accept
        
        footerRefreshData.drive(onNext: { data in
            self.searchResults.accept(data)
        }).disposed(by: bag)
        
        // refresh header state ending
        
        self.endFooterRefreshing = footerRefreshData.map({ _ in
            return true
        })
    }
}

