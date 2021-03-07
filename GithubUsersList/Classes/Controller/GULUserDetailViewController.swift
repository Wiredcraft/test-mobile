//
//  GULUserDetailViewController.swift
//  GithubUsersList
//
//  Created by 裘诚翔 on 2021/3/6.
//

import UIKit
import WebKit

class GULUserDetailViewController: UIViewController {
    
    private var detailUrl : String = ""
    
    private lazy var webView : WKWebView = {
        let wv = WKWebView()
        return wv
    }()
    
    init(url: String) {
        super.init(nibName: nil, bundle: nil)
        self.detailUrl = url
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup() {
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        guard let url = URL(string: detailUrl) else {
            return
        }
        webView.load(URLRequest(url: url))
    }

}
