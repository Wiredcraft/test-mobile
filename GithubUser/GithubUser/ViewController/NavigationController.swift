//
//  NavigationViewController.swift
//  UserListDemo
//
//  Created by zhaitong on 2022/3/22.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let target = self.interactivePopGestureRecognizer?.delegate
        let pan:UIPanGestureRecognizer = UIPanGestureRecognizer.init(target: target!, action: Selector(("handleNavigationTransition:")))
        self.view.addGestureRecognizer(pan)
        
        self.interactivePopGestureRecognizer?.isEnabled = false
        pan.delegate = self
        

        // Do any additional setup after loading the view.
    }

}


extension NavigationViewController: UIGestureRecognizerDelegate{
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.children.count > 1
    }
}
