//
//  HomeHearderView.swift
//  GitHubUsersList
//
//  Created by YUI on 2022/4/4.
//

import UIKit

class HomeHearderView: CommonView {
    
    var searchBar : HomeSearchBar!

    override func initSubviews() {
        
//        searchBar = UIsearchBar.init(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: LayoutKit.sharedInstance().adaptWidthRatio(58)))
//
////        searchBar = UIsearchBar(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: LayoutKit.sharedInstance().adaptWidthRatio(58)))
//        searchBar.showsCancelButton = true  // 取消按钮是否显示
//        searchBar.setSearchFieldBackgroundImage(UIImage.init(named: "Home_bg_searchBar"), for: UIControl.State.normal)
//        searchBar.backgroundColor = UIColor.red
//        self.addSubview(searchBar)
        
        // 实例化
        searchBar = HomeSearchBar(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: LayoutKit.sharedInstance().adaptWidthRatio(58)))
        addSubview(searchBar)
    }
    
    override func setupSubviewsConstraints() {

        searchBar.snp.makeConstraints { make in
            
            make.top.height.equalToSuperview()
            make.left.equalToSuperview().offset(LayoutKit.sharedInstance().adaptWidthRatio(10))
            make.right.equalToSuperview().offset(-LayoutKit.sharedInstance().adaptWidthRatio(10))
        }
    }
}
