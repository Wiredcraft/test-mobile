//
//  LZBaseViewController.swift
//  SMHCommerce
//
//  Created by lvzhao on 2020/1/6.
//  Copyright © 2020 lvzhao. All rights reserved.
//

import UIKit

class LZBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColorFromHex(rgbValue: 0xF2F2F2)
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = .all

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.navigationController?.viewControllers.count != 1 {
            
            showCustomNavigationBackButton()
        }
    }
    
    //MARK: 重写返回按钮
    func showCustomNavigationBackButton() {
        
        let image = UIImage(named: "ico_back")
        let selectedImg = UIImage(named: "ico_back")
        let backBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 44))
        backBtn.addTarget(self, action: #selector(onBackButtonAction), for: .touchUpInside)
        backBtn.setImage(image, for: .normal)
        backBtn.setImage(selectedImg, for: .selected)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        backBtn.contentHorizontalAlignment = .left
        backBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

        
    }
    
    @objc func onBackButtonAction(button:UIButton)  {
        
        self.navigationController?.popViewController(animated: true)
    }
    

    override var hidesBottomBarWhenPushed: Bool{
        
        get{
            return super.hidesBottomBarWhenPushed
        }
        set(hidesBottomBarWhenPushed){
            super.hidesBottomBarWhenPushed = true
        }
        
    }


    /*0
    leftBarButtonItems
    1
    rightBarButtonItems
    -
     */
    func initBarItem(view:UIView, type:Int) {
        switch type {
        case 0:
                           
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: view)

        default:
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: view)

        }
        
    }

    
   
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .default
    }
    

}
