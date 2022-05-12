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

    lazy var backButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left")?.withTintColor(.white), for: .normal)
        button.addTarget(self, action: #selector(backButtonAction(_:)), for: .touchUpInside)
        return button
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(UserDetailRepoCell.self, forCellReuseIdentifier: UserDetailRepoCell.reuseIdentifier)
        tableView.register(UserDetailSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: UserDetailSectionHeaderView.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
        bindHeaderView()
        viewModel.inputs.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    static func create(with viewModel: UserDetailViewModelType) -> UserDetailViewController {
        let view = UserDetailViewController()
        view.viewModel = viewModel
        return view
    }

    private func setupViews() {
        view.accessibilityIdentifier = AccessibilityIdentifier.userDetailViewController
        self.view.backgroundColor = .systemBackground

        view.addSubview(headerView)
        view.addSubview(backButton)
        view.addSubview(tableView)

        headerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width * 230/375)
        }
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.left.equalTo(20)
            make.width.height.equalTo(30)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottomMargin)
        }
    }

    private func bindViewModel() {
        viewModel.outputs.repoViewModels.observe(on: self) { [weak self] items in
            self?.updateItems()
        }
    }

    private func bindHeaderView() {
        headerView.followStatus.observe(on: self) { [weak self] state in
            self?.viewModel.inputs.didClickFollow(with: state)
        }
    }

    private func updateItems() {
        self.tableView.reloadData()
    }
}

extension UserDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard viewModel.outputs.repoViewModels.value.count != 0 else {
            return nil
        }
        guard let sectionHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: UserDetailSectionHeaderView.reuseIdentifier) as? UserDetailSectionHeaderView else {
            return nil
        }
        sectionHeaderView.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64)
        sectionHeaderView.backgroundColor = .clear
        return sectionHeaderView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailRepoCell.reuseIdentifier, for: indexPath) as? UserDetailRepoCell else {
            assertionFailure("Cannot dequeue reusable cell \(UserDetailRepoCell.self) with reuseIdentifier: \(UserDetailRepoCell.reuseIdentifier)")
            return UITableViewCell()
        }
        cell.bindViewModel(viewModel.outputs.repoViewModels.value[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputs.repoViewModels.value.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserDetailRepoCell.height
    }
    
}

extension UserDetailViewController: UITableViewDelegate {

}

// MARK: - Actions
extension UserDetailViewController {
    @objc func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
