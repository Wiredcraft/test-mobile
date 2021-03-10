//
//  GDHomeViewModel.swift
//  GithubDemo
//
//  Created by 裘诚翔 on 2021/3/3.
//

import Foundation
import Moya
import RxSwift
import RxRelay


// define viewmodel interface
protocol GULViewModelProtocol {
    associatedtype Input // inpout object type
    associatedtype Output // output object type
    
    // input transform to output
    func transform(input: Input) -> Output
}

enum GULRefreshState {
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case noMoreData
}

class GULUsersListViewModel: GULViewModelProtocol {
    
    typealias Input = GULUsersListViewModel.GULUsersListInput
    
    typealias Output = GULUsersListViewModel.GULUsersListOutput
    
    private lazy var provider = GULNetwork()
    
    private lazy var disposeBag : DisposeBag = DisposeBag()
    
    var currentPage: Int = 0
    var usersList = BehaviorRelay(value: GULUsersListModel())
    
    struct GULUsersListInput {
        let search: BehaviorRelay<String>
        let headerRefresh: PublishRelay<Void>
        let footerRefresh: PublishRelay<Void>
    }
    
    struct GULUsersListOutput {
        let usersItems: BehaviorRelay<[GULUserItemViewModel]> // cell viewmdoel
        let refreshState: BehaviorRelay<GULRefreshState> // control of header refresh and footer refresh
    }
    
    @discardableResult
    func transform(input: Input) -> Output {
        let elements = BehaviorRelay<[GULUserItemViewModel]>(value: [])
        let refreshState = BehaviorRelay<GULRefreshState>(value: .none)
        
        // pull down
        // tansform headerRefresh to usersItems
        input.headerRefresh.flatMapLatest { [weak self] (Void) -> Observable<GULUsersListModel> in
            guard let self = self else {
                return Observable.just(GULUsersListModel())
            }
            self.currentPage = 1
            return self.provider.usersList(query: input.search.value, page: self.currentPage)
                    .asObservable()
        }.subscribe { (event) in
            switch event {
            case let .next(model):
                guard let list = model.items else {
                    return
                }
                let newList = list.compactMap({ GULUserItemViewModel(item: $0) })
                elements.accept(newList)
                refreshState.accept(.endHeaderRefresh)
            default:
                refreshState.accept(.endHeaderRefresh)
            }
        }.disposed(by: disposeBag)
        
        // pull up
        // tansform footerRefresh to usersItems
        input.footerRefresh.flatMapLatest { [weak self] (Void) -> Observable<GULUsersListModel> in
            guard let self = self else {
                return Observable.just(GULUsersListModel())
            }
            self.currentPage += 1
            return self.provider.usersList(query: input.search.value, page: self.currentPage)
                    .asObservable()
        }.subscribe { (event) in
            switch event {
            case let .next(model):
                guard let list = model.items else {
                    return
                }
                let newList = elements.value + list.compactMap({ GULUserItemViewModel(item: $0) })
                elements.accept(newList)
                refreshState.accept(.endFooterRefresh)
            default:
                refreshState.accept(.endFooterRefresh)
            }
        }.disposed(by: disposeBag)
        
        // transfor search to usersItems by headerRefresh
        input.search.subscribe(onNext: { (searchStr) in
            input.headerRefresh.accept(())
        }).disposed(by: disposeBag)
        
        return GULUsersListOutput(usersItems: elements,
                                    refreshState: refreshState)
    }
}
