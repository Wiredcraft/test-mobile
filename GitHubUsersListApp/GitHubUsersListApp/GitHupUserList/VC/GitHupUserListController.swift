//
//  FollowListController.swift
//  CJWProject
//
//  Created by Joy Cheng on 2022/3/31.
//

import UIKit
import SnapKit
import MJRefresh
import Toast

class GitHupUserListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var dataArray:[GitHupUserListModel] = []
    private let headerView = MJRefreshNormalHeader()
    private let footerView = MJRefreshAutoNormalFooter()
    private var searchText = ""
    private var pageValue = 1
    private lazy var tableView = {
        UITableView().then {
            $0.delegate = self
            $0.dataSource = self
            $0.register(GitHupUserListCell.classForCoder(), forCellReuseIdentifier: GitHupUserListCell.reuseIdentifier)
            $0.register(GitHupUserListSearchHeaderView.self, forHeaderFooterViewReuseIdentifier: GitHupUserListSearchHeaderView.reuseIdentifier)
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
        }
    }()
    // MARK:viewCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initTableViewModel()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarView?.backgroundColor = .white
    }
    // MARK:initTableView
    private func initTableView() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        initHeadRefresh()
        initFootRefresh()
    }
    // MARK:initRefresh
    private func initHeadRefresh() {
        headerView.setTitle(headPullText, for: .refreshing)
        headerView.setRefreshingTarget(self, refreshingAction: #selector(headRefresh))
        tableView.mj_header = headerView
        tableView.mj_header?.ignoredScrollViewContentInsetTop = 80;
    }
    private func initFootRefresh() {
        footerView.setTitle(footLoadText, for: .refreshing)
        footerView.setRefreshingTarget(self, refreshingAction: #selector(footRefresh))
        footerView.isAutomaticallyRefresh = false
        tableView.mj_footer  = footerView
    }
    @objc private  func headRefresh() {
        pageValue = 1
        getListData(loadStyle: .refresh)
    }
    @objc private func footRefresh() {
        pageValue += 1
        getListData(loadStyle: .pull)
    }
    // MARK:initDataArray
    private func initTableViewModel() {
        getListData(loadStyle: .refresh)
    }
    // MARK:headerFooterView
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: GitHupUserListSearchHeaderView.reuseIdentifier) as!GitHupUserListSearchHeaderView
        headerView.delegate = self
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    // MARK:UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GitHupUserListCell.reuseIdentifier) as? GitHupUserListCell
        cell?.delegate  = self
        let model = dataArray[indexPath.row]
        cell?.configCellValue(model: model, cellStyle: FollowCellStyle.followList)
        return cell!
    }
    // MARK:UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataArray[indexPath.row]
        let detailVC = GitHupUserDetailController()
        detailVC.name = model.login
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension GitHupUserListController: GitHupUserListSearchHeaderViewDelegate {
    func searchFollowList(forKeyWorld: String) {
        searchText = forKeyWorld
        getListData(loadStyle: .refresh)
    }
}

extension GitHupUserListController {
    private func getListData(loadStyle: LoadStyle) {
        self.view.makeToast(toastMessager)
        switch loadStyle {
        case .pull:
            FetchGitHupUserListData.getListData(searchText: searchText, pageValue: pageValue) {  [weak self] items in
                self?.dataArray += items as! [GitHupUserListModel]
                self?.tableView.reloadData()
                self?.footerView.endRefreshing()
                self?.view.hideToast()
            }
        case .refresh:
            FetchGitHupUserListData.getListData(searchText: searchText, pageValue: pageValue) {  [weak self] items in
                self?.dataArray = items as! [GitHupUserListModel]
                self?.tableView.reloadData()
                self?.headerView.endRefreshing()
                self?.view.hideToast()
            }
        }
    }
}

extension GitHupUserListController: GitHupUserListButtonDelegate {
    func clickFollowButton(sender: UIButton) {
        let pointInView: CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
        let indexPath: IndexPath = self.tableView.indexPathForRow(at: pointInView) ?? IndexPath.init(row: 0, section: 0)
        let model:GitHupUserListModel = self.dataArray[indexPath.row] as GitHupUserListModel
        model.isFollowed  = !model.isFollowed
        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }
}

