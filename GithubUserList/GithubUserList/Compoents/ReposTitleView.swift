//
//  ReposTitleView.swift
//  GithubUserList
//
//  Created by zhaotianyang on 2022/3/31.
//

import Foundation
import UIKit

class ReposTitleView: UIView {
    
    let indicator = UIView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        backgroundColor = Theme.Color.white
        
        addSubview(indicator)
        indicator.backgroundColor = Theme.Color.main
        indicator.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.width.equalTo(3)
            make.height.equalTo(20)
            make.top.equalTo(15)
            make.bottom.equalTo(-15)
        }
        
        addSubview(titleLabel)
        titleLabel.text = "REPOSITORIES"
        titleLabel.textColor = Theme.Color.title
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(indicator.snp.right).offset(15)
            make.centerY.equalTo(indicator)
        }
        
        
    }
}

