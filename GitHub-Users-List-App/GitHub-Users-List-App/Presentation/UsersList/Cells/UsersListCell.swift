//
//  UsersListCell.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/9.
//

import UIKit
import SnapKit
import Kingfisher
class UsersListCell: UITableViewCell {
    static let reuseIdentifier = String(describing: UsersListCell.self)
    static let height: CGFloat = 64

    private var viewModel: UsersListItemViewModel!

    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .left
        return label
    }()

    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        return imageView
    }()

    lazy var scoreLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 11)
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.427, green: 0.427, blue: 0.427, alpha: 1)
        return label
    }()

    lazy var html_urlLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 11)
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.427, green: 0.427, blue: 0.427, alpha: 1)
        return label
    }()

    lazy var followButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(followButtonAction(_:)), for: .touchUpInside)
        button.backgroundColor = UIColor.black
        button.setTitle("关注", for: .normal)
        button.setTitle("已关注", for: .selected)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 11)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = true
        button.accessibilityIdentifier = AccessibilityIdentifier.userListCellFollowButton
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        bindStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(html_urlLabel)
        contentView.addSubview(followButton)
    }

    func bindViewModel(_ viewModel: UsersListItemViewModel) {
        self.viewModel = viewModel
        nameLabel.text = viewModel.name
        scoreLabel.text = viewModel.score
        html_urlLabel.text = viewModel.htmlURL
        avatarImageView.kf.setImage(with: viewModel.avatarURL)
        viewModel.followState.observe(on: self) { [weak self] state in
            self?.followButton.isSelected = state == .followed
        }
    }

    func bindStyle() {
        avatarImageView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.height.width.equalTo(32)
            make.top.equalTo(15)
            make.bottom.equalTo(-17)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(10)
            make.top.equalTo(avatarImageView)
            make.height.equalTo(20)
        }
        scoreLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.right).offset(5)
            make.centerY.equalTo(nameLabel)
            make.right.lessThanOrEqualTo(followButton.snp.left).offset(-5)
        }
        html_urlLabel.snp.makeConstraints { make in
            make.bottom.equalTo(-10)
            make.left.equalTo(nameLabel)
        }
        followButton.snp.makeConstraints { make in
            make.width.equalTo(55)
            make.height.equalTo(24)
            make.right.equalTo(-28)
            make.centerY.equalToSuperview()
        }
        scoreLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }

    @objc func followButtonAction(_ sender: UIButton) {
        if sender.isSelected {
            viewModel.unfollow()
        } else {
            viewModel.follow()
        }
    }
}
