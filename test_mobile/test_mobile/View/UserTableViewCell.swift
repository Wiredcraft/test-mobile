//
//  UserTableViewCell.swift
//  test_mobile
//
//  Created by Jun Ma on 2022/3/19.
//

import UIKit
import Reusable
import SnapKit

class UserTableViewCell: UITableViewCell, Reusable {
    
    let iconImageView = UIImageView()
    let nameLabel = UILabel()
    let scoreLabel = UILabel()
    let urlLabel = UILabel()
    let followButton = UIButton(type: .system)
    let guide = UILayoutGuide()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // not change background color when selected
        selectionStyle = .none
        
        // avatar image
        contentView.addSubview(iconImageView)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.layer.cornerRadius = 16
        iconImageView.layer.masksToBounds = true
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(12)
            make.width.height.equalTo(32)
        }
        
        // follow button
        contentView.addSubview(followButton)
        followButton.setTitle("FOLLOW", for: .normal)
        followButton.setTitleColor(.white, for: .normal)
        followButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        followButton.backgroundColor = .black
        followButton.layer.cornerRadius = 4
        followButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(8)
            make.centerY.equalTo(iconImageView)
            make.width.equalTo(80)
        }
        
        contentView.addLayoutGuide(guide)
        guide.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.centerY.equalTo(iconImageView)
            make.right.equalTo(followButton.snp.left).inset(10)
            make.height.equalTo(0.5)
        }
        
        // font
        let font = Constant.Font.ntr
        
        // name
        contentView.addSubview(nameLabel)
        nameLabel.font = font
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(guide)
            make.bottom.equalTo(guide.snp.top).offset(12)
        }
        nameLabel.snp.contentHuggingHorizontalPriority = 252
        nameLabel.snp.contentCompressionResistanceHorizontalPriority = 250
        
        // score
        contentView.addSubview(scoreLabel)
        scoreLabel.font = font?.withSize(15)
        scoreLabel.textColor = Constant.Color.color6d6d6d
        scoreLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.right).offset(5)
            make.centerY.equalTo(nameLabel)
            make.right.equalTo(followButton.snp.left).offset(-8)
        }
        scoreLabel.snp.contentHuggingHorizontalPriority = 251
        scoreLabel.snp.contentCompressionResistanceHorizontalPriority = 750
        
        // html url
        contentView.addSubview(urlLabel)
        urlLabel.font = font?.withSize(15)
        urlLabel.textColor = Constant.Color.color6d6d6d
        urlLabel.snp.makeConstraints { make in
            make.left.equalTo(guide)
            make.top.equalTo(guide.snp.bottom).offset(-8)
            make.right.equalTo(followButton.snp.left).offset(-8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
