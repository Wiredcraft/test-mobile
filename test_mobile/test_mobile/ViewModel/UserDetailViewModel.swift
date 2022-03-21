//
//  UserDetailViewModel.swift
//  test_mobile
//
//  Created by Jun Ma on 2022/3/18.
//

import Foundation
import RxSwift
import Resolver
import RxRelay

protocol UserDetailViewModelInput {
    var followTriggerd: PublishRelay<Void> { get }
    var fetchRepos: PublishRelay<Void> { get }
}

protocol UserDetailViewModelOutput {
    var avatarUrl: String? { get }
    var userName: String? { get }
    var followed: Observable<String> { get }
    var repos: Observable<[SectionOfRepo]> { get }
}

protocol UserDetailViewModelType {
    var input: UserDetailViewModelInput { get }
    var output: UserDetailViewModelOutput { get }
}

final class UserDetailViewModel: UserDetailViewModelInput, UserDetailViewModelOutput, UserDetailViewModelType {
    var input: UserDetailViewModelInput { self }
    var output: UserDetailViewModelOutput { self }
    
    // MARK: - Input
    lazy var followTriggerd: PublishRelay<Void> = PublishRelay()
    lazy var fetchRepos: PublishRelay<Void> = PublishRelay()
    
    // MARK: - Output
    lazy var avatarUrl: String? = _user?.avatarUrl
    lazy var userName: String? = _user?.login
    lazy var followed: Observable<String> = followTriggerd
        .flatMap { [unowned self] _ -> Observable<String> in
            guard var user = self._user else {
                return .empty()
            }
            
            self._homeVM.input.followTriggered.accept(self._index)
            user.followStatusTriggered()
            return .just(user.followedDescription)
        }
        .startWith(_user != nil ? _user!.followedDescription : "")
        .observe(on: MainScheduler.instance)
        .share(replay: 1, scope: .whileConnected)
    
    lazy var repos: Observable<[SectionOfRepo]> = fetchRepos
        .flatMapLatest { [unowned self] _ -> Observable<[SectionOfRepo]> in
            guard let userName = self._user?.login else {
                return .empty()
            }
            return Network.provider.rx
                .request(.repos(user: userName))
                .map([Repository].self)
                .retry(3) // retry 3 times when error occured
                .catchAndReturn([])
                .asObservable()
                .map { repos in
                    [SectionOfRepo(items: repos)]
                }
        }
        .observe(on: MainScheduler.instance)
        .share(replay: 1, scope: .whileConnected)
    
    // MARK: - Private
    fileprivate init(homePageViewModel: HomePageViewModelType, index: IndexPath) {
        self._homeVM = homePageViewModel
        self._index = index
        self._user = homePageViewModel.output.user(for: index)
    }
    
    private let _homeVM: HomePageViewModelType
    private let _index: IndexPath
    private var _user: User?
}

extension Resolver {
    static func registerUserDetailViewModel() {
        register { _, args in
            UserDetailViewModel(homePageViewModel: resolve(), index: args())
        }
        .implements(UserDetailViewModelType.self)
        .scope(.graph)
    }
}
