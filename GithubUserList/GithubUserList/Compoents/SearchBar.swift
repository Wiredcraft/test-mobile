//
//  SearchBar.swift
//  GithubUserList
//
//  Created by zhaotianyang on 2022/3/26.
//

import UIKit
import SnapKit

class SearchBar: UIView {
    let field = UITextField()
    let searchIcon = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height / 2.0
    }
    
    private func initUI() {
        layer.backgroundColor = Theme.Color.bgColor.cgColor
        
        addSubview(field)
        field.textColor = Theme.Color.main
        field.font = UIFont.systemFont(ofSize: 14)
        field.textAlignment = .left
        field.tintColor = Theme.Color.main
        field.placeholder = "Search Users"
        field.snp.makeConstraints { make in
            make.left.equalTo(17)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.right.equalTo(-17-34-5)
        }
        
        addSubview(searchIcon)
        searchIcon.image = Theme.Icon.search
        searchIcon.snp.makeConstraints { make in
            make.right.equalTo(-17)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
    }
}
