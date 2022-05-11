//
//  UserDetailHeaderView.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/11.
//

import UIKit
import SnapKit
import Kingfisher
class UserDetailHeaderView: UIView {
    var user: User
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "UserDetail-Header-Background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 32
        imageView.layer.masksToBounds = true
        return imageView
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    lazy var followButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(followButtonAction(_:)), for: .touchUpInside)
        button.backgroundColor = UIColor.white
        button.setTitle("关注", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 11)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    public init(with user: User) {
        self.user = user
        super.init(frame: .zero)
        setupViews()
        bindData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(avatarImageView)
        backgroundImageView.addSubview(nameLabel)
        backgroundImageView.addSubview(followButton)

        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        avatarImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(64)
            make.bottom.equalTo(-111)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(17)
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
        }
        followButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(11)
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
            make.width.equalTo(55)
        }
    }

    private func bindData() {
        nameLabel.text = user.login
        avatarImageView.kf.setImage(with: URL(string: user.avatarUrl))
    }

}
// MARK: - Action
extension UserDetailHeaderView {
    @objc func followButtonAction(_ sender: UIButton?) {

    }
}
