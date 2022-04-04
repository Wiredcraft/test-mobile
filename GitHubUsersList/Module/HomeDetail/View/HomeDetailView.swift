//
//  HomeDetailView.swift
//  GitHubUsersList
//
//  Created by YUI on 2022/4/1.
//

import UIKit
import QMUIKit

class HomeDetailView: CommonView {
    
    var backBtn : UIButton!
    var bgIV : UIImageView!
    var iconIV : UIImageView!
    var nameLabel : UILabel!
    var followBtn : UIButton!
    var tableView: QMUITableView!
    var sectionView : HomeDetailSectionView!
    
    override func initSubviews() {
        
        sectionView = HomeDetailSectionView()
        
        // TODO: 硬编码未处理
        tableView = QMUITableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableView.backgroundColor = .white
        tableView.contentInset = UIEdgeInsets.init(top: CGFloat(LayoutKit.sharedInstance().adaptWidthRatio(230 - 35)), left: 0, bottom: 0, right: 0)
        tableView.register(HomeTabelViewCell.self, forCellReuseIdentifier:"HomeTabelViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = CGFloat(LayoutKit.sharedInstance().adaptWidthRatio(66))
//        tableView.mj_header = MJRefreshNormalHeader()
//        tableView.mj_header?.setRefreshingTarget(self, refreshingAction: #selector(pullToRefresh))
//        tableView.mj_header?.isAutomaticallyChangeAlpha = true
//        tableView.mj_footer = MJRefreshAutoNormalFooter()
//        tableView.mj_footer?.setRefreshingTarget(self, refreshingAction: #selector(pullOnLoad))
//        tableView.mj_footer?.isAutomaticallyChangeAlpha = true
        tableView.sectionHeaderHeight = CGFloat((LayoutKit.sharedInstance().adaptWidthRatio(66)))
        self.addSubview(tableView)
        
        bgIV = UIImageView.init(image: UIImage.init(named: "HomeDetail_bg_black"))
        bgIV.isUserInteractionEnabled = true
        self.addSubview(bgIV)
        
        backBtn = UIButton(type: UIButton.ButtonType.custom)
        backBtn.setBackgroundImage(UIImage.init(named: "HomeDetail_btn_arrow_left_grey"), for: UIControl.State.normal)
        backBtn.addTarget(self, action: #selector(tapBack), for: UIControl.Event.touchDown)
        self.addSubview(backBtn)
        
        iconIV = UIImageView()
        iconIV.layer.cornerRadius = CGFloat(LayoutKit.sharedInstance().adaptWidthRatio(64) / 2)
        iconIV.layer.masksToBounds = true
        bgIV.addSubview(iconIV)
        
        nameLabel = UILabel()
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.black)
        bgIV.addSubview(nameLabel)
        
        followBtn = UIButton(type: UIButton.ButtonType.custom)
        followBtn.setTitle("关注", for: UIControl.State.normal)
        followBtn.setTitle("已关注", for: UIControl.State.selected)
        followBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        followBtn.layer.cornerRadius = 4
        followBtn.backgroundColor = UIColor.white
        followBtn.titleLabel?.font =  UIFont.systemFont(ofSize: 11)
        followBtn.addTarget(self, action: #selector(tapFollow), for: UIControl.Event.touchDown)
        bgIV.addSubview(followBtn)
    }
    
    override func setupSubviewsConstraints() {
        
        tableView.snp.makeConstraints { make in
            
//            make.top.equalTo(bgIV.snp.bottom).offset(-LayoutKit.sharedInstance().adaptWidthRatio(35))
            make.top.equalToSuperview()
            make.left.width.bottom.equalToSuperview()
        }
        
        backBtn.snp.makeConstraints { make in
            
            make.width.equalTo(LayoutKit.sharedInstance().adaptWidthRatio(25))
            make.height.equalTo(LayoutKit.sharedInstance().adaptWidthRatio(25))
            make.top.equalToSuperview().offset(QMUIHelper.safeAreaInsetsForDeviceWithNotch.top + 10)
            make.left.equalToSuperview().offset(LayoutKit.sharedInstance().adaptWidthRatio(10))
        }
        
        bgIV.snp.makeConstraints { make in
            
            make.top.left.width.equalToSuperview()
            make.height.equalTo(LayoutKit.sharedInstance().adaptWidthRatio(230))
        }
        
        iconIV.snp.makeConstraints { make in
            
            make.width.height.equalTo(LayoutKit.sharedInstance().adaptWidthRatio(64))
//            make.top.equalToSuperview().offset(LayoutKit.sharedInstance().adaptWidthRatio(55))
            make.bottom.equalToSuperview().offset(-LayoutKit.sharedInstance().adaptWidthRatio(111))
            make.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            
//            make.top.equalToSuperview().offset(LayoutKit.sharedInstance().adaptWidthRatio(136))
            make.bottom.equalToSuperview().offset(-LayoutKit.sharedInstance().adaptWidthRatio(75))
            make.centerX.equalToSuperview()
        }
        
        followBtn.snp.makeConstraints { make in
            
            make.width.equalTo(LayoutKit.sharedInstance().adaptWidthRatio(55))
            make.height.equalTo(LayoutKit.sharedInstance().adaptWidthRatio(24))
            make.bottom.equalToSuperview().offset(-LayoutKit.sharedInstance().adaptWidthRatio(35))
//            make.top.equalToSuperview().offset(LayoutKit.sharedInstance().adaptWidthRatio(171))
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func pullToRefresh(){
        
        self.viewDelegate?.view?(self, withEvent: ["name":"pullToRefresh"])
    }
    
    @objc func pullOnLoad(){
        
        self.viewDelegate?.view?(self, withEvent: ["name":"pullOnLoad"])
    }
    
    @objc func tapFollow(){
        
        self.viewDelegate?.view?(self, withEvent: ["name":"tapFollow"])
    }
    
    @objc func tapBack(){
        
        self.viewDelegate?.view?(self, withEvent: ["name":"tapBack"])
    }
}
