//
//  GitHupUserDetailController.swift
//  CJWProject
//
//  Created by Joy Cheng on 2022/3/31.
//

import UIKit

class GitHupUserDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var dataArray:[GitHupUserListModel] = []
    public var name: String?
    private lazy var tableView = {
        UITableView().then {
            $0.delegate = self
            $0.dataSource = self
            $0.register(GitHupUserListCell.classForCoder(), forCellReuseIdentifier: GitHupUserListCell.reuseIdentifier)
            $0.register(GitHupUserDetailHeaderCellView.self, forHeaderFooterViewReuseIdentifier: GitHupUserDetailHeaderCellView.reuseIdentifier)
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
            if #available(iOS 11.0, *) {
                $0.contentInsetAdjustmentBehavior = .never
            }
            $0.backgroundColor = .white
        }
    }()
    // MARK:initTableView
    private func initTableView() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(-5)
            maker.leading.bottom.trailing.equalToSuperview()
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    // MARK:viewCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        FetchGitHupUserDetailSource()
        view.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarView?.backgroundColor = UIColor(hex: "#1A1A1A")
    }
    // MARK:getDetailData
    private func FetchGitHupUserDetailSource() {
        if let _ = name {
            getDetailData()
        }
    }
    // MARK:headerFooterView
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 290.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: GitHupUserDetailHeaderCellView.reuseIdentifier) as!GitHupUserDetailHeaderCellView
        if (dataArray.count != 0) {
            let model = dataArray[section]
            headerView.updateHeaderView(with: model.owner)
        }
        return headerView
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
        let model = dataArray[indexPath.row]
        cell?.configCellValue(model: model, cellStyle: FollowCellStyle.followDetail)
        return cell!
    }
    // MARK:UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

extension GitHupUserDetailController {
    private func getDetailData() {
        self.view.makeToast(toastMessager)
        GitHupUserDetailData.getDetailData(name: name ?? "") { dataSource in
            self.dataArray = (dataSource as! GitHupUserDetailSource).followedItems
            print(self.dataArray.count)
            self.tableView.reloadData()
            self.view.hideToast()
        }
    }
}



