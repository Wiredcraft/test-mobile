//
//  GravitySquareView.swift
//  SimpleAnimationExample
//
//  Created by ShuRong Deng on 07/07/2017.
//  Copyright © 2017 ShuRong Deng. All rights reserved.
//

import CoreMotion
import UIKit

class GravtitySquareView: UIView {
    
    var motionManager = CMMotionManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        guard let size = self.superview?.frame else { return }
        var f = self.frame
        
        
        if motionManager.isAccelerometerAvailable {
            let queue = OperationQueue.current
            
            /* Set the sampling frequency, the unit is seconds */
            motionManager.accelerometerUpdateInterval = 0.07
            
            /* The acceleration sensor starts sampling, and each sampling result is processed in the block */
            motionManager.startAccelerometerUpdates(to: queue!, withHandler: {
                [weak self] (accelerometerData, error) in
                
                guard let accelerometerData = accelerometerData else { return }
                
                f.origin.x += CGFloat(accelerometerData.acceleration.x  * 200) * 1
                f.origin.y += CGFloat(accelerometerData.acceleration.y  * 200) * -1
                
                if f.origin.x < 0 {
                   f.origin.x = 0
                }
                
                if f.origin.y < 0 {
                   f.origin.y = 0
                }
                
                if f.origin.x > (size.width - f.size.width) {
                    f.origin.x = (size.width - f.size.width)
                }
                
                if f.origin.y > (size.height - f.size.height) {
                    f.origin.y = (size.height - f.size.height)
                }
                
                /* move animation */
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(0.1)
                self?.frame = f
                UIView.commitAnimations()
            })
        }
    
    }
    
    func stop() {
        
        if motionManager.isAccelerometerAvailable {
            self.motionManager.stopAccelerometerUpdates()
        }
    }

}
