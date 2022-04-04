//
//  HomeDetailSectionView.swift
//  GitHubUsersList
//
//  Created by YUI on 2022/4/5.
//

import UIKit

class HomeDetailSectionView: CommonView {
    
    var nameLabel : UILabel!
    var lineView : UIView!

    override func setupMainView() {
        
        self.backgroundColor = UIColor.white
    }
    
    override func initSubviews() {
        
        nameLabel = UILabel()
        nameLabel.text = "REPOSITORIES"
        nameLabel.textColor = UIColor.qmui_color(withHexString: "#1A1A1A")
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(nameLabel)
        
        lineView = UIView()
        lineView.backgroundColor = UIColor.qmui_color(withHexString: "#1A1A1A")
        self.addSubview(lineView)
    }
    
    override func setupSubviewsConstraints() {
        
        lineView.snp.makeConstraints { make in
            
            make.width.equalTo(LayoutKit.sharedInstance().adaptWidthRatio(2))
            make.height.equalTo(LayoutKit.sharedInstance().adaptWidthRatio(20))
            make.left.equalToSuperview().offset(LayoutKit.sharedInstance().adaptWidthRatio(20))
            make.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            
            make.left.equalTo(lineView.snp.right).offset(LayoutKit.sharedInstance().adaptWidthRatio(10))
            make.centerY.equalToSuperview()
        }
    }
}
