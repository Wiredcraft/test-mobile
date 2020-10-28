//
//  ViewController.swift
//  GithubUsersList
//
//  Created by Rusty on 2020/10/26.
//

import UIKit
import SnapKit

class UsersListViewController: UIViewController {
  
  private let search = Search()
  private var currentSearchText = "swift"
  
  lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar(frame: CGRect.zero)
    searchBar.placeholder = "Search for github user"
    searchBar.text = "swift"
    searchBar.sizeToFit()
    searchBar.delegate = self
    return searchBar
  }()
  
  lazy var tableView: UITableView = {
    let tableView = UITableView(frame: CGRect.zero)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.keyboardDismissMode = .interactive
    let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 60))
    footerView.backgroundColor = .none
    tableView.tableFooterView = footerView
    
    tableView.register(UserCell.self, forCellReuseIdentifier: CellIdentifiers.userCell)
    tableView.register(NoResultCell.self, forCellReuseIdentifier: CellIdentifiers.noResultCell)
    tableView.register(LoadingCell.self, forCellReuseIdentifier: CellIdentifiers.loadingCell)
    return tableView
  }()
  
  

  override func viewDidLoad() {
    super.viewDidLoad()
    // Setup view
    view.backgroundColor = .white
    navigationItem.title = "Github Users List"
    // Setup searchBar
    view.addSubview(searchBar)
    searchBar.snp.makeConstraints { (make) in
      make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
      make.height.equalTo(self.searchBar.frame.height)
    }
    // Setup tableView
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.top.equalTo(self.searchBar.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshWithCurrentSearchText(sender:)), for: .valueChanged)
    tableView.refreshControl = refreshControl
    let footerView = FooterView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 60))
    tableView.tableFooterView = footerView
    
    
    performSearch(shouldRealTime: false, page: 1)
  }
  
  func performSearch(shouldRealTime: Bool, page: Int, refresh: Bool = false, searchText: String? = nil) {
    if searchText != nil && searchText != "" {
      currentSearchText = searchText!
    } else if searchBar.text != "" {
      currentSearchText = searchBar.text!
    }
    search.performSearch(for: searchText ?? searchBar.text!, page: page, refresh: refresh) { success in
      self.tableView.refreshControl?.endRefreshing()
      self.tableView.tableFooterView?.backgroundColor = .none
      self.footerView()!.currentState = (self.search.userArray.total_count == self.search.userArray.users.count && self.search.state != .noResults) ? .noMoreResults : .hiding
      if !success {
        self.showNetworkError()
      }
      //if page == 1 {
        self.tableView.reloadData()
      //} else {
        //let indexPaths = calculateIndexPathsToAdd(userArray: self.search.userArray, page: page)
        //self.tableView.insertRows(at: indexPaths, with: .none)
      //}
    }
    if search.state != .loadingForNextPage && search.state != .loadingRefresh {
      tableView.reloadData()
    }
    if search.state != .loadingForNextPage {
      footerView()!.currentState = .hiding
    }
    if !shouldRealTime {
      searchBar.resignFirstResponder()
    }
    
  }
  
  @objc func refreshWithCurrentSearchText(sender: UIRefreshControl) {
    sender.beginRefreshing()
    //search.resetUserArray()
    performSearch(shouldRealTime: false, page: 1, refresh: true, searchText: currentSearchText)
  }
  
  func showNetworkError() {
    let alert = UIAlertController(
      title: "Error",
      message: "There was an error accessing the internet.",
      preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  func footerView() -> FooterView? {
    return tableView.tableFooterView as? FooterView
  }

}

extension UsersListViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    search.resetUserArray()
    performSearch(shouldRealTime: false, page: 1)
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    search.resetUserArray()
    performSearch(shouldRealTime: true, page: 1)
  }
}

extension UsersListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch search.state {
    case .notSearchedYet:
      return 0
    case .loading:
      return 1
    case .noResults:
      return 1
    case .hasResults, .loadingForNextPage, .loadingRefresh:
      return search.userArray.users.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch search.state {
      case .notSearchedYet:
        fatalError("Fatal Error")
      case .loading:
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.loadingCell, for: indexPath) as! LoadingCell
        cell.indicator.startAnimating()
        return cell
      case .noResults:
        return tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.noResultCell,for: indexPath)
    case .hasResults, .loadingForNextPage, .loadingRefresh:
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.userCell,for: indexPath) as! UserCell
      let user = search.userArray.users[indexPath.row]
        cell.configure(for: user)
        return cell
    }
  }
  
  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    switch search.state {
    case .notSearchedYet, .loading, .noResults:
      return nil
    case .hasResults, .loadingForNextPage, .loadingRefresh:
      return indexPath
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    switch search.state {
    case .notSearchedYet, .loading, .noResults:
      break
    case .hasResults, .loadingForNextPage, .loadingRefresh:
      let userDetailController = UserDetailViewController()
      userDetailController.urlString = search.userArray.users[indexPath.row].html_url ?? "https://github.com/swift"
      self.navigationController?.pushViewController(userDetailController, animated: true)
    }
    
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch search.state {
    case .notSearchedYet, .loading, .noResults:
      return tableView.frame.height - 20
    case .hasResults, .loadingForNextPage, .loadingRefresh:
      return 80
    }
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    switch search.state {
    case .notSearchedYet, .loading, .noResults, .hasResults, .loadingRefresh:
      return 0.01
    default:
      return 60
    }
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let height = scrollView.frame.size.height
    let contentYoffset = scrollView.contentOffset.y
    let distanceFromBottom = scrollView.contentSize.height - contentYoffset
    if distanceFromBottom < height {
      
      let userArray = search.userArray
      if (userArray.total_count - userArray.users.count > 0) && search.state == .hasResults && footerView()!.currentState == .hiding {
        footerView()!.currentState = .loading
        performSearch(shouldRealTime: false, page: userArray.users.count / 30 + 1)
      } else if (userArray.total_count == userArray.users.count) && search.state == .hasResults && footerView()!.currentState != .loading {
        footerView()!.currentState = .noMoreResults
      }
    }
  }
  
  
}
