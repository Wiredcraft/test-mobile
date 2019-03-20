//
//  QTToast.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/20.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import UIKit

class QTToast: NSObject {
    private var toastLabel: UILabel?
    private var containerView: UIView?
    
    init(_ toast: String?) {
        super.init()
        
        self.containerView = UIView.init()
        self.containerView?.alpha = 0
        self.containerView?.backgroundColor = .clear
        
        self.toastLabel = UILabel.init()
        self.toastLabel?.textColor = kTextColor
        self.toastLabel?.font = kTextFont
        self.toastLabel?.text = toast
        self.toastLabel?.backgroundColor = .gray
        self.toastLabel?.numberOfLines = 0
        self.toastLabel?.textAlignment = .center
        self.containerView?.addSubview(self.toastLabel!)
    }
    
    class func initAndShow(inView container: UIView, toast: String?) -> QTToast {
        let toast = QTToast.init(toast)
        toast.show(inView: container)
        return toast
    }
    
    func show(inView container: UIView) {
        self.containerView?.alpha = 0
        self.containerView?.frame = container.bounds
        container.addSubview(self.containerView!)
        
        self.layoutViews()
        
        self.containerView?.alpha = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.5, animations: {
                self.containerView?.alpha = 0
            }) { (finished) in
                self.containerView?.removeFromSuperview()
            }
        }
    }
    
    func layoutViews() {
        self.toastLabel?.sizeToFit()
        if (self.toastLabel?.width)! > (self.containerView?.width)! - 10 * 2 {
            self.toastLabel?.width = (self.containerView?.width)! - 10 * 2
            self.toastLabel?.sizeToFit()
        }
        self.toastLabel?.width = (self.toastLabel?.width)! + 10 * 2
        self.toastLabel?.height = (self.toastLabel?.height)! + 10 * 2
        self.toastLabel?.centerX = (self.containerView?.width)! / 2.0
        self.toastLabel?.bottom = (self.containerView?.height)! - 60.0
        self.toastLabel?.layer.cornerRadius = 4.0
        self.toastLabel?.layer.masksToBounds = true
    }
}
