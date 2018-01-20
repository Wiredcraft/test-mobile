//
//  QRCountDownLabel.swift
//  QRGenerator
//
//  Created by 杨志超 on 2018/1/20.
//  Copyright © 2018年 buginux. All rights reserved.
//

import UIKit

class QRCountDownLabel: UILabel {
    var remainSeconds: Int = 0
    var timer: Timer?
    weak var delegate: QRCountDownLabelDelegate?
    
    func startCountDown(withExpiresAt expiresAt: TimeInterval) {
        remainSeconds = Int(ceil(expiresAt - Date().timeIntervalSince1970))
        text = "\(remainSeconds) s"
        
        // Invalidate before set new timer
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        remainSeconds -= 1
        
        // Reach expire time
        if remainSeconds >= 1 {
            text = "\(remainSeconds) s"
        } else {
            delegate?.countDownLabelDidExpired()
            timer?.invalidate()
        }
    }
}

protocol QRCountDownLabelDelegate: class {
    func countDownLabelDidExpired()
}
