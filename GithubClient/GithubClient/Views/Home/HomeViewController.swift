//
//  ViewController.swift
//  GithubClient
//
//  Created by Apple on 2020/7/21.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import RxCocoa
import RxDataSources
import PullToRefreshKit

let kUserCell = "userCell"
class HomeViewController: UIViewController {

    let disposeBag = DisposeBag()
    var viewModel: HomeViewModel = HomeViewModel()

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.isTranslucent = false
        searchBar.barStyle = .default
        searchBar.searchBarStyle = .default
        searchBar.text = "Swift"
        searchBar.delegate = self
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.rowHeight = 60
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseID)
        tableView.sectionHeaderHeight = 0.1
        tableView.sectionFooterHeight = 0.1
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    lazy var freshControl: UIRefreshControl = UIRefreshControl()
    
    var footerRefreshTrigger = PublishSubject<Void>()
    var signal = PublishSubject<String>()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewInit()
        self.bindViewModel()
        self.searchBar.delegate?.searchBar?(self.searchBar, textDidChange: "Swift")
        
        self.viewModel.loadHomeData()
    }
    
    func viewInit() {
        self.edgesForExtendedLayout = [.left, .bottom, .right]
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        searchBar.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(45)
        }
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
        }
        self.tableView.refreshControl = self.freshControl
        
    }
    
    func addRefreshFooter() {
        self.tableView.configRefreshFooter(container: self) { [weak self] in
            self?.footerRefreshTrigger.onNext(())
        }
    }
    
    func bindViewModel() {
        let refreshTrigger = self.freshControl.rx.controlEvent(.valueChanged).asObservable()
        let input = HomeViewModel.Input(searchTextTrigger: searchBar.rx.text.orEmpty.asDriver(),
                                        headerRefresh: refreshTrigger,
                                        footerRefresh: self.footerRefreshTrigger,
                                        userSelection: self.tableView.rx.modelSelected(UserSectionItem.self).asDriver())
        let output = viewModel.transform(input)
        //tableViewCell configure
        let dataSource = RxTableViewSectionedReloadDataSource<UserSection>(configureCell: { dataSource, tableView, indexPath, item in
            switch item {
            case .user(cellViewModel: let cellViewModel):
                let cell = tableView.dequeueReusableCell(ofType: UserCell.self, at: indexPath)
                cell.bindViewModel(cellViewModel)
                return cell
            }
        })
        output.items.asObservable().subscribe(onNext: { [weak self](sections) in
            //set footer removed where no data
            if sections.count > 0 {
                self?.addRefreshFooter()
            } else {
                self?.tableView.switchRefreshFooter(to: .removed)
            }
        }).disposed(by: self.disposeBag)
        //bind data to datasource
        output.items.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: self.disposeBag)
        
        //end refresh animation
        output.loading.subscribe(onNext: { [weak self] (loading) in
            if !loading {
                self?.freshControl.endRefreshing()
                self?.tableView.switchRefreshFooter(to: .normal)
            }
        }).disposed(by: self.disposeBag)
        
        //show user detail
        output.userDisplay.drive(onNext: { [weak self](viewModel) in
            let userDetailVC = UserDetailViewController(viewModel)
            self?.navigationController?.pushViewController(userDetailVC, animated: true)
        }).disposed(by: self.disposeBag)
    }
    
    
    
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
}
