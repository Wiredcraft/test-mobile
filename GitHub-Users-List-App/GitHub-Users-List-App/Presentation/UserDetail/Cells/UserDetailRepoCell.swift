//
//  UserDetailRepoCell.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/11.
//

import UIKit

class UserDetailRepoCell: UITableViewCell {
    static let reuseIdentifier = String(describing: UserDetailRepoCell.self)
    static let height: CGFloat = 64
    private var viewModel: UserDetailRepoViewModel!

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
    }

    func bindViewModel(_ viewModel: UserDetailRepoViewModel) {
        self.viewModel = viewModel
        nameLabel.text = viewModel.name
        scoreLabel.text = viewModel.score
        html_urlLabel.text = viewModel.htmlURL
        avatarImageView.kf.setImage(with: viewModel.avatarURL)
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
        }
        scoreLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.right).offset(5)
            make.centerY.equalTo(nameLabel)
        }
        html_urlLabel.snp.makeConstraints { make in
            make.bottom.equalTo(-10)
            make.left.equalTo(nameLabel)
        }
    }
}
