//
//  WCTUserDetailViewController.swift
//  WiredcraftTest
//
//  Created by Richard on 2020/7/23.
//  Copyright © 2020 RichardSheng. All rights reserved.
//

import UIKit
import WebKit

class WCTUserDetailViewController: UIViewController {

  @IBOutlet weak var webView: WKWebView!

  var userModel: WCTUserModel?

  convenience init(userModel: WCTUserModel) {
    self.init()
    self.userModel = userModel
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = userModel?.login
    if let urlStr: String = userModel?.html_url, urlStr.count > 0, let url: URL = URL(string: urlStr) {
      webView.load(URLRequest(url: url))
    }
  }
}
