//
//  UsersListViewController.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/5.
//


import UIKit
class UsersListViewController: UIViewController {
    var viewModel: UsersListViewModelType!

    // MARK: - Life Cycle
    static func create(with viewModel: UsersListViewModelType) -> UsersListViewController {
        let view = UsersListViewController()
        view.viewModel = viewModel
        return view
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
    }

}
