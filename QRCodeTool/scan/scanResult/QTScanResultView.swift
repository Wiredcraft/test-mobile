//
//  QTScanResultView.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/19.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import UIKit

class QTScanResultView: UIView {
    
    var qrCode: String? {
        didSet {
            self.updateUI()
        }
    }
    
    var qrCodeText: UITextView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadSubViews() {
        self.qrCodeText = UITextView.init()
        self.qrCodeText?.textColor = kThemeColor
        self.qrCodeText?.isEditable = false
        self.qrCodeText?.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(self.qrCodeText!)
        
        let edges = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        self.qrCodeText?.snp.makeConstraints({ (maker) in
            maker.edges.equalToSuperview().inset(edges)
        })
    }
    
    func updateUI() {
        self.qrCodeText?.text = self.qrCode
    }
}
