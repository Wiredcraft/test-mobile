//
//  Homeself.swift
//  GitHubUsersList
//
//  Created by YUI on 2022/3/31.
//

import UIKit

class HomeSearchBar: QMUISearchBar {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.setSearchFieldBackgroundImage(UIImage.init(named: "Home_bg_searchBar"), for: UIControl.State.normal)
        self.backgroundColor = UIColor.white
        self.barStyle = UIBarStyle.default
        self.barTintColor = UIColor.gray
        self.placeholder = "Search"
        self.tintColor = UIColor.gray
        self.searchBarStyle = UISearchBar.Style.minimal
        self.searchTextField.font = UIFont.systemFont(ofSize: 13)
        self.searchTextField.textColor = UIColor.black
        self.image(for: UISearchBar.Icon.search, state: UIControl.State.normal)
//        self.setPositionAdjustment(UIOffset(horizontal: 60, vertical: 0), for: UISearchBar.Icon.search)
        
        // 注意：showsBookmarkButton、showsSearchResultsButton不能同时设置
        self.showsCancelButton = false
//        self.showsScopeBar = true
//        self.showsSearchResultsButton = true
//        self.showsBookmarkButton = true
        // self.showsSearchResultsButton = true
        // 键盘类型设置
        self.keyboardType = UIKeyboardType.default
        self.returnKeyType = UIReturnKeyType.done
        self.isSecureTextEntry = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
