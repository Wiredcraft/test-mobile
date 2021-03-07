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

protocol GULViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
//    var input: Input { get }
//    var output: Output { get }
    
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
    
    let provider = MoyaProvider<GULService>()
    
    private let disposeBag = DisposeBag()
    
    var searchText: String = ""
    var currentPage: Int = 0
    var usersList = BehaviorRelay(value: GULUsersListModel())
    
    var output: Output?
    
    struct GULUsersListInput {
        
    }
    
    struct GULUsersListOutput {
        let usersItems: BehaviorRelay<[GULUserItemViewModel]>
        let network: PublishSubject<Bool>
        let refreshState: BehaviorRelay<GULRefreshState>
        let search: BehaviorRelay<String>
    }
    
    /*
     1.fetch users list
     2.refresh action
     3.search action
     4.keyboard action
     */
    
    @discardableResult
    func transform(input: Input) -> Output {
        let elements = BehaviorRelay<[GULUserItemViewModel]>(value: [])
        let network = PublishSubject<Bool>()
        let refreshState = BehaviorRelay<GULRefreshState>(value: .none)
        network.subscribe(onNext: { [weak self] (isReload) in
            guard let tempPage = self?.currentPage else {
                return
            }
            let page = isReload ? 1 : tempPage+1
            self?.provider.rx.request(.usersList(query: self?.searchText.isEmpty == false ? self!.searchText : "swift", page: page))
                .asObservable()
                .map(GULUsersListModel.self)
                .subscribe({ (event) in
                    switch event {
                    case let .next(model):
                        guard let list = model.items else {
                            return
                        }
                        var tempList = list.compactMap({ GULUserItemViewModel(item: $0) })
                        if !isReload {
                            tempList = elements.value+tempList
                        }
                        elements.accept(tempList)
                    case let .error(error):
                        break
                    case .completed:
                        refreshState.accept(isReload ? .endHeaderRefresh : .endFooterRefresh)
                        self?.currentPage = page
                    }
                })
        }).disposed(by: disposeBag)
        
        let search = BehaviorRelay<String>(value: "")
        search.subscribe(onNext: { [weak self] (searchStr) in
            self?.searchText = searchStr
            network.onNext(true)
        }).disposed(by: disposeBag)
        
        let op = GULUsersListOutput(usersItems: elements,
                                    network: network,
                                    refreshState: refreshState,
                                    search: search)
        output = op
        return op
    }
}
