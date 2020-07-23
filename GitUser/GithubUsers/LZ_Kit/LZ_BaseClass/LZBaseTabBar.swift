//
//  LZBaseTabBar.swift
//  SMHCommerce
//
//  Created by lvzhao on 2020/1/9.
//  Copyright © 2020 lvzhao. All rights reserved.
//

import UIKit

protocol LZBaseTabbarDelegate : NSObjectProtocol{
    
    func tabBarDidClickPlusButton(tabbarButton : UIButton)
    
}

class LZBaseTabBar: UITabBar {

    
    weak var customDelegate : LZBaseTabbarDelegate?
    
    
    //MARK:懒加载
    lazy var tabbarButton : UIButton = {
        let tabbarButton = UIButton()
        tabbarButton.setImage(UIImage.init(named: "icon_home_select"), for: .normal)
        tabbarButton.setImage(UIImage.init(named: "icon_home_select"), for: .highlighted)

        tabbarButton.frame = CGRect(x: 0, y: 0, width: (tabbarButton.imageView?.image?.size.width ?? 0) + 1, height: (tabbarButton.imageView?.image?.size.height ?? 0) + 1)
        tabbarButton.addTarget(self, action: #selector(respondsToPlusButton), for: .touchUpInside)

        return tabbarButton
    }()
    
    
    //MARK: 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.tabbarButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: 设置第一个按钮的位置
    override func layoutSubviews() {
        super.layoutSubviews()
        
    
        let btnW = self.frame.width / 5
        let index = 0.0
        for itemView in self.subviews {

            if itemView.isKind(of: NSClassFromString("UITabBarButton") ?? UIView.self){
                print("是")
                 if index == 0 {
                    let thisView = UIView()
                    thisView.frame = CGRect(x: 0, y: itemView.frame.minY, width: btnW, height: itemView.frame.height)
                    self.tabbarButton.center = CGPoint(x: itemView.frame.width * 0.5, y: itemView.frame.height * 0.5)
                }
                
            }
        }
    }
    
    
    // MARK: - 重写hitTest方法以响应点击超出tabBar的加号按钮
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !clipsToBounds && !isHidden && alpha > 0 {
            var result = super.hitTest(point, with: event)
            if result != nil {
                return result
            } else {
                for subview in subviews {
                    let subPoint = subview.convert(point, from: self)
                    result = subview.hitTest(subPoint, with: event)
                    if result != nil {
                        return result
                    }
                }
            }
        }
        return nil
    }


  
    

    @objc func respondsToPlusButton() {

        self.customDelegate?.tabBarDidClickPlusButton(tabbarButton: self.tabbarButton)
        

        
    }
    
    
    
}


