//
//  UsersListDIContainer.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/7.
//

import Foundation
final class UsersListDIContainer {
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }

    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

// MARK: - Users List
    func makeUsersListViewController(actions: UsersListViewModelActions) -> UsersListViewController {
        return UsersListViewController.create(with: makeUsersListViewModel(with: actions))
    }

    func makeUsersListViewModel(with actions: UsersListViewModelActions) -> UsersListViewModelType {
        UsersListViewModel(with: actions)
    }
}

extension UsersListDIContainer: UsersListFlowCoordinatorDependencies { }
