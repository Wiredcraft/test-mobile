//
//  UsersListCell.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/9.
//

import UIKit
import SnapKit
class UsersListCell: UITableViewCell {
    static let reuseIdentifier = String(describing: UsersListCell.self)
    static let height: CGFloat = 130
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()

    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
    }

    func bindStyle() {
        avatarImageView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(15)
            make.centerY.equalTo(self)
            make.height.width.equalTo(32)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView).offset(10)
            make.top.equalTo(avatarImageView)

        }
    }
}
