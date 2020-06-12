//
//  WCHomeViewController.swift
//  Wiredcraft
//
//  Created by codeLocker on 2020/6/10.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import ESCategory_swift

/*
 Home
*/

class WCHomeViewController: WCBaseViewController {

    /// search input view
    fileprivate var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.text = "swift"
        searchBar.placeholder = "please input here to search"
        /// for UI Test
        searchBar.accessibilityIdentifier = "com.wiredcraft.element.home.searchBar"
        return searchBar
    }()
    
    /// user list view
    fileprivate lazy var usersTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WCHomeUserCell.self, forCellReuseIdentifier: WCHomeViewController.userCellIdentifity)
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
        tableView.rowHeight = 78.0
        /// for UI Test
        tableView.accessibilityIdentifier = "com.wiredcraft.element.home.tableView"
        
        /// route to the Detail
        tableView.rx.modelSelected(WCUserModel.self).subscribe(onNext: { (user) in
            let detailVc = WCDetailViewController()
            detailVc.link = user.html_url
            detailVc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detailVc, animated: true)
            
        }).disposed(by: self.disposeBag)
        return tableView
    }()
    
    /// RxSwift recycle bag
    fileprivate static let userCellIdentifity = String(describing: WCHomeUserCell.self)
    fileprivate let disposeBag = DisposeBag()
    fileprivate var viewModel = WCHomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadUI()
        self.layout()
        self.bindViewModel()
    }
    
    //MARK: - Load_UI
    private func loadUI() {
        /// self's view top extend limit
        /// avoid the navigationbar cover some component which layout on the top
        self.edgesForExtendedLayout = [.left, .right,]
        self.view.addSubview(self.searchBar)
        self.view.addSubview(self.usersTableView)
    }
   
    private func layout() {
        self.searchBar.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
        }
        self.usersTableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.searchBar.snp.bottom)
        }
    }
}

extension WCHomeViewController {
    fileprivate func bindViewModel() {
        
        /// bind searchBar value change signal to viewModel
        /// ignore value change that Less than 1s interval
        self.viewModel.querySearchAction = self.searchBar.rx.text.orEmpty
        .throttle(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        .distinctUntilChanged()
        
        /// subscribe the search network error status
        self.viewModel.searchFail.subscribe(onNext: { [weak self] (error) in
            self?.view.es_hint(error)
        }).disposed(by: self.disposeBag)
        
        /// enable the usersTableView's refresh function
        self.viewModel.enableRefreshScrollView(self.usersTableView)
        
        /// bind the data to tableView
        let _ = self.viewModel.users.bind(to: self.usersTableView.rx.items) { [weak self] (_, row, element) in

            guard let `self` = self else {
                return WCHomeUserCell.init(style: .default, reuseIdentifier: WCHomeViewController.userCellIdentifity)
            }
            
            guard let cell = self.usersTableView.dequeueReusableCell(withIdentifier:  WCHomeViewController.userCellIdentifity) as? WCHomeUserCell else {
                /// if have no cache, need new
                return WCHomeUserCell.init(style: .default, reuseIdentifier: WCHomeViewController.userCellIdentifity)
            }
            
            cell.nickname = self.viewModel.getUserNickname(at: row)
            cell.avatar = self.viewModel.getUserAvatar(at: row)
            cell.score = self.viewModel.getUserScore(at: row)
            cell.homepage = self.viewModel.getUserHomepage(at: row)
            return cell
            
        }.disposed(by: self.disposeBag)
    }
}
