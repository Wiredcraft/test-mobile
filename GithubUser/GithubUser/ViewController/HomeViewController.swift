//
//  ViewController.swift
//  GithubUser
//
//  Created by zhaitong on 2022/3/22.
//

import UIKit
import SnapKit
import MJRefresh
import SVProgressHUD


class HomeViewController: UIViewController {

    lazy var tableView: UITableView = {
        var tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = .init(top: 15, left: 0, bottom: 0, right: 0);
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    lazy var searchView: HomeSearchView = {
        var searchView = HomeSearchView.init()
        searchView.delegate = self
        return searchView
    }()
    
    var dataSource: Array<ListItem> = .init()
    var userPage: Int = 1 //当前第几页数据
    var searchText: String = ""
    var selIndexPath: IndexPath? //选中了第几个用户
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        makeLayout();
    }
    
    func initUI() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupMJRefresh()
        view.addSubview(tableView)
        view.addSubview(searchView)
    }
    
    func setupMJRefresh() {
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(onRefreshData))
        //MJRefreshBackNormalFooter
        tableView.mj_footer = MJRefreshBackNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(onLoadMoreData))
        tableView.mj_header?.ignoredScrollViewContentInsetTop = 10
    }
    
    func makeLayout(){
        searchView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(18)
            make.height.equalTo(40)
        }
        tableView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(searchView.snp.bottom).offset(5)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    @objc
    func onRefreshData() {
        userPage = 1
        loadData()
    }
    
    @objc
    func onLoadMoreData() {
        userPage += 1
        loadData()
    }
    
    func loadData(){
        ApiService.getList(keyWord: searchText, page: userPage) {[weak self] resp in
            
            self?.tableView.mj_header?.endRefreshing()
            self?.tableView.mj_footer?.endRefreshing()
            
            switch(resp){
            case .Success(let data):
                if (self?.userPage == 1) {
                    self?.dataSource.removeAll()
                }
                self?.dataSource.append(contentsOf: data?.items ?? Array.init())
                self?.tableView.reloadData()
                
                if (data?.incomplete_results ?? false) {
                    self?.tableView.mj_footer?.endRefreshingWithNoMoreData()
                } else {
                    self?.tableView.mj_footer?.resetNoMoreData()
                }
                
                if (data?.items?.count ?? 0) == 0 {
                    SVProgressHUD.showInfo(withStatus: "没有更多数据了")
                    self?.tableView.mj_footer?.endRefreshingWithNoMoreData()
                }
                break
            case .Error(_, let msg):
                SVProgressHUD.showInfo(withStatus: msg)
                break
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if selIndexPath != nil {
            self.tableView.reloadRows(at: [selIndexPath!], with: .none)
            selIndexPath = nil
        }
    }
}

extension HomeViewController: SearchViewDelegate {
    func searchViewShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        self.searchText = textField.text ?? ""
        self.tableView.mj_header?.beginRefreshing()
        return true
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UserTableViewCell.self)) as? UserTableViewCell
        if(cell == nil){
            cell = UserTableViewCell.init(style: .default, reuseIdentifier: NSStringFromClass(UserTableViewCell.self))
            cell?.selectionStyle = .none
        }
        let data = dataSource[indexPath.row]
        cell?.data = data
        cell?.followCallback = {[weak self] data in
            data?.isFollow = !(data?.isFollow ?? true)
            self?.tableView.reloadRows(at: [indexPath], with: .none)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailViewController.init(data: self.dataSource[indexPath.row]), animated: true)
        selIndexPath = indexPath
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count;
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return .init()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return .init()
    }
    
}

