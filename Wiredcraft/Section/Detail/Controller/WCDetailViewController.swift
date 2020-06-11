//
//  WCDetailViewController.swift
//  Wiredcraft
//
//  Created by codeLocker on 2020/6/12.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit
import WebKit

class WCDetailViewController: WCBaseViewController {

    fileprivate lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        return webView
    }()
    
    var link: String? {
        didSet {
            guard let link = self.link, let url = URL.init(string: link) else {
                return
            }
            self.loadHomePage(url: url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadUI()
        self.layout()
    }
    
    deinit {
        print("deinit")
    }
    
    //MARK: - Load_UI
    private func loadUI() {
        self.view.addSubview(self.webView)
    }
    
    private func layout() {
        self.webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}

extension WCDetailViewController {
    
    /// load the home page H5
    fileprivate func loadHomePage(url: URL) {
        let request = URLRequest.init(url: url)
        self.webView.load(request)
    }
}

//MARK: - WKNavigationDelegate
extension WCDetailViewController: WKNavigationDelegate {
    /// webView start to load
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.view.es_hud("Loading")
    }
    
    /// webView load complete
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.view.es_hideHUD()
    }
    
    /// webView load fail
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.view.es_hideHUD()
        self.view.es_hint(error.localizedDescription)
    }
}
