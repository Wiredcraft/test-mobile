//
//  MasterViewController.swift
//  Users
//
//  Created by ivan on 2021/1/31.
//  Copyright © 2021 none. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private let refreshControl = UIRefreshControl()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.register(UserViewCell.self, forCellReuseIdentifier: "UserViewCell")
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
        tableView.tableHeaderView = searchBar
        return tableView
    }()
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.searchBarStyle = .default
        searchBar.placeholder = "Search here"
        searchBar.sizeToFit()
        return searchBar
    }()

    var viewModel: UserViewModel = UserViewModel()

    // MARK: - LiftCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstrains()
        setupViewModelBinding()
    }

    // MARK: - UI
    private func setupSubviews() {
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        refreshControl.addTarget(self, action: #selector(requestNew), for: .valueChanged)
    }

    private func setupConstrains() {
        tableView.snp.makeConstraints { make in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom)
            }
            make.left.width.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }
    }

    // MARK: - Net
    @objc
    private func requestNew() {
        viewModel.refreshData()
    }

    @objc
    private func requestMore() {
        viewModel.loadMoreData()
    }

    // MARK: - Event
    private func setupViewModelBinding() {
        viewModel.requestDidFail = { [weak self] err in
//            self?.showToast(message: err.description)
            self?.title = err
        }
        viewModel.requestDidSuccess = { [weak self] in
            self?.title = ""
        }
        viewModel.requestDidStart = { [weak self] in
            self?.title = "loading"
        }
        viewModel.usersDataDidChange = { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < viewModel.dataArr.count else {
            return UserViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserViewCell", for: indexPath) as? UserViewCell else {
            return UserViewCell()
        }
        let user = viewModel.dataArr[indexPath.row]
        cell.user = user
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < viewModel.dataArr.count else {
            return
        }
        let user = viewModel.dataArr[indexPath.row]
        viewModel.showUserDetailMainPage(user)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.dataArr.count - 1 {
            viewModel.loadMoreData()
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }

}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchTextDidChange(searchText)
    }
}
