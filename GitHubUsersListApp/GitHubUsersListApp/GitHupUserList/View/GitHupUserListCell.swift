//
//  GitHupUserListCell.swift
//  CJWProject
//
//  Created by Joy Cheng on 2022/3/31.
//

import UIKit
import SnapKit
import Then
import RxSwift
import Kingfisher

protocol GitHupUserListButtonDelegate: AnyObject {
    func clickFollowButton(sender: UIButton)
}

class GitHupUserListCell: UITableViewCell {
    static let reuseIdentifier = GitHupUserListCellID
    weak var delegate: GitHupUserListButtonDelegate?
    private lazy var iconImage = {
        UIImageView().then {
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 16
            $0.layer.masksToBounds = true
        }
    }()
    private lazy var loginLabel = {
        UILabel().then {
            $0.numberOfLines = 1
            $0.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            $0.textColor = UIColor(hex: "#000000")
        }
    }()
    private lazy var scoreLabel = {
        UILabel().then {
            $0.numberOfLines = 1
            $0.font = UIFont.systemFont(ofSize: 11, weight: .regular)
            $0.textColor = UIColor(hex: "#6D6D6D")
            $0.textAlignment = .left
        }
    }()
    private lazy var htmlUrlLabel = {
        UILabel().then {
            $0.numberOfLines = 1
            $0.font = UIFont.systemFont(ofSize: 11, weight: .regular)
            $0.textColor = UIColor(hex: "#6D6D6D")
        }
    }()
    private lazy var followBtn = {
        UIButton().then {
            $0.backgroundColor = UIColor(hex: "#1A1A1A")
            $0.setTitle(followedText, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .regular)
            $0.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
            $0.layer.borderColor = UIColor.yellow.cgColor
            $0.layer.cornerRadius = 4.0
        }
    }()
    private lazy var dividingLineView = {
        UIView().then {
            $0.backgroundColor = UIColor(hex: "#EFEFEF")
        }
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initCellView()
    }
    // MARK:InitCellView
    private func initCellView() {
        contentView.addSubview(iconImage)
        contentView.addSubview(loginLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(htmlUrlLabel)
        contentView.addSubview(followBtn)
        contentView.addSubview(dividingLineView)
        iconImage.snp.makeConstraints { maker in
            maker.width.equalTo(32)
            maker.height.equalTo(32)
            maker.leading.equalToSuperview().offset(20)
            maker.top.equalToSuperview().offset(15)
        }
        loginLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(15)
            maker.left.equalTo(iconImage.snp_right).offset(10)
        }
        scoreLabel.snp.makeConstraints { maker in
            maker.centerY.equalTo(loginLabel)
            maker.left.equalTo(loginLabel.snp_right).offset(5)
            maker.right.lessThanOrEqualToSuperview().offset(-100)
        }
        htmlUrlLabel.snp.makeConstraints { maker in
            maker.bottom.equalTo(contentView).offset(-15)
            maker.left.equalTo(iconImage.snp_right).offset(10)
            maker.right.equalToSuperview().offset(-80)
        }
        followBtn.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.right.equalTo(contentView).offset(-28)
            maker.width.equalTo(54)
            maker.height.equalTo(24)
        }
        dividingLineView.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview()
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
            maker.height.equalTo(1)
        }
        // CompressionResistancePriority
        loginLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        scoreLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        // Target
        addFollowButtonTarget()
    }
    private func addFollowButtonTarget() {
        followBtn.addTarget(self, action: #selector(tapFollowButton(sender:)), for: .touchUpInside)
    }
    @objc func tapFollowButton(sender: UIButton) {
        delegate?.clickFollowButton(sender: sender)
    }
    func configCellValue(model:GitHupUserListModel, cellStyle: FollowCellStyle) {
        var url = URL(string: model.avatarUrl)
        switch cellStyle {
            case .followList:
                loginLabel.text = model.login
                scoreLabel.text = "\(model.score)"
                followBtn.isHidden = false
            case .followDetail:
                url = URL(string: model.owner.avatarUrl)
                loginLabel.text = model.name
                scoreLabel.text = "\(model.stargazersCount)"
                followBtn.isHidden = true
        }
        iconImage.kf.setImage(with: url, placeholder: UIImage(named: listIconPlaceholder))
//        iconImage.filletedCorner(CGSize(width: 16, height: 16), .allCorners)
        htmlUrlLabel.text = model.htmlUrl
        if model.isFollowed {
            followBtn.setTitle(followedText, for: .normal)
        } else {
            followBtn.setTitle(unFollowText, for: .normal)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        // Configure the view for the selected state
    }

}
