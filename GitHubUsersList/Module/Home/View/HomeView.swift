//
//  HomeView.swift
//  GitHubUsersList
//
//  Created by YUI on 2022/3/27.
//

import UIKit

import SnapKit
import QMUIKit
import MJRefresh

class HomeView: CommonView {
    
    var hearderView : HomeHearderView!
    var tableView: QMUITableView!
    
    override func initSubviews() {
        
        // 实例化
        hearderView = HomeHearderView(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: LayoutKit.sharedInstance().adaptWidthRatio(58)))
        
        // TODO: 硬编码未处理
        tableView = QMUITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.backgroundColor = .white
        tableView.tableHeaderView = hearderView
        //        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: SafeAreaInsetsConstantForDeviceWithNotch.bottom, right: 0)
        tableView.register(HomeTabelViewCell.self, forCellReuseIdentifier:"HomeTabelViewCellFollowSelected")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:"HomeEmptyTabelViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
//        tableView.rowHeight = 64
        tableView.mj_header = MJRefreshNormalHeader()
        tableView.mj_header?.isAutomaticallyChangeAlpha = true
        tableView.mj_header?.setRefreshingTarget(self, refreshingAction: #selector(pullToRefresh))
        tableView.mj_footer = MJRefreshAutoNormalFooter()
        tableView.mj_footer?.isAutomaticallyChangeAlpha = true
        tableView.mj_footer?.setRefreshingTarget(self, refreshingAction: #selector(pullOnLoad))
        self.addSubview(tableView)
    }
    
    override func setupSubviewsConstraints() {

        tableView.snp.makeConstraints { make in
            
            make.top.left.width.height.equalToSuperview()
        }
    }
    
    @objc func pullToRefresh(){
        
//        tableView.mj_header?.isHidden = false
        self.viewDelegate?.view?(self, withEvent: ["name":"pullToRefresh"])
    }
    
    @objc func pullOnLoad(){
        
//        tableView.mj_footer?.isHidden = false
        self.viewDelegate?.view?(self, withEvent: ["name":"pullOnLoad"])
    }
}
