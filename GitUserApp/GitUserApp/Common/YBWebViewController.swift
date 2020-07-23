//
//  YBWebViewController.swift
//  GitUserApp
//
//  Created by Rock on 7/22/20.
//  Copyright © 2020 Rock. All rights reserved.
//

import UIKit
import WebKit
import RxCocoa

class YBWebViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var webView: WKWebView = {
        let view = WKWebView()
        return view
    }()
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        return progressView
    }()
    var observation: NSKeyValueObservation?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        
        setupUI()
        observation = webView.observe(\.estimatedProgress, options: .new) { [weak self] (_, changed) in
            if let new = changed.newValue {
                self?.changeProgress(Float(new))
            }
        }

    }
    
    // MARK: - layout UI
    func setupUI() {
        
        view.addSubview(webView)
        view.addSubview(progressView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Tool.kNavigationBarHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
    }
    
    // MARK: - Action
    
    /// load URL
    /// - Parameter url: url
    func load(url: URL?) {
        if let url = url {
            webView.load(URLRequest(url: url))
        }
    }
    
    /// setup webView load progress
    /// - Parameter progress: progress
    private func changeProgress(_ progress: Float) {
        progressView.isHidden = progress == 1
        progressView.setProgress(progress, animated: true)
    }
    
}

