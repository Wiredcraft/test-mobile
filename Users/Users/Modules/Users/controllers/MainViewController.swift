//
//  MasterViewController.swift
//  Users
//
//  Created by ivan on 2021/1/31.
//  Copyright © 2021 none. All rights reserved.
//

import SafariServices
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
    private var dataArr: [GithubUser] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var query: String = "" {
        didSet {
            requestUsers()
        }
    }
    private var pageIndex: Int = 1 {
        didSet {
            requestUsers()
        }
    }
    private var requestIsRunning: Bool = false
    // MARK: - LiftCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstrains()
        query = "React"
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
        pageIndex = 1
        requestUsers()
    }

    @objc
    private func requestMore() {
        pageIndex += 1
        requestUsers()
    }

    private func requestUsers() {
        guard !query.isEmpty else {
            return
        }
        requestIsRunning = true
        APIClient.shared.getUsers(query: query, page: pageIndex) { result in
            self.requestIsRunning = false
            self.refreshControl.endRefreshing()
            switch result {
            case let .success(response):
                guard let users = response.result?.items, !users.isEmpty else {
                    return
                }
                if self.pageIndex == 1 {
                    self.dataArr.removeAll()
                }
                self.dataArr += users
            case let .error(err):
                self.showToast(message: err.description)
            }
        }
    }

    // MARK: - Event
    private func showDetail(_ url: String) {
        guard let URL = URL(string: url) else {
            return
        }
        let safarivc: SFSafariViewController
        if #available(iOS 11.0, *) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            safarivc = SFSafariViewController(url: URL, configuration: config)
        } else {
            safarivc = SFSafariViewController(url: URL, entersReaderIfAvailable: true)
        }
        present(safarivc, animated: true)
    }
}

// MARK: - UITableViewDelegate UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < dataArr.count else {
            return UserViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserViewCell", for: indexPath) as? UserViewCell else {
            return UserViewCell()
        }
        let user = dataArr[indexPath.row]
        cell.user = user
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < dataArr.count else {
            return
        }
        let user = dataArr[indexPath.row]
        showDetail(user.htmlURL)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dataArr.count - 1 {
            if !requestIsRunning {
                pageIndex += 1
            }
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

        guard !searchText.isEmpty else {
            return
        }
        self.query = ""
        self.pageIndex = 1
        NSObject.cancelPreviousPerformRequests(withTarget: requestUsers())
        DispatchQueue.mainAfter(time: 0.2) {
            self.query = searchText
        }
    }
}
