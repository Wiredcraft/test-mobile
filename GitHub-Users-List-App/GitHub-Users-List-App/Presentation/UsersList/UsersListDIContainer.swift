//
//  UsersListDIContainer.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/7.
//

import Foundation
import UIKit
final class UsersListDIContainer {
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }

    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    // MARK: - UseCase
    func makeUsersListUseCase() -> UsersListUseCase {
        return DefaultUserListUseCase(usersListRepository: makeUsersRepository())
    }
    // MARK: - Repositoried
    func makeUsersRepository() -> UsersRepository {
        return DefaultUsersRepository(dataTransferService: dependencies.apiDataTransferService)
    }

    // MARK: - Users List
    func makeUsersListViewController(actions: UsersListViewModelActions) -> UsersListViewController {
        return UsersListViewController.create(with: makeUsersListViewModel(with: actions))
    }

    func makeUsersListViewModel(with actions: UsersListViewModelActions) -> UsersListViewModelType {
        UsersListViewModel(with: actions, usecase: makeUsersListUseCase())
    }
    // MARK: - Flow coordinator
    func makeUsersListFlowCoordinator(navigationController: UINavigationController) -> UsersListFlowCoordinator {
        return UsersListFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension UsersListDIContainer: UsersListFlowCoordinatorDependencies { }
