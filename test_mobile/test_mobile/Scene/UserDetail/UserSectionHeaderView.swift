//
//  UserSectionHeaderView.swift
//  test_mobile
//
//  Created by Jun Ma on 2022/3/20.
//

import UIKit
import SnapKit

class UserSectionHeaderView: UIView {
    
    let verticalBar = UIView()
    let nameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        // vertical bar
        verticalBar.backgroundColor = Constant.Color.color1a1a1a
        addSubview(verticalBar)
        verticalBar.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(19)
            make.top.bottom.equalToSuperview().inset(10)
            make.width.equalTo(2)
        }
        
        // name label
        nameLabel.text = "REPOSITORIES"
        nameLabel.font = Constant.Font.ntr
        nameLabel.textColor = Constant.Color.color1a1a1a
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(verticalBar.snp.right).offset(9)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
