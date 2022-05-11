//
//  UsersListViewModel.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/5.
//

import Foundation

protocol UsersListViewModelInputs {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
    func loadNextPage()
    func refreshPage()
}

protocol UsersListViewModelOutputs {
    var usersList: Observable<[UsersListItemViewModel]> { get }
    var loading: Observable<UsersListViewModelLoading> { get }
}

struct UsersListViewModelActions {
    let showUserDetail: (UserDTO) -> Void
}

protocol UsersListViewModelType {
    var inputs: UsersListViewModelInputs { get }
    var outputs: UsersListViewModelOutputs { get }
}

enum UsersListViewModelLoading {
    case none, refresh, nextPage
}
final class UsersListViewModel: UsersListViewModelType, UsersListViewModelInputs, UsersListViewModelOutputs {
    var inputs: UsersListViewModelInputs { return self }
    var outputs: UsersListViewModelOutputs { return self }

    var currentPage: Int { pages.count }
    var totalPageCount: Int = 1
    var hasMorePage: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePage ? currentPage + 1 : currentPage }
    var pages: [UsersListPage] = []

    var usersLoadTask: Cancellable? { willSet { usersLoadTask?.cancel() }}
    var query: Observable<String> = Observable("")
    private let actions: UsersListViewModelActions
    private let usecase: UsersListUseCase
    // MARK: - Outputs

    var usersList: Observable<[UsersListItemViewModel]> = Observable([])
    var loading: Observable<UsersListViewModelLoading> = Observable(.none)
    // MARK: - Init

    init(with actions: UsersListViewModelActions, usecase: UsersListUseCase) {
        self.actions = actions
        self.usecase = usecase
    }
    //MARK: - Inputs

    func viewDidLoad() {
        load(query: UsersQuery.DefaultQuery, loading: .refresh)
    }


    func didSelectItem(at indexPath: IndexPath) {

    }

    func loadNextPage() {
        guard hasMorePage, loading.value == .none else { return }
        load(query: UsersQuery(q: "swift", page: nextPage), loading: .nextPage)
    }

    func refreshPage() {
        load(query: UsersQuery(q: "swift", page: 1), loading: .refresh)
    }
    // MARK: - PRivate
    private func appendPage(_ page: UsersListPage) {
        totalPageCount = page.totalCount / 30
        pages = pages.filter { $0 != page } + [page]
        usersList.value.append(contentsOf: page.items.map{UsersListItemViewModel(user: $0)})
    }

    private func resetPage() {
        pages.removeAll()
        totalPageCount = 1
        usersList.value
            .removeAll()
    }

    private func load(query: UsersQuery, loading: UsersListViewModelLoading) {
        self.loading.value = loading
        usersLoadTask = usecase.excute(requestValue: query.toRequestValue(), completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let page):
                    if self.loading.value == .refresh {
                        self.resetPage()
                    }
                    self.appendPage(page)
                    self.outputs.loading.value = .none
                case .failure(let error):
                    print("error")
            }
        })
    }

}
