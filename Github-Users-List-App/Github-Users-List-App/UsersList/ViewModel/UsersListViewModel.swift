//
//  UsersListViewModel.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/5.
//

import Foundation
import Combine
protocol UsersListViewModelInputs {
    func viewDidLoad()
    func loadData()
    func didSelectItem(at indexPath: IndexPath)
}

protocol UsersListViewModelOutputs {
    var usersList: Observable<[UsersListItemViewModel]> { get }
}

struct UsersListViewModelActions {
    let showUserDetail: (User) -> Void
}

protocol UsersListViewModelType {
    var inputs: UsersListViewModelInputs { get }
    var outputs: UsersListViewModelOutputs { get }
}

final class UsersListViewModel: UsersListViewModelType, UsersListViewModelInputs, UsersListViewModelOutputs {
    var inputs: UsersListViewModelInputs { return self }
    var outputs: UsersListViewModelOutputs { return self }
    private let actions: UsersListViewModelActions
    private let usecase: UsersListUseCase
    init(with actions: UsersListViewModelActions, usecase: UsersListUseCase) {
        self.actions = actions
        self.usecase = usecase
    }

    // MARK: - Outputs
    var usersList: Observable<[UsersListItemViewModel]> = Observable([])
    //MARK: - Inputs
    func viewDidLoad() { }
    func loadData() {
        _ = usecase.excute(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let users):
                    self.appendUsersListPage(users)
                case .failure(let error):
                    print("error")
            }
        })
    }
    func didSelectItem(at indexPath: IndexPath) {

    }

    func appendUsersListPage(_ users: [User]) {
        usersList.value.append(contentsOf: users.map{UsersListItemViewModel(user: $0)})
    }
}
