//
//  UserDetailViewController.swift
//  GithubUsersList
//
//  Created by Rusty on 2020/10/27.
//

import UIKit
import WebKit

class UserDetailViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
  
  var urlString = "https://github.com/swift"
  
  lazy var progressView: UIProgressView = {
    let progressView = UIProgressView(progressViewStyle: .default)
    progressView.sizeToFit()
    progressView.frame = CGRect.zero
    return progressView
  }()

  lazy var webView: WKWebView = {
    let webView = WKWebView(frame: CGRect.zero)
    let url = URL(string: urlString) ?? URL(string: "https://github.com/swift")
    webView.navigationDelegate = self
    webView.uiDelegate = self
    webView.load(URLRequest(url: url!))
    webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    return webView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    view.addSubview(webView)
    webView.snp.makeConstraints { (make) in
      make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
      make.bottom.equalToSuperview()
    }
    view.addSubview(progressView)
    progressView.snp.makeConstraints { (make) in
      make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
      make.height.equalTo(self.progressView.bounds.height)
    }
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
      progressView.progress = Float(webView.estimatedProgress)
      progressView.isHidden = progressView.progress == 1.0 ? true : false
    }
  }
    

    

}
