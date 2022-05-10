//
//  UsersListFlowCoordinator.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/9.
//

import Foundation
import UIKit
protocol UsersListFlowCoordinatorDependencies {
    func makeUsersListViewController(actions: UsersListViewModelActions) -> UsersListViewController

}

final class UsersListFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: UsersListFlowCoordinatorDependencies

    init(navigationController: UINavigationController,
         dependencies: UsersListFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let actions = UsersListViewModelActions(showUserDetail: showUserDetail(with:))
        let vc = dependencies.makeUsersListViewController(actions: actions)
        navigationController?.pushViewController(vc, animated: true)

    }

    // MARK: - Actions
    func showUserDetail(with user: UserDTO) {

    }

}

