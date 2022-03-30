//
//  UserItemCell.swift
//  GithubUserList
//
//  Created by zhaotianyang on 2022/3/30.
//

import UIKit
import SnapKit
import Kingfisher

protocol UserItemData {
    var login: String? { get }
    var id: Int64? { get }
    var avatar_url: String? { get }
    var score: Double? { get }
    var html_url: String? { get }
    var canFollow: Bool { get }
    var isFollow: Bool { get }
}

class UserItemCell: UITableViewCell {
    static let reuseId = "UserItemCell"
    
    private let userIcon = UIImageView()
    private let nameLabel = UILabel()
    private let scoreLabel = UILabel()
    private let urlLabel = UILabel()
    private let followButton = UIButton()
    private let line = UIView()
    
    var followAction: ((UserItemData)->Void)?
    
    var dataModel: UserItemData? {
        didSet {
            updateUI()
        }
    }
    
    static func creatCell(tableView: UITableView) -> UserItemCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId) as? UserItemCell
        cell?.selectionStyle = .none
        return cell ?? UserItemCell(style: .default, reuseIdentifier: reuseId)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        
        userIcon.layer.backgroundColor = Theme.Color.bgColor.cgColor
        userIcon.layer.cornerRadius = 20
        
        nameLabel.textColor = Theme.Color.title
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        
        scoreLabel.textColor = Theme.Color.subTitle
        scoreLabel.font = UIFont.systemFont(ofSize: 13)
        scoreLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        urlLabel.textColor = Theme.Color.subTitle
        urlLabel.font = UIFont.systemFont(ofSize: 14)
        
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitleColor(Theme.Color.white, for: .normal)
        followButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        followButton.layer.cornerRadius = 5
        followButton.layer.backgroundColor = Theme.Color.main.cgColor
        followButton.addTarget(self, action: #selector(followClick), for: .touchUpInside)
        
        line.backgroundColor = Theme.Color.subTitle.withAlphaComponent(0.7)
    }
    
    private func layoutUI() {
        contentView.addSubview(userIcon)
        contentView.addSubview(nameLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(urlLabel)
        contentView.addSubview(followButton)
        contentView.addSubview(line)
        
        userIcon.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(24)
            make.size.equalTo(CGSize(width: 40, height: 40)).priority(900)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(userIcon)
            make.left.equalTo(userIcon.snp.right).offset(10)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(3)
        }
        
        urlLabel.snp.makeConstraints { make in
            make.bottom.equalTo(userIcon)
            make.left.equalTo(userIcon.snp.right).offset(10)
        }
        
        followButton.snp.makeConstraints { make in
            make.centerY.equalTo(userIcon)
            make.right.equalTo(-24)
            make.left.greaterThanOrEqualTo(urlLabel.snp.right).offset(10)
            make.left.greaterThanOrEqualTo(scoreLabel.snp.right).offset(10).priority(900)
            make.width.equalTo(80)
            make.height.equalTo(24).priority(900)
        }
        
        line.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(0.5)
            make.top.equalTo(userIcon.snp.bottom).offset(20)
            make.bottom.equalTo(0)
        }
    }
    
    private func updateUI() {
        guard let model = dataModel else {return}
        
        let url = URL(string: model.avatar_url ?? "")
        let processor = DownsamplingImageProcessor(size: CGSize(width: 40, height: 40))
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        userIcon.kf.indicatorType = .activity
        userIcon.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25)),
            ]
        )
        
        nameLabel.text = model.login
        scoreLabel.text = "\(model.score ?? 0)"
        urlLabel.text = model.html_url
        
        if model.isFollow {
            followButton.setTitle("UnFollow", for: .normal)
        } else {
            followButton.setTitle("Follow", for: .normal)
        }
        
        followButton.isHidden = !model.canFollow
        if followButton.isHidden {
            followButton.snp.updateConstraints { make in
                make.width.equalTo(0)
            }
        } else {
            followButton.snp.updateConstraints { make in
                make.width.equalTo(80)
            }
        }
    }
    
    @objc private func followClick() {
        guard let model = dataModel else {return}
        followAction?(model)
    }
}
