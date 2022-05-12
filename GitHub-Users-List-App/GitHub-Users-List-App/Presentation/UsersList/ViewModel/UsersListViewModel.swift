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
    func search(with query: String)
    func updateUser(with user: User)
}

protocol UsersListViewModelOutputs {
    var usersList: Observable<[UsersListItemViewModel]> { get }
    var loading: Observable<UsersListViewModelLoading> { get }
    var loadPageError: Observable<Error?> { get }
}

struct UsersListViewModelActions {
    let showUserDetail: (User) -> Void
}

protocol UsersListViewModelType {
    var inputs: UsersListViewModelInputs { get }
    var outputs: UsersListViewModelOutputs { get }
}

enum UsersListViewModelLoading {
    case none, refresh, nextPage
}

let DefaultQuery = "Swift"

final class UsersListViewModel: UsersListViewModelType, UsersListViewModelInputs, UsersListViewModelOutputs {
    var inputs: UsersListViewModelInputs { return self }
    var outputs: UsersListViewModelOutputs { return self }

    var currentPage: Int { pages.count }
    var totalPageCount: Int = 1
    var hasMorePage: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePage ? currentPage + 1 : currentPage }
    var pages: [UsersListPage] = []

    var usersLoadTask: Cancellable? { willSet { usersLoadTask?.cancel() }}
    var query: String {
        return searchText.isEmpty ? DefaultQuery : searchText
    }
    var searchText: String = ""
    private let actions: UsersListViewModelActions?
    private let usecase: UsersListUseCase
    // MARK: - Outputs

    var usersList: Observable<[UsersListItemViewModel]> = Observable([])
    var loading: Observable<UsersListViewModelLoading> = Observable(.none)
    var loadPageError: Observable<Error?> = Observable(nil)
    // MARK: - Init

    init(with actions: UsersListViewModelActions? = nil, usecase: UsersListUseCase) {
        self.actions = actions
        self.usecase = usecase
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
                    self.outputs.loadPageError.value = error
            }
        })
    }

}
// MARK: - Inputs
extension UsersListViewModel {
    func viewDidLoad() {
        self.outputs.loading.value = .refresh
    }

    func didSelectItem(at indexPath: IndexPath) {
        guard indexPath.row < outputs.usersList.value.count  else {
            return
        }
        self.actions?.showUserDetail(outputs.usersList.value[indexPath.row].user)
    }

    func loadNextPage() {
        guard hasMorePage, loading.value == .none else { return }
        load(query: UsersQuery(q: query, page: nextPage), loading: .nextPage)
    }

    func refreshPage() {
        load(query: UsersQuery(q: query, page: 1), loading: .refresh)
    }

    func search(with query: String) {
        searchText = query
        load(query: UsersQuery(q: query, page: 1), loading: .refresh)
    }

    func updateUser(with user: User) {
        usersList.value = usersList.value.map {
            if $0.user.id == user.id {
                $0.user = user
            }
            return $0
        }
    }
}
