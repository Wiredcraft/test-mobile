//
//  GitHupUserDetailHeaderCellView.swift
//  CJWProject
//
//  Created by Joy Cheng on 2022/3/31.
//

import UIKit
import SnapKit
import Then
import RxSwift
import Kingfisher

class GitHupUserDetailHeaderCellView: UITableViewHeaderFooterView {
    static let reuseIdentifier = GitHupUserDetailHeaderCellViewID
    private lazy var headerImageView = {
        UIImageView().then {
            $0.backgroundColor = .clear
            $0.isUserInteractionEnabled = true
            $0.image = UIImage(named: detailBackGroundImage)
        }
    }()
    private lazy var headerIcon = {
        UIImageView().then {
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 32
        }
    }()
    private lazy var headerTitleLabel = {
        UILabel().then {
            $0.numberOfLines = 0
            $0.font = UIFont.systemFont(ofSize: 16)
            $0.textColor = UIColor(hex: "#FFFFFF")
            $0.textAlignment  = .center
            $0.text = "ESTHER"
        }
    }()
    private lazy var headerFollowBtn = {
        UIButton().then {
            $0.backgroundColor = .white
            $0.setTitle(followedText, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .regular)
            $0.setTitleColor(UIColor(hex: "#1A1A1A"), for: .normal)
            $0.layer.cornerRadius = 4.0
        }
    }()
    private lazy var titleView = {
        UIView().then {
            $0.backgroundColor = .white
        }
    }()
    private lazy var lineView = {
        UIView().then {
            $0.backgroundColor = .black
        }
    }()
    private lazy var titleLabel = {
        UILabel().then {
            $0.numberOfLines = 0
            $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            $0.text = "REPOSITORIES"
            $0.textColor = UIColor(hex: "#1A1A1A")
        }
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(reuseIdentifier: String?) {
        super .init(reuseIdentifier: reuseIdentifier)
        initPageView()
    }
    // MARK:InitPageView
    func initPageView() {
        contentView.addSubview(headerImageView)
        headerImageView.addSubview(headerIcon)
        headerImageView.addSubview(headerTitleLabel)
        headerImageView.addSubview(headerFollowBtn)
        contentView.addSubview(titleView)
        titleView.addSubview(lineView)
        titleView.addSubview(titleLabel)
        headerImageView.snp.makeConstraints { maker in
            maker.top.equalTo(contentView)
            maker.leading.equalTo(contentView)
            maker.width.equalTo(contentView)
            maker.height.equalTo(230)
        }
        headerIcon.snp.makeConstraints { maker in
            maker.centerX.equalTo(contentView)
            maker.top.equalTo(contentView).offset(55)
            maker.width.equalTo(64)
            maker.height.equalTo(64)
        }
        headerTitleLabel.snp.makeConstraints { maker in
            maker.centerX.equalTo(contentView)
            maker.top.equalTo(headerIcon.snp_bottom).offset(17)
            maker.left.equalTo(lineView.snp_right).offset(9)
        }
        headerFollowBtn.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(headerTitleLabel.snp_bottom).offset(20)
            maker.width.equalTo(55)
            maker.height.equalTo(24)
        }
        titleView.snp.makeConstraints { maker in
            maker.top.equalTo(headerImageView.snp_bottom).offset(30)
            maker.leading.trailing.equalTo(headerImageView)
            maker.height.equalTo(30)
        }
        lineView.snp.makeConstraints { maker in
            maker.centerY.equalTo(titleView)
            maker.leading.equalTo(20)
            maker.width.equalTo(2)
            maker.height.equalTo(20)
        }
        titleLabel.snp.makeConstraints { maker in
            maker.centerY.equalTo(titleView)
            maker.left.equalTo(lineView.snp_right).offset(9)
        }
    }
    // MARK:updatePageView
    func updateHeaderView(with model:FollowDetailOwner) {
        let url = URL(string: model.avatarUrl)
        headerIcon.kf.setImage(with: url)
        headerIcon.filletedCorner(CGSize(width: 32, height: 32), .allCorners)
        headerTitleLabel.text = model.login
    }
}
