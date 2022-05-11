//
//  UsersListDIContainer.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/7.
//

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

    func makeUserDetailUseCase() -> UserDetailUseCase {
        return DefaultUserDetailUseCase(repository: makeUserDetailRepository())
    }

    // MARK: - Repositories
    func makeUsersRepository() -> UsersRepository {
        return DefaultUsersRepository(dataTransferService: dependencies.apiDataTransferService)
    }

    func makeUserDetailRepository() -> UserDetailRepository {
        return DefaultUserDetailRepository(dataTransferService: dependencies.apiDataTransferService)
    }

    // MARK: - Users List
    func makeUsersListViewController(actions: UsersListViewModelActions) -> UsersListViewController {
        return UsersListViewController.create(with: makeUsersListViewModel(with: actions))
    }

    func makeUsersListViewModel(with actions: UsersListViewModelActions) -> UsersListViewModelType {
        UsersListViewModel(with: actions, usecase: makeUsersListUseCase())
    }

    // MARK: - User Detail
    func makeUserDetailViewController(user: User, actions: UserDetailViewModelActions) -> UserDetailViewController {
        return UserDetailViewController.create(with: makeUserDetailViewModel(with: user, actions: actions))
    }
    func makeUserDetailViewModel(with user: User, actions: UserDetailViewModelActions) -> UserDetailViewModelType {
        UserDetailViewModel(user: user, actions: actions, usecase: makeUserDetailUseCase())
    }
    
    // MARK: - Flow coordinator
    func makeUsersListFlowCoordinator(navigationController: UINavigationController) -> UsersListFlowCoordinator {
        return UsersListFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension UsersListDIContainer: UsersListFlowCoordinatorDependencies { }
