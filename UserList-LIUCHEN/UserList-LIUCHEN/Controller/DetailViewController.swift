//
//  DetailViewController.swift
//  UserList-LIUCHEN
//
//  Created by LC on 2020/6/23.
//  Copyright © 2020 LC. All rights reserved.
//

import UIKit
import WebKit
class DetailViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    var url = URL(string: "")
    var detail: Item! {
        didSet {
            if let detailUrl = detail.html_url {
                url = URL(string: detailUrl)!
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = URLRequest.init(url: url!)
        webView.load(request)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
    }
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
       
        progressView.alpha = 1
        progressView.setProgress(Float(self.webView.estimatedProgress), animated: true)
        if webView.estimatedProgress == 1 {
            progressView.alpha = 0
        }
    }
}
