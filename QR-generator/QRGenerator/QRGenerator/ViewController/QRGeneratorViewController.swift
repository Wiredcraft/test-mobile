//
//  ViewController.swift
//  QRGenerator
//
//  Created by tripleCC on 2018/1/22.
//  Copyright © 2018年 tripleCC. All rights reserved.
//

import UIKit
import Toast_Swift
import SnapKit
import Moya
import ObjectMapper

class QRGeneratorViewController: UIViewController {
    private var seedCancellable: Cancellable?
    private let seedExpiredLabel = QRCountDownLabel()
    private lazy var qrcodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.gray.cgColor
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        layoutPageSubviews()
        requestData()
    }
    
    deinit {
        // cancel the request when the page is been destroyed
        seedCancellable?.cancel()
    }
    
    @objc func refreshButtonOnClick() {
        // cancel the previous request
        seedCancellable?.cancel()
        requestData()
    }
    
    private func setupNavigation() {
        navigationItem.title = "QRGenerator"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshButtonOnClick))
    }
    
    private func layoutPageSubviews() {
        view.addSubview(qrcodeImageView)
        qrcodeImageView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.width.height.equalTo(300)
        }
        view.addSubview(seedExpiredLabel)
        seedExpiredLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(qrcodeImageView.snp.bottom).offset(20)
        }
    }
    
    private func setupQRCodeImage(seed: String?) {
        // generate qrcode image
        let qrcodeImage = seed.flatMap { QRCodeGenerator(string: $0).generate() }
        self.qrcodeImageView.image = qrcodeImage
    }
    
    private func setupAutoRefreshTimer(expiresAt: String?) {

        let expiresDate = expiresAt.flatMap { ISO8601DateFormatter().date(from: $0) }
        if let interval = expiresDate?.timeIntervalSince(Date()) {
            seedExpiredLabel.start(with: interval, completion: { [weak self] in
                self?.requestData()
            })
        }
    }
    
    private func requestData() -> Void {
        if let seed = Seed.unarchiveFromDisk(),
            seed.expiresDate == nil || Date() <= seed.expiresDate!  {
            // if cached seed is valid, then show the qrcode image.
            self.setupQRCodeImage(seed: seed.seed)
            self.setupAutoRefreshTimer(expiresAt: seed.expiresAt)
        }  else {
            // request seed json
            view.makeToastActivity(.center)
            seedCancellable = QRGeneratorProvider.request(.seed) { result in
                self.view.hideToastActivity()
                switch result {
                case let .success(response):
                    // parse data to json
                    if let json = try? response.mapJSON() {
                        // map to seed model
                        if let seed = Mapper<Seed>().map(JSONObject: json) {
                            
                            seed.archiveToDisk()
                            self.setupQRCodeImage(seed: seed.seed)
                            self.setupAutoRefreshTimer(expiresAt: seed.expiresAt)
                        }
                    }
                case let .failure(error):
                    self.view.makeToast(error.localizedDescription)
                }
            }
        }
        
    }
}

