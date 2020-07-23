//
//  HomeViewModel.swift
//  GithubClient
//
//  Created by Apple on 2020/7/21.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Moya

class HomeViewModel {
    
    private let disposeBag = DisposeBag()
    private var userPage = 1
    private let keyword = BehaviorRelay(value: "Swift")
    private let userSearchItems = BehaviorRelay(value: GithubSearchResult())
    private let provider: MoyaProvider<GitHub>
    
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init(_ provider: MoyaProvider<GitHub> = MoyaProvider<GitHub>()) {
        self.provider = provider
    }
}

extension HomeViewModel: ViewModelType {

    struct Input {
        let searchTextTrigger: Driver<String>
        let headerRefresh: Observable<Void>
        let footerRefresh: Observable<Void>
        let userSelection: Driver<UserSectionItem>
    }
    
    struct Output {
        let items: BehaviorRelay<[UserSection]>
        let loading: PublishSubject<Bool>
        let userDisplay: Driver<UserDetailViewModel>
    }
    
    func transform(_ input: Input) -> Output {
        let items = BehaviorRelay<[UserSection]>.init(value: [])
        let loading = PublishSubject<Bool>()
        //keyword throttling duration
        input.searchTextTrigger.debounce(DispatchTimeInterval.microseconds(500))
            .distinctUntilChanged().asObservable().bind(to: keyword).disposed(by: self.disposeBag)
        
        //where keyword change or pullRefresh, request and change data
        Observable.combineLatest(keyword,input.headerRefresh).filter { (keyword, _) -> Bool in
            return !keyword.isEmpty
        }.flatMapLatest { [weak self] (keyword,_) -> Observable<Event<GithubSearchResult>> in
            guard let self = self else { return Observable.just(RxSwift.Event.next(GithubSearchResult())) }
            
            self.userPage = 1
            return self.searchUser(self.userPage, self.keyword.value)
            }.subscribe(onNext: { [weak self] (event) in
                loading.onNext(false)
                self?.dealRequest(with: event)
                
            }, onError: { _ in
                loading.onNext(false)
            }).disposed(by: self.disposeBag)
        
        input.footerRefresh.flatMapLatest{ [weak self] () -> Observable<Event<GithubSearchResult>> in
            guard let self = self else { return Observable.just(RxSwift.Event.next(GithubSearchResult())) }
            //if no more data, return at once
            if !self.userSearchItems.value.hasNextPage {
                var result = GithubSearchResult()
                result.totalCount = self.userSearchItems.value.totalCount
                return Observable.just(Event.next(result))
            }
            self.userPage += 1
            return self.searchUser(self.userPage, self.keyword.value)
            
            }.subscribe(onNext: { [weak self] (event) in
                loading.onNext(false)
                self?.dealRequest(with: event)
            }, onError: { _ in
                loading.onNext(false)
            }).disposed(by: self.disposeBag)
        
        
        userSearchItems.map { (searchResult) -> [UserSection] in
            var sections = [UserSection]()
            let users = searchResult.items.map { (user) -> UserSectionItem in
                let cellViewModel = UserCellViewModel(user)
                return UserSectionItem.user(cellViewModel: cellViewModel)
            }
            if !users.isEmpty {
                sections.append(UserSection.users(items: users))
            }
            return sections
        }.bind(to: items).disposed(by: self.disposeBag)
        
        
        //user selection
        let userDisplay = input.userSelection.map { (item) -> UserDetailViewModel in
            switch item {
            case .user(cellViewModel: let cellViewModel):
                let viewModel = UserDetailViewModel(cellViewModel.user)
                return viewModel
            }
        }
        
        return Output(items: items, loading: loading, userDisplay: userDisplay)
    }
    
    func searchUser(_ page: Int, _ query: String) -> Observable<Event<GithubSearchResult>> {
        return self.provider.rx.request(GitHub.search(query, page))
            .map(GithubSearchResult.self, using: self.decoder)
            .asObservable().materialize()
    }
    
    func dealRequest(with event: Event<GithubSearchResult>) {
        switch event {
        case .next(let searchResult):
            if self.userPage == 1 {
                self.userSearchItems.accept(searchResult)
            } else {
                var newResult = searchResult
                newResult.items = self.userSearchItems.value.items + searchResult.items
                self.userSearchItems.accept(newResult)
            }
        case .error:
            if self.userPage > 1 {
                self.userPage -= 1
            }
            self.userSearchItems.accept(self.userSearchItems.value)
        default:
            print(event)
        }

    }

}

extension HomeViewModel {
    
    func loadHomeData() {
        self.userPage = 1
        self.searchUser(self.userPage, self.keyword.value).subscribe(onNext: { [weak self] (event) in
            switch event {
            case .next(let result):
                self?.userSearchItems.accept(result)
            default:
                print(event)
            }
        }).disposed(by: self.disposeBag)
    }
}

