//
//  LZWebViewController.swift
//  SMHCommerce
//
//  Created by lvzhao on 2020/6/2.
//  Copyright © 2020 lvzhao. All rights reserved.
//

import UIKit
import WebKit


enum LZWebLoadingType {
    case LZWebLoadingTypeUrl          //url
    case LZWebLoadingTypeHtml
}

class LZWebViewController: LZBaseViewController ,WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate{

    var webUrl:String?
    var loadingType :LZWebLoadingType = .LZWebLoadingTypeUrl

    var wkWebview : WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebUI()
        
        loadRequest()
        
        addKVOObserver()
    }
    
    /*
     *设置UI部分
     */
    func setupWebUI()
    {
        wkWebview = WKWebView.init(frame: self.view.bounds)
        wkWebview!.backgroundColor = UIColor.white
        wkWebview!.isMultipleTouchEnabled = true
        wkWebview!.autoresizesSubviews = true
        wkWebview!.scrollView.alwaysBounceVertical = true
        wkWebview!.allowsBackForwardNavigationGestures = true
        wkWebview!.uiDelegate = self
        wkWebview!.navigationDelegate = self
        wkWebview!.scrollView.delegate = self
        
        
        self.view.addSubview(self.wkWebview!)
        self.view.addSubview(self.progress)
        
        self.wkWebview!.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
    }

    /*
     *加载网页 request
     */
    func loadRequest()
    {
        
        if loadingType == .LZWebLoadingTypeHtml{
            
            self.wkWebview!.loadHTMLString(self.webUrl!, baseURL: nil)
        } else {
            
            self.wkWebview!.load(NSURLRequest.init(url: NSURL.init(string: self.webUrl!)! as URL) as URLRequest)

        }
        
        
    }

    /*
     *添加观察者
     *作用：监听 加载进度值estimatedProgress、是否可以返回上一网页canGoBack、页面title
     */
    func addKVOObserver()
    {
       //添加监测网页加载进度的观察者
        self.wkWebview!.addObserver(
                self,
                forKeyPath: NSStringFromSelector(#selector(getter: self.wkWebview!.estimatedProgress)),
                options: [],
                context: nil)
        self.wkWebview!.addObserver(
                self,
                forKeyPath: "title",
                options: .new,
                context: nil)
    }

    /*
     *移除观察者,类似OC中的dealloc
     *观察者的创建和移除一定要成对出现
     */
    deinit
    {
        self.wkWebview?.removeObserver(self, forKeyPath: NSStringFromSelector(#selector(getter: self.wkWebview!.estimatedProgress)))
        self.wkWebview?.removeObserver(self, forKeyPath: "title")
             
    }

 

    /*
     *观察者的监听方法
     */
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {

        if keyPath == NSStringFromSelector(#selector(getter: self.wkWebview!.estimatedProgress))
        {
            print(self.progress.progress)
            self.progress.alpha = 1.0
            self.progress .setProgress(Float(self.wkWebview!.estimatedProgress), animated: true)
            if self.wkWebview!.estimatedProgress >= 1
            {
                UIView.animate(withDuration: 1.0, animations: {
                    self.progress.alpha = 0
                }, completion: { (finished) in
                    self.progress .setProgress(0.0, animated: false)
                })
            }
        }
        else if keyPath == "title"
        {
            self.navigationItem.title = self.wkWebview!.title
        }
        else
        {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

    
    
    
    //MARK:-UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("滑动中")
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("停止滑动")
    }
    
    //MARK:-WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("面开始加载时调用")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("面加载失败时调用")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("面加载完成")

    }


      /*
       *懒加载UIProgressView进度条对象
       */
      lazy var progress:UIProgressView =
      {
          () -> UIProgressView in
          var rect:CGRect = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 2.0)
          let tempProgressView = UIProgressView.init(frame: rect)
          tempProgressView.tintColor = UIColor.red
          tempProgressView.backgroundColor = UIColor.gray
          return tempProgressView
      }()

    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
