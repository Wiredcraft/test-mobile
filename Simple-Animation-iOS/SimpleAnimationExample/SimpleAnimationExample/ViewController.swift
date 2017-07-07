//
//  ViewController.swift
//  SimpleAnimationExample
//
//  Created by ShuRong Deng on 07/07/2017.
//  Copyright © 2017 ShuRong Deng. All rights reserved.
//



import UIKit

class ViewController: UIViewController {
    
    var gravitySquareView : GravtitySquareView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize = UIScreen.main.bounds
        gravitySquareView = GravtitySquareView(frame: CGRect(x: screenSize.width/2, y: screenSize.height/2, width: 80, height: 80))
        gravitySquareView?.backgroundColor = UIColor.darkGray
        self.view.addSubview(gravitySquareView!)
        gravitySquareView?.start()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

