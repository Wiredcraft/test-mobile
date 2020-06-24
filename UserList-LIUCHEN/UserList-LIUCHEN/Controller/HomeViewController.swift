//
//  HomeViewController.swift
//  UserList-LIUCHEN
//
//  Created by LC on 2020/6/23.
//  Copyright © 2020 LC. All rights reserved.
//

import UIKit

let apiManager = APIManager()
class HomeViewController: UIViewController {
    struct CellIdentifier {
        static let userlistCell = "UserlistCell"
        static let emptyCell    = "EmptyCell"
    }
    struct SegueIdentifier {
        static let showdetail = "showdetail"
    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var userListTableView: UITableView!
    var currentPage = 1
    var itemArray: Array<Item> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.placeholder = NSLocalizedString("input the keyword", comment: "placeholder")
        initTableView()
    }
   
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.showdetail {
            let detailViewController = segue.destination as! DetailViewController
            let indexPath = sender as! IndexPath
            detailViewController.detail = itemArray[indexPath.row]
        }
    }
}

// MARK: - Load Data
extension HomeViewController {
    private func loadData(withname name: String) {
        apiManager.performSearchUser(withName: name) { (success, result) in
            if success {
                self.userListTableView.refreshControl?.endRefreshing()
                self.itemArray.removeAll()
                self.itemArray = result.items!
                self.userListTableView.reloadData()
            }
        }
    }
    private func loadMoreData(withname name: String, currentPage: Int) {
        searchBar.resignFirstResponder()
        guard !itemArray.isEmpty, !name.isEmpty else { return }
        apiManager.performSearchUser(withName: name, currentPage: currentPage) { (success, result) in
            if success {
                self.currentPage += 1
                self.itemArray.append(contentsOf: result.items!)
                self.userListTableView.reloadData()
            }
        }
    }
    
    private func performSearch(searchText: String) {
        if !searchText.isEmpty {
              loadData(withname: searchText)
        }else {
            userListTableView.refreshControl?.endRefreshing()
            userListTableView.reloadData()
        }
    }
}
// MARK: - Initialize
extension HomeViewController {
    private func initTableView() {
        userListTableView.contentInset = UIEdgeInsets(top: 22, left: 0, bottom: 0, right: 0)
        let userlistCell = UINib(nibName: CellIdentifier.userlistCell, bundle: nil)
        let emptyCell    = UINib(nibName: CellIdentifier.emptyCell, bundle: nil)
        userListTableView.register(userlistCell, forCellReuseIdentifier: CellIdentifier.userlistCell)
        userListTableView.register(emptyCell, forCellReuseIdentifier: CellIdentifier.emptyCell)

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        userListTableView.refreshControl = refreshControl
        searchBar.becomeFirstResponder()
    }
}
// MARK: - UITableView Datasource, Delegate
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.isEmpty ? 1 : itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if itemArray.isEmpty {
            return tableView.dequeueReusableCell(withIdentifier: CellIdentifier.emptyCell, for: indexPath)
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.userlistCell, for: indexPath) as! UserlistCell
            let item: Item = itemArray[indexPath.row]
            cell.prepareData(for: item)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        //Refresh single row
        var item = itemArray[indexPath.row]
        if !(item.isLoaded ?? false) {
            item.isLoaded = true
            itemArray[indexPath.row] = item
            let index = IndexPath(item: indexPath.row, section: 0)
            tableView.reloadRows(at: [index], with: .fade)
        }
        performSegue(withIdentifier: SegueIdentifier.showdetail, sender: indexPath)
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
       
        return indexPath
    }
}


// MARK: - Event Action
extension HomeViewController {
    @objc private func refreshData() {
        performSearch(searchText: searchBar.text!)
    }
}

// MARK: - ScrollView Delegate
extension HomeViewController {
    //Load more Data
    //Can use MJrefresh instead
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset - currentOffset <= 150 {
            loadMoreData(withname: searchBar.text!, currentPage: self.currentPage + 1)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}
// MARK: - UISearchBar Delegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        performSearch(searchText: searchBar.text!) // When button clicked
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         //performSearch(searchText: searchText!) //Real time search
    }
}
