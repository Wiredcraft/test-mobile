//
//  HomeView.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/17.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import UIKit

class HomeView: UIView {
    var scanButton : UIButton?      //scan QR code
    var generateButton : UIButton?  //generate QR code
    var moreButton : UIButton?      //show detail opeations
    let buttonWidth = 55.0

    var _isShowingDetailOperations : Bool = false
    var isShowingDetailOperations: Bool {
        set {
            _isShowingDetailOperations = newValue
            if isShowingDetailOperations {
                self.showDetailOperations()
            } else {
                self.hideDetailOperations()
            }
        }
        get {
            return _isShowingDetailOperations
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadSubViews()
        self.loadLogics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadSubViews() {
        self.moreButton = UIButton.init(type: .custom)
        self.moreButton?.setTitle("+", for: .normal)
        self.moreButton?.setTitleColor(.white, for: .normal)
        self.moreButton?.backgroundColor = themeColor
        self.moreButton?.titleLabel?.font = .systemFont(ofSize: 36)
        self.addSubview(self.moreButton!)
        self.moreButton?.snp.makeConstraints({ (maker) in
            maker.size.equalTo(CGSize.init(width: buttonWidth, height: buttonWidth))
            maker.bottom.equalToSuperview().offset(-40)
            maker.right.equalToSuperview().offset(-20)
        })
        
        self.generateButton = UIButton.init(type: .custom)
        self.generateButton?.setImage(UIImage.init(named: "icon-assets-receive"), for: .normal)
        self.generateButton?.setTitleColor(.white, for: .normal)
        self.generateButton?.backgroundColor = themeColor
        self.addSubview(self.generateButton!)
        self.generateButton?.snp.makeConstraints({ (maker) in
            maker.size.equalTo(self.moreButton!)
            maker.centerX.equalTo(self.moreButton!)
            maker.bottom.equalTo(self.moreButton!).offset(0)
        })
        
        self.scanButton = UIButton.init(type: .custom)
        self.scanButton?.setImage(UIImage.init(named: "icon-scan-white"), for: .normal)
        self.scanButton?.setTitleColor(.white, for: .normal)
        self.scanButton?.backgroundColor = themeColor
        self.addSubview(self.scanButton!)
        self.scanButton?.snp.makeConstraints({ (maker) in
            maker.size.equalTo(self.moreButton!)
            maker.centerX.equalTo(self.moreButton!)
            maker.bottom.equalTo(self.moreButton!).offset(0)
        })
        
        self.bringSubviewToFront(self.moreButton!)
    }
    
    func loadLogics() {
        self.moreButton?.addTarget(self, action: #selector(moreButtonClicked(_sender:)), for: .touchUpInside)
        self.scanButton?.addTarget(self, action: #selector(scanButtonClicked), for: .touchUpInside)
        self.generateButton?.addTarget(self, action: #selector(generateButtonClicked), for: .touchUpInside)
    }
    
    @objc func moreButtonClicked(_sender: UIButton) {
        self.isShowingDetailOperations = !self.isShowingDetailOperations
    }
    
    @objc func scanButtonClicked() {
        self.isShowingDetailOperations = false
    }
    
    @objc func generateButtonClicked() {
        self.isShowingDetailOperations = false
    }
    
    func showDetailOperations() {
        let buttonsSpace = 20.0
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
            let scanButtonMoveOffset = -(buttonsSpace + self.buttonWidth) * 2
            self.scanButton?.snp.updateConstraints({ (maker) in
                maker.bottom.equalTo(self.moreButton!).offset(scanButtonMoveOffset)
            })
            
            let generateButtonMoveOffset = -(buttonsSpace + self.buttonWidth)
            self.generateButton?.snp.updateConstraints({ (maker) in
                maker.bottom.equalTo(self.moreButton!).offset(generateButtonMoveOffset)
            })
            
            self.layoutIfNeeded()
        }
    }
    
    func hideDetailOperations() {
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
            self.scanButton?.snp.updateConstraints({ (maker) in
                maker.bottom.equalTo(self.moreButton!).offset(0)
            })
            
            self.generateButton?.snp.updateConstraints({ (maker) in
                maker.bottom.equalTo(self.moreButton!).offset(0)
            })
            
            self.layoutIfNeeded()
        }
    }

    override func layoutSubviews() {
        self.moreButton?.layer.cornerRadius = 55.0 / 2.0;
        self.moreButton?.layer.masksToBounds = true
        self.scanButton?.layer.cornerRadius = 55.0 / 2.0;
        self.scanButton?.layer.masksToBounds = true
        self.generateButton?.layer.cornerRadius = 55.0 / 2.0;
        self.generateButton?.layer.masksToBounds = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.isShowingDetailOperations {
            self.isShowingDetailOperations = false
        }
    }
}
