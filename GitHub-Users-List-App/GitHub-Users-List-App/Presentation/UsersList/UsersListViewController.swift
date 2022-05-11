//
//  UsersListViewController.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/5.
//


import UIKit
import SnapKit
class UsersListViewController: UIViewController {
    var viewModel: UsersListViewModelType!

    private var searchController: UISearchController = UISearchController(searchResultsController: nil)

    lazy var searchBar: SearchBar = {
        let searchBar = SearchBar(frame: .zero)
        return searchBar
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(UsersListCell.self, forCellReuseIdentifier: UsersListCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return control
    }()

    var nextPageLoadingActivityIndicator: UIActivityIndicatorView?
    // MARK: - Life Cycle
    
    static func create(with viewModel: UsersListViewModelType) -> UsersListViewController {
        let view = UsersListViewController()
        view.viewModel = viewModel
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        hideKeyboardWhenTappedAround()
        setupStyle()
        bindSearchBar()
        bindViewModel()
        viewModel.inputs.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        hideKeyboardWhenTappedAround()
    }

    private func setupStyle() {
        searchBar.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(topBarHeight)
        }
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(topBarHeight)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottomMargin)
        }
    }

    func bindViewModel() {
        viewModel.outputs.usersList.observe(on: self) { [weak self] users in
            self?.updateItems()
        }
        viewModel.outputs.loading.observe(on: self) { [weak self] loading in
            self?.updateLoading(loading)
        }
    }
    func bindSearchBar() {
        searchBar.searchText.observe(on: self) { [weak self] text in
            print("received : \(text)")
            self?.viewModel.inputs.search(with: text == "" ? "swift" : text)
        }
    }

    func updateItems() {
        reload()
    }

    func reload() {
        tableView.reloadData()
    }

    func updateLoading(_ loading: UsersListViewModelLoading) {
        switch loading {
            case .none:
                tableView.tableFooterView = nil
                refreshControl.endRefreshing()
            case .refresh:
                refreshControl.beginRefreshing()
            case .nextPage:
                nextPageLoadingActivityIndicator?.removeFromSuperview()
                nextPageLoadingActivityIndicator = makeActivityIndicator(size: .init(width: tableView.frame.width, height: 44))
                tableView.tableFooterView = nextPageLoadingActivityIndicator
        }
    }

}

// MARK: - UITableView DataSource
extension UsersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersListCell.reuseIdentifier, for: indexPath) as? UsersListCell else {
            assertionFailure("Cannot dequeue reusable cell \(UsersListCell.self) with reuseIdentifier: \(UsersListCell.reuseIdentifier)")
            return UITableViewCell()
        }
        cell.bindViewModel(viewModel.outputs.usersList.value[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputs.usersList.value.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UsersListCell.height
    }
}
// MARK: - UITableView Delegate
extension UsersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.outputs.usersList.value.count - 1 {
            viewModel.inputs.loadNextPage()
        }
    }
}

// MARK: - Actions
extension UsersListViewController {
    @objc func refresh() {
        viewModel.inputs.refreshPage()
    }
}







