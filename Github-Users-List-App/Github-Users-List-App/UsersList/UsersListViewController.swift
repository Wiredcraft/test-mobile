//
//  UsersListViewController.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/5.
//


import UIKit
class UsersListViewController: UITableViewController {
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
        setupViews()
        viewModel.inputs.loadData()
    }

    private func setupViews() {
        tableView.estimatedRowHeight = UsersListCell.height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UsersListCell.self, forCellReuseIdentifier: UsersListCell.reuseIdentifier)
    }
}

extension UsersListViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersListCell.reuseIdentifier, for: indexPath) as? UsersListCell else {
            assertionFailure("Cannot dequeue reusable cell \(UsersListCell.self) with reuseIdentifier: \(UsersListCell.reuseIdentifier)")
            return UITableViewCell()
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}
