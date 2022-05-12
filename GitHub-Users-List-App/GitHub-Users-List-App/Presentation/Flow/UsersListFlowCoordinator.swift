//
//  UsersListFlowCoordinator.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/9.
//

import Foundation
import UIKit
/// Abstract interface of UsersListScene dependencies
protocol UsersListFlowCoordinatorDependencies {
    func makeUsersListViewController(actions: UsersListViewModelActions) -> UsersListViewController
    func makeUserDetailViewController(user: User, actions: UserDetailViewModelActions) -> UserDetailViewController

}

final class UsersListFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: UsersListFlowCoordinatorDependencies
    private weak var usersListVC: UsersListViewController?

    init(navigationController: UINavigationController,
         dependencies: UsersListFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let actions = UsersListViewModelActions(showUserDetail: showUserDetail(with:))
        let vc = dependencies.makeUsersListViewController(actions: actions)
        usersListVC = vc
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Actions
    /// Presenting UserDetailViewController with user
    /// - Parameter user: a user object
    func showUserDetail(with user: User) {
        let actions = UserDetailViewModelActions(followUser: followUser(witn:))
        let vc = dependencies.makeUserDetailViewController(user: user, actions: actions)

        navigationController?.pushViewController(vc, animated: true)
    }

    func followUser(witn user: User) {
        usersListVC?.updateUser(with: user)
    }

}

