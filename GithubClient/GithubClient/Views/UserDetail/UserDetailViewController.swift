//
//  UserDetailViewController.swift
//  GithubClient
//
//  Created by Apple on 2020/7/22.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class UserDetailViewController: UIViewController {

    var viewModel: UserDetailViewModel
    
    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewInit()
        self.webView.load(URLRequest(url: self.viewModel.homeUrl))
    }
    
    func viewInit() {
        self.title = self.viewModel.title
        self.edgesForExtendedLayout = [.bottom,.left,.right]
        self.view.addSubview(self.webView)
        self.webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    init(_ viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
