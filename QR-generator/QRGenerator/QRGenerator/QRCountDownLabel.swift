//
//  CountDownLabel.swift
//  QRGenerator
//
//  Created by tripleCC on 2018/1/24.
//  Copyright © 2018年 tripleCC. All rights reserved.
//

import UIKit
import SnapKit

class QRCountDownLabel: UIView {
    private var expiresTimer: Timer?
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(countLabel)
        countLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func start(with interval: TimeInterval, completion: (() -> Void)?) {
        // invalid previous timer
        expiresTimer?.invalidate()
        expiresTimer = nil
        
        var count = Int(interval)
        countLabel.text = String(count) + "S"
        
        expiresTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
            
            count -= 1
            self?.countLabel.text = String(count) + "S"
            if count <= 0 {
                completion?()
            }
        })
    }
}
