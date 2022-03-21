//
//  HomePageViewModel.swift
//  test_mobile
//
//  Created by Jun Ma on 2022/3/18.
//

import Foundation
import RxSwift
import Resolver
import Moya
import RxOptional
import RxRelay

protocol HomePageViewModelInput {
    // refresh manually or search text changed
    var refresh: PublishSubject<String> { get }
    // load more when scroll to the bottom
    var loadMore: PublishSubject<String> { get }
    // tap follow button
    var followTriggered: PublishRelay<IndexPath> { get }
}

protocol HomePageViewModelOutput {
    // search result or follow button tapped result
    var users: Observable<[SectionOfUsers]> { get }
    // get user for specific index
    func user(for index: IndexPath) -> User?
}

protocol HomePageViewModelType {
    var input: HomePageViewModelInput { get }
    var output: HomePageViewModelOutput { get }
}

final class HomePageViewModel: HomePageViewModelInput, HomePageViewModelOutput, HomePageViewModelType {
    var input: HomePageViewModelInput { self }
    var output: HomePageViewModelOutput { self }

    // MARK: - Input
    lazy var refresh: PublishSubject<String> = PublishSubject()
    lazy var loadMore: PublishSubject<String> = PublishSubject()
    lazy var followTriggered: PublishRelay<IndexPath> = PublishRelay()
    
    // MARK: - Output

    // new search key word
    private lazy var _requestFirst = refresh
        .flatMapLatest { [unowned self] keyword -> Observable<[User]> in
            self._page = 1
            self._users = []
            guard keyword.count > 0 else {
                return .just(self._users)
            }
            return self.searchUsers(keyword: keyword)
        }
    // for load more
    private lazy var _requestNext = loadMore
        .flatMapLatest { [unowned self] keyword -> Observable<[User]> in
            self._page += 1
            return self.searchUsers(keyword: keyword)
        }
    
    lazy var _fetchedUsers = Observable
        .merge(_requestFirst, _requestNext)
        .map { [unowned self] result -> [SectionOfUsers] in
            result.forEach { self._users.append($0) }
            return [SectionOfUsers(items: self._users)]
        }
    
    // if one follow button tapped, this will change it follow status and send back
    lazy var _updatedUsers = followTriggered
        .map { [unowned self] indexPath -> [SectionOfUsers] in
            self._users[indexPath.row].followStatusTriggered()
            return [SectionOfUsers(items: self._users)]
        }

    lazy var users: Observable<[SectionOfUsers]> = Observable
        .merge(_fetchedUsers, _updatedUsers)
        .observe(on: MainScheduler.instance)
        .share(replay: 1, scope: .whileConnected)
    
    func user(for index: IndexPath) -> User? {
        let idx = index.row
        return self._users[safe: idx]
    }
    
    // MARK: - Private
    
    fileprivate init() {}
    
    private var _page = 1
    private var _users: [User] = []
            
    private func searchUsers(keyword: String) -> Observable<[User]> {
        Network.provider.rx
            .request(.searchUsers(keyword: keyword, page: self._page))
            .map([User].self, atKeyPath: "items")
            .retry(3) // retry 3 times when error occured
            .catchAndReturn([])
            .asObservable()
    }
}

extension Resolver {
    static func registerHomePageViewModel() {
        register { HomePageViewModel() }
            .implements(HomePageViewModelType.self)
            .scope(.shared)
    }
}
