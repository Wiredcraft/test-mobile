//
//  ViewController.swift
//  QRApp
//
//  Created by 顾强 on 16/5/17.
//  Copyright © 2016年 johnny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cloudBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var cloudBtnPosition: NSLayoutConstraint!
    @IBOutlet weak var cameraBtnPosition: NSLayoutConstraint!
    
    private struct MenuAnimationKeys{
        static var CameraBtnOutTimeInterval:NSTimeInterval = 0.5
        static var CloudBtnOutTimeInterval:NSTimeInterval = 0.3
        static var CameraBtnOutPosition:CGFloat = 10
        static var CloudBtnOutPosition:CGFloat = 70
        static var CameraBtnInPosition:CGFloat = -50
        static var CloudBtnInPosition:CGFloat = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.edgesForExtendedLayout = UIRectEdge.None
        self.navigationController?.navigationBar.translucent = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func menuBtn_Pressed(sender: UIButton) {
        if sender.selected {
            self.cameraBtn.hidden = false
            UIView.animateWithDuration(MenuAnimationKeys.CameraBtnOutTimeInterval, animations: {
                self.cameraBtnPosition.constant = MenuAnimationKeys.CameraBtnOutPosition
                self.view.layoutIfNeeded()
            }) { (success) in
                self.cloudBtn.hidden = false
                UIView.animateWithDuration(MenuAnimationKeys.CloudBtnOutTimeInterval, animations: {
                    self.cloudBtnPosition.constant = MenuAnimationKeys.CloudBtnOutPosition
                    self.view.layoutIfNeeded()
                    }, completion: { (success) in
                        self.menuBtn.setImage(UIImage.init(named: "menuOut"), forState: UIControlState.Normal)
                })
            }
        }else{
            UIView.animateWithDuration(MenuAnimationKeys.CloudBtnOutTimeInterval, animations: {
                self.cloudBtnPosition.constant = MenuAnimationKeys.CloudBtnInPosition
                self.view.layoutIfNeeded()
            }) { (success) in
                self.cloudBtn.hidden = true
                UIView.animateWithDuration(MenuAnimationKeys.CameraBtnOutTimeInterval, animations: {
                    self.cameraBtnPosition.constant = MenuAnimationKeys.CameraBtnInPosition
                    self.view.layoutIfNeeded()
                    }, completion: { (success) in
                        self.cameraBtn.hidden = true
                        self.menuBtn.setImage(UIImage.init(named: "menuIn"), forState: UIControlState.Normal)
                })
            }
        }
        sender.selected = !sender.selected
    }

    func menuSwitch(open:Bool){
        print("sss")
    }
    

}

