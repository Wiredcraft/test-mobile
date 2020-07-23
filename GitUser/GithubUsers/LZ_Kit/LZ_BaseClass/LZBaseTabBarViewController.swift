//
//  LZBaseTabBarViewController.swift
//  SMHCommerce
//
//  Created by lvzhao on 2020/1/6.
//  Copyright © 2020 lvzhao. All rights reserved.
//

import UIKit

class LZBaseTabBarViewController: UITabBarController , LZBaseTabbarDelegate , UITabBarControllerDelegate{

    
    @objc var customTabbar = LZBaseTabBar()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false
        
        UITabBar.appearance().tintColor = UIColor.white
        
        let tabbar = LZBaseTabBar.init()
        self.customTabbar = tabbar
        self.setValue(self.customTabbar, forKey: "tabBar")
        self.customTabbar.customDelegate = self
        self.delegate = self
        
        //未被选中的颜色.代销
        UITabBarItem.appearance().setTitleTextAttributes([
            .foregroundColor : UIColorFromHex(rgbValue: 0x868686),
            .font : ktextFont(size: 10)]
            , for: .normal)


        //选中的大小, 颜色
        UITabBarItem.appearance().setTitleTextAttributes([
            .foregroundColor:UIColorFromHex(rgbValue: 0xFF661B),
            .font: ktextFont(size: 10)]
            , for: .selected)

        UITabBar.appearance().unselectedItemTintColor = UIColorFromHex(rgbValue: 0x868686)
        UITabBar.appearance().tintColor = UIColorFromHex(rgbValue: 0xFF661B)
        self.addControllers()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK- LZBaseTabbarDelegate
    func tabBarDidClickPlusButton(tabbarButton: UIButton) {
        
        self.selectedIndex = 0
        tabbarButton.isHidden = true
        
    }
    
    //MARK: 添加子控制器
    func addControllers()  {
        
        let childControllers : [String] = ["SMHHomeViewController","SMHTeamViewController","SMHDataViewController","SMHProductViewController","SMHMineViewController"]
        let titles : [String] = ["","销售部","数据部","订货部","工作台"]
        let norImageNames : [String] = ["","icon_team_unselect","icon_crowd_unselect","icon_product_unselect","icon_mine_unselect"]
        let selectImgNames : [String] = ["","icon_team_select","icon_crowd_select","icon_product_select","icon_mine_select"]

        self.addSubViewControllers(childControllers: childControllers as NSArray, titles: titles as NSArray, norImageNames: norImageNames as NSArray, selectImgNames: selectImgNames as NSArray)
    }
    
    
 
    
    func addSubViewControllers(childControllers: NSArray, titles: NSArray, norImageNames: NSArray, selectImgNames:NSArray) {
        
        var controllers : [LZBaseNavViewController] = []
        for i in 0..<childControllers.count {
            
            
            let appName = Bundle.main.infoDictionary!["CFBundleName"]
            
            //NSClassFromString("项目名称+类名")
            let class_VC =  NSClassFromString("\(appName ?? "").\(childControllers.object(at:i))") as! UIViewController.Type
            let controller : UIViewController? = class_VC.init()
            let nav = LZBaseNavViewController.init(rootViewController: controller!)
            controllers.append(nav)

            let norImageName : String = norImageNames[i] as! String
            let selectImageName : String = selectImgNames[i] as! String

            let norImage = UIImage.init(named: norImageName)?.withRenderingMode(.alwaysOriginal)
            let selectImage = UIImage.init(named: selectImageName)?.withRenderingMode(.alwaysOriginal)
            

            controller?.tabBarItem = UITabBarItem.init(title: titles[i] as? String, image: norImage, selectedImage: selectImage)
            controller?.tabBarItem.tag = i
        }

        self.viewControllers = controllers

    }

    
    //MARK- UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController.tabBarItem.tag == 0{
            self.customTabbar.tabbarButton.isSelected = false
            self.customTabbar.tabbarButton.isHidden = false
            self.viewControllers?.first?.tabBarItem.image = UIImage.init(named: "")?.withRenderingMode(.alwaysOriginal)
            self.viewControllers?.first?.tabBarItem.title = "";
        } else {
            self.customTabbar.tabbarButton.isHidden = true
            self.viewControllers?.first?.tabBarItem.image = UIImage.init(named: "icon_home_unselect")?.withRenderingMode(.alwaysOriginal)
            self.viewControllers?.first?.tabBarItem.title = "速卖货";
        }
        return true
    }
   
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
