//
//  UserCell.swift
//  GithubClient
//
//  Created by Apple on 2020/7/21.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class UserCell: UITableViewCell {
    let kFontSize: CGFloat = 15
    lazy var avatar: UIImageView = UIImageView()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: kFontSize)
        label.textColor = UIColor.color(rgbHex: 0x111111)
        return label
    }()
    
    lazy var scoreLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: kFontSize)
        label.textColor = UIColor.color(rgbHex: 0x111111)
        return label
    }()
    
    
    lazy var htmlLabel: UILabel = {
        let label = UILabel()
         label.textAlignment = .left
         label.font = UIFont.systemFont(ofSize: kFontSize)
         label.textColor = UIColor.color(rgbHex: 0x333333)
         return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.viewInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewInit() {
        self.selectionStyle = .none
        self.contentView.addSubview(self.avatar)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.scoreLabel)
        self.contentView.addSubview(self.htmlLabel)
        self.avatar.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(50)
            make.leading.equalToSuperview().offset(10)
        }
        
        self.nameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.avatar.snp.trailing).offset(10)
            make.centerY.equalTo(self).offset(-10)
        }
        
        self.scoreLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.nameLabel.snp.trailing).offset(10)
            make.trailing.lessThanOrEqualToSuperview().offset(-10)
            make.centerY.equalTo(self.nameLabel)
        }
        
        self.nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.scoreLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        self.htmlLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(10)
            make.leading.equalTo(self.nameLabel)
        }
    }
    
    func bindViewModel(_ viewModel: UserCellViewModel) {
        self.avatar.kf.setImage(with: viewModel.avatar)
        self.nameLabel.text = viewModel.name
        self.scoreLabel.text = viewModel.score
        self.htmlLabel.text = viewModel.html
    }
}
