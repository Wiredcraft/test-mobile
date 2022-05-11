//
//  UserDetailViewController.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/10.
//

import Foundation
import UIKit
import SnapKit
class UserDetailViewController: UIViewController, UIGestureRecognizerDelegate {
    var viewModel: UserDetailViewModelType!

    lazy var headerView: UserDetailHeaderView = {
        let headerView = UserDetailHeaderView(with: viewModel.user)
        return headerView
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(UserDetailRepoCell.self, forCellReuseIdentifier: UserDetailRepoCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }

    static func create(with viewModel: UserDetailViewModelType) -> UserDetailViewController {
        let view = UserDetailViewController()
        view.viewModel = viewModel
        return view
    }

    private func setupViews() {
        self.view.backgroundColor = .systemBackground

        view.addSubview(headerView)
        view.addSubview(tableView)

        headerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width * 230/375)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottomMargin)
        }
    }
}

extension UserDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailRepoCell.reuseIdentifier, for: indexPath) as? UserDetailRepoCell else {
            assertionFailure("Cannot dequeue reusable cell \(UserDetailRepoCell.self) with reuseIdentifier: \(UserDetailRepoCell.reuseIdentifier)")
            return UITableViewCell()
        }
//        cell.bindViewModel(viewModel.outputs.usersList.value[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserDetailRepoCell.height
    }
    
}

extension UserDetailViewController: UITableViewDelegate {

}
