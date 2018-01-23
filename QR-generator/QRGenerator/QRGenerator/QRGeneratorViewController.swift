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
    private var expiresTimer: Timer?
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
    }
    
    private func setupQRCodeImage(seed: String?) {
        // generate qrcode image
        let qrcodeImage = seed.flatMap { QRCodeGenerator(string: $0).generate() }
        self.qrcodeImageView.image = qrcodeImage
    }
    
    private func setupAutoRefreshTimer(expiresAt: String?) {
        // invalid previous timer
        expiresTimer?.invalidate()
        
        let formatter = ISO8601DateFormatter()
        let expiresDate = expiresAt.flatMap { formatter.date(from: $0) }
        if let interval = expiresDate?.timeIntervalSince(Date()) {
            expiresTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { [weak self] timer in
                self?.requestData()
            })
        }
    }
    
    private func requestData() -> Void {
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

