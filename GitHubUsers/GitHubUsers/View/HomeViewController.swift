//
//  HomeViewController.swift
//  GitHubUsers
//
//  Created by lusheng tan on 2019/4/10.
//  Copyright © 2019 lusheng tan. All rights reserved.
//

import UIKit
import Moya
import Result
import RxSwift
import RxCocoa
import NSObject_Rx
import Kingfisher
import MJRefresh
import PKHUD

class HomeViewController: UIViewController {
    var viewModel = HomeViewModel()
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController?
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // build UI
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersTableViewCell")
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            HUD.show(.progress)
            // page numbering is 1-based
            self?.viewModel.page.accept(1)
        })
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            if let pageIndex = self?.viewModel.page.value {
                HUD.show(.progress)
                self?.viewModel.page.accept(pageIndex + 1)
            }
            
        })
        // search bar
        if let searchUsersViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchUsersViewController") as? SearchUsersViewController {
            searchController = UISearchController(searchResultsController: searchUsersViewController)
            self.definesPresentationContext = true
            if #available(iOS 11.0, *) {
                navigationItem.searchController = searchController;
                navigationItem.hidesSearchBarWhenScrolling = false
                searchController?.searchBar.placeholder = "Search News"
            } else {
                tableView.tableHeaderView = searchController?.searchBar
            }
            searchController?.searchBar.rx.text.bind(to: searchUsersViewController.viewModel.keyWord).disposed(by: rx.disposeBag)
        }
        
        // bind viewModel and view
        viewModel.result.subscribe(onNext: { [weak self] result in
            HUD.hide()
            self?.tableView.mj_header.endRefreshing()
            self?.tableView.mj_footer.endRefreshing()
        }).disposed(by: rx.disposeBag)
        
        viewModel.users.bind(to: tableView.rx.items) { (tableView, row, user) in
            if let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell") as? UsersTableViewCell {
                cell.lblName.text = user.login
                cell.lblDetailURL.text = user.html_url
                cell.imgvwAvatar.kf.setImage(with: URL(string: user.avatar_url))
                return cell
            } else {
                return UITableViewCell()
            }
            }.disposed(by: rx.disposeBag)
        tableView.rx.modelSelected(User.self).subscribe(onNext: { user in
            let detailViewController = DetailViewController()
            detailViewController.strURL = user.html_url
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }).disposed(by: rx.disposeBag)
        //
        viewModel.page.accept(1)
    }
}
