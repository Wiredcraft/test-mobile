//
//  DetailViewController.swift
//  GitHubUsers
//
//  Created by lusheng tan on 2019/4/10.
//  Copyright © 2019 lusheng tan. All rights reserved.
//

import UIKit
import WebKit
import SnapKit
import PKHUD

class DetailViewController: UIViewController {

    var strURL: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HUD.show(.progress)
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: view.bounds, configuration: webConfiguration)
        webView.navigationDelegate = self
        if let strURL = self.strURL, let url = URL(string: strURL) {
            webView.load(URLRequest(url: url))
        }
        view.addSubview(webView)
        
        webView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }

}

extension DetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        HUD.hide()
    }
}
