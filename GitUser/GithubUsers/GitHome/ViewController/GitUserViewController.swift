//
//  GitUserViewController.swift
//  GithubUsers
//
//  Created by lvzhao on 2020/7/22.
//  Copyright © 2020 吕VV. All rights reserved.
//

import UIKit

class GitUserViewController: LZBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "用户列表"
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - setupUI
    func setupUI()  {
    
        self.view.addSubview(self.userListView)
        self.userListView.snp.makeConstraints { (make) in
            make.top.equalTo(0.5)
            make.left.right.bottom.equalTo(0)
        }
        
    }

    
    // MARK: - 懒加载
    private lazy var  userListView: GitUserView = {
        let userListView = GitUserView.init(viewModel: self.viewModel)
        return userListView
    }()
    
    
    private lazy var viewModel : GitUserViewModel = {
        let viewModel = GitUserViewModel()
        return viewModel
    }()
}
