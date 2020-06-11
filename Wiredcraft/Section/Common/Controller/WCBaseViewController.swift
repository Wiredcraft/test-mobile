//
//  WCBaseViewController.swift
//  Wiredcraft
//
//  Created by codeLocker on 2020/6/10.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit

/*
 the base class of viewController in project
 to handle some common logic
*/
class WCBaseViewController: UIViewController {
    
    /// the imageView show on the navigationBar
    fileprivate lazy var navigationTitleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "wc_navigation_title")
        return imageView
    }()
    
    /// it is a container view of the navigationTitleImageView
    fileprivate lazy var navigationTitleView: UIView = {
        let view = UIView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 100, height: UIScreen.es_navigationBarHeight)))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadUI()
        self.layout()
    }
    

    //MARK: - Load_UI
    private func loadUI() {
        self.view.backgroundColor = UIColor.white
        self.navigationItem.titleView = self.navigationTitleView
        self.navigationTitleView.addSubview(self.navigationTitleImageView)
    }

    /// make constraints
    private func layout() {
        self.navigationTitleImageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
