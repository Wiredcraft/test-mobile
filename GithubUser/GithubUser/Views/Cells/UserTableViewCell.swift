//
//  TableViewUserCell.swift
//  GithubUser
//
//  Created by zhaitong on 2022/3/22.
//

import Foundation
import UIKit
import Kingfisher

typealias FollowCallback = (ListItem?) -> Void

class UserTableViewCell: UITableViewCell{
    //头像
    lazy var headerView: UIImageView = {
        var headerView = UIImageView.init()
        headerView.layer.cornerRadius = CGFloat(headerSize/2)
        headerView.layer.masksToBounds = true
        headerView.image = .init(named: "man")
        return headerView
    }()
    
    //用户名
    lazy var userNameLabel: UILabel = {
        var userNameLabel = UILabel.init()
        userNameLabel.font = .systemFont(ofSize: fitScale(size: 14))
        userNameLabel.textColor = .black
        return userNameLabel
    }()
    
    //html url
    lazy var htmlUrlLabel: UILabel = {
        var htmlUrlLabel = UILabel.init()
        htmlUrlLabel.font = .systemFont(ofSize: fitScale(size: 11))
        htmlUrlLabel.textColor = .gray
        htmlUrlLabel.textColor = .init(red: 0.427, green: 0.427, blue: 0.427, alpha: 1)
        return htmlUrlLabel
    }()
    
    //名字右侧分数
    lazy var scoreLabel: UILabel = {
        var scoreLabel = UILabel.init()
        scoreLabel.font = .systemFont(ofSize: fitScale(size: 10))
        scoreLabel.textColor = .init(red: 0.427, green: 0.427, blue: 0.427, alpha: 1)
        return scoreLabel
    }()
    
    //关注
    lazy var followButton: UIButton = {
        var followButton = UIButton.init()
        followButton.setTitle("关注", for: .normal)
        followButton.backgroundColor = UIColor.init(red: 0.101, green: 0.101, blue: 0.101, alpha: 1.0)
        followButton.contentEdgeInsets = .init(top: fitScale(size: 5), left: fitScale(size: 13), bottom: fitScale(size: 5), right: fitScale(size: 13))
        followButton.titleLabel?.font = .systemFont(ofSize: fitScale(size: 12))
        followButton.layer.cornerRadius = fitScale(size: 5)
        followButton.layer.masksToBounds = true
        followButton.addTarget(self, action: #selector(followAction), for: .touchUpInside)
        return followButton
    }()
   
    lazy var lineView: UIView = {
        var lineView = UIView.init()
        lineView.backgroundColor = .init(red: 0.937, green: 0.937, blue: 0.937, alpha: 1.0)
        return lineView
    }()
    
    let headerSize = fitScale(size: 43)
    
    var followCallback: FollowCallback?
    
    var data: ListItem? {
        didSet {
            self.userNameLabel.text = self.data?.login
            self.scoreLabel.text = "\(self.data?.score ?? 0)"
            self.htmlUrlLabel.text = self.data?.html_url
            self.headerView.kf.setImage(with: URL(string: self.data?.avatar_url ?? ""), placeholder: UIImage.init(named: "man"), options: nil, completionHandler: nil)
            if (data?.isFollow ?? false) {
                followButton.setTitle("已关注", for: .normal)
            } else {
                followButton.setTitle("关注", for: .normal)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initCell()
        makeLayout()
    }
    
    func initCell() {
        contentView.addSubview(headerView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(htmlUrlLabel)
        contentView.addSubview(followButton)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(lineView)
    }
    
    func makeLayout() {
        headerView.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(fitScale(size: 20))
            make.top.equalTo(contentView.snp.top).offset(fitScale(size: 10))
            make.bottom.equalTo(contentView.snp.bottom).offset(fitScale(size: -10))
            make.size.equalTo(headerSize)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.left.equalTo(headerView.snp.right).offset(fitScale(size: 10))
            make.top.equalTo(headerView.snp.top).offset(fitScale(size: 3))
            make.bottom.equalTo(htmlUrlLabel.snp.top)
            make.width.lessThanOrEqualTo(contentView.snp.width).multipliedBy(0.4)
        }
        
        htmlUrlLabel.snp.makeConstraints { make in
            make.left.equalTo(userNameLabel.snp.left)
            make.top.equalTo(userNameLabel.snp.bottom)
            make.bottom.equalTo(headerView.snp.bottom).offset(fitScale(size: -3))
            make.right.lessThanOrEqualTo(contentView.snp.right).offset(-20)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.left.equalTo(userNameLabel.snp.right).offset(fitScale(size: 8))
            make.top.equalTo(userNameLabel.snp.top)
            make.bottom.equalTo(userNameLabel.snp.bottom)
        }
        
        followButton.snp.makeConstraints { make in
            make.right.equalTo(contentView.snp.right).offset(fitScale(size: -20))
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom)
            make.left.equalTo(headerView.snp.left)
            make.right.equalTo(followButton.snp.right).offset(fitScale(size: 5))
            make.height.equalTo(1)
        }
    }
    
    @objc
    func followAction() {
        if (followCallback != nil) {
            followCallback?(data)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
