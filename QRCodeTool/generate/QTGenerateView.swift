//
//  QTGenerateView.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/19.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import UIKit

class QTGenerateView: UIView {
    
    var seed: QTSeed? {
        didSet {
            self.updateUI()
            self.startCountdown()
        }
    }
    
    var shouldUpdateSeed: (() -> Void)?
    
    var _isLoading: Bool?
    var isLoading: Bool? {
        set {
            _isLoading = newValue
            if newValue == true {
                self.indicator?.startAnimating()
            } else {
                self.indicator?.stopAnimating()
            }
        }
        get {
            return _isLoading
        }
    }
    
    var timer: Timer?
    let defaultRemainSeconds: Int = 60              //defalut auto-refresh timeInterval is 60s
    lazy var remainSeconds = defaultRemainSeconds
    
    var indicator: UIActivityIndicatorView?
    var qrCodeImgView: UIImageView?
    var countingLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadSubViews()
        self.loadLogics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadSubViews() {
        self.qrCodeImgView = UIImageView.init()
        self.addSubview(self.qrCodeImgView!)
        self.qrCodeImgView?.snp.makeConstraints({ (maker) in
            maker.width.equalToSuperview().multipliedBy(0.8)
            maker.height.equalTo((self.qrCodeImgView?.snp.width)!)
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview()
        })
        
        self.indicator = UIActivityIndicatorView.init(style: .gray)
        self.indicator?.hidesWhenStopped = true
        self.addSubview(self.indicator!)
        self.indicator?.snp.makeConstraints({ (maker) in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview()
        })
        
        self.countingLabel = UILabel.init()
        self.countingLabel?.textColor = kTextColor
        self.countingLabel?.font = kTextFont
        self.addSubview(self.countingLabel!)
        self.countingLabel?.snp.makeConstraints({ (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo((self.qrCodeImgView?.snp.bottom)!).offset(30)
        })
    }
    
    func loadLogics() {
        self.qrCodeImgView?.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(qrCodeImageDidTapped))
        self.qrCodeImgView?.addGestureRecognizer(tap)
    }
    
    @objc func qrCodeImageDidTapped() {
        if let seed = self.seed {
            let pasteboard = UIPasteboard.general
            pasteboard.string = seed.seed
            
            _ = QTToast.initAndShow(inView: self, toast: "Copied to Clipboard")
        }
    }
    
    func updateUI() {
        if let seed = self.seed?.seed {
            self.qrCodeImgView?.image = UIImage.qrCodeImage(with: seed)
        }
    }
    
    func startCountdown() {
        if (self.seed?.expireAt)! > NSTimeIntervalSince1970 {
            self.remainSeconds = Int((self.seed?.expireAt)! - NSDate().timeIntervalSince1970)
        } else {
            self.remainSeconds = defaultRemainSeconds
        }
        let timerIsOnUse = (self.timer != nil && (self.timer?.isValid)!)
        if (!timerIsOnUse) {
            self.timer = Timer.scheduledTimer(timeInterval: 1,
                                              target: self,
                                              selector: #selector(countDown),
                                              userInfo: nil,
                                              repeats: true)
        }
    }
    
    @objc func countDown() {
        self.countingLabel?.text = "\(remainSeconds)" + "s"
        if self.remainSeconds == 0 {
            if let callback = self.shouldUpdateSeed {
                callback()
            }
            self.stopCountdown()
        } else {
            self.remainSeconds -= 1
        }
    }
    
    func stopCountdown() {
        if (self.timer?.isValid ?? false) {
            self.timer?.invalidate()
            self.timer = nil
        }
        self.countingLabel?.text = ""
    }
}
