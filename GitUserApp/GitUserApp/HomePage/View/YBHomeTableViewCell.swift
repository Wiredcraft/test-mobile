//
//  YBHomeTableViewCell.swift
//  GitUserApp
//
//  Created by Rock on 7/22/20.
//  Copyright © 2020 Rock. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class YBHomeTableViewCell: UITableViewCell {

    let kViewMargin = 15

    lazy var avatarImageView: UIImageView = {
        
        let imageView = UIImageView()
        return imageView
    }()

    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1;
        return label
    }()

    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1;
        return label
    }()

    lazy var urlLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1;
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        selectionStyle = .none
        contentView.addSubview(avatarImageView)
        contentView.addSubview(loginLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(urlLabel)
      
        avatarImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(kViewMargin)
            make.left.equalTo(contentView).offset(kViewMargin)
            make.bottom.equalTo(contentView).offset(-kViewMargin)
            make.width.equalTo(50)
            make.height.equalTo(50).priority(.high)
            
        }
      
        scoreLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(kViewMargin)
            make.right.equalTo(contentView).offset(-kViewMargin)
        }
      
        loginLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(kViewMargin)
            make.right.equalTo(scoreLabel.snp_leftMargin).offset(-kViewMargin)
            make.left
              .equalTo(avatarImageView.snp_rightMargin)
              .offset(kViewMargin)
        }
      
        urlLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(avatarImageView.snp_bottomMargin)
            make.left
            .equalTo(avatarImageView.snp_rightMargin)
            .offset(kViewMargin)
            make.right.equalToSuperview().offset(-kViewMargin)
            
        }
    }

}
