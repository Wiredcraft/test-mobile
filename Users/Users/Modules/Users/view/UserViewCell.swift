//
//  UserViewCell.swift
//  Users
//
//  Created by ivanzeng on 2021/2/1.
//  Copyright © 2021 none. All rights reserved.
//

import SDWebImage
import SnapKit
import UIKit

class UserViewCell: UITableViewCell {

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        return label
    }()

    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.black
        return label
    }()

    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.gray
        return label
    }()

    lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 4
        return avatarImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstrains()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupSubviews() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(detailLabel)
    }

    func setupConstrains() {
        avatarImageView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(10)
            make.width.equalTo(30)
            make.width.equalTo(avatarImageView.snp.height)
            make.centerY.equalToSuperview()
        }
        scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.top).offset(-2)
            make.right.equalTo(contentView.snp.right).offset(-20)
        }
        nameLabel.snp.makeConstraints { make in
            make.right.equalTo(scoreLabel.snp.left).offset(-5)
            make.top.equalTo(scoreLabel)
            make.left.greaterThanOrEqualTo(avatarImageView.snp.right).offset(50)
        }
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        detailLabel.snp.makeConstraints { make in
            make.right.equalTo(scoreLabel.snp.right)
            make.bottom.equalTo(avatarImageView.snp.bottom).offset(2)
        }
    }

    var user: GithubUser? {
        didSet {
            if let user = user {
                avatarImageView.sd_setImage(with: URL(string: user.avatarURL), placeholderImage: R.image.defaultAvatar())
                nameLabel.text = user.login
                scoreLabel.text = user.scoreStr
                detailLabel.text = user.htmlURL
            }
        }
    }
}
