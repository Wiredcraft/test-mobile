//
//  QREntryViewController.swift
//  QRGenerator
//
//  Created by tripleCC on 2018/1/23.
//  Copyright © 2018年 tripleCC. All rights reserved.
//

import UIKit
import RHSideButtons
import SnapKit

class QREntryViewController: UIViewController {
    private var qrcodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 20);
        label.textAlignment = .center
        return label
    }()
    private var sideButton: RHSideButtons?
    private var buttons = [RHButtonView]()
    override func viewDidLoad() {
        setupNavigation()
        addSideButtons()
        
    }
    
    private func layoutPageSubviews() {
        view.addSubview(qrcodeLabel)
        qrcodeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.right.equalTo(view)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sideButton?.setTriggerButtonPosition(CGPoint(x: UIScreen.main.bounds.width - 85, y: UIScreen.main.bounds.height - 85))
    }
    
    private func setupNavigation() {
        navigationItem.title = "Home"
    }

    private func addSideButtons() {
        let triggerButton = RHTriggerButtonView(pressedImage: UIImage(named: "add_icon")!) {
            $0.image = UIImage(named: "add_icon")
            $0.hasShadow = true
        }
        
        let sideButtonsView = RHSideButtons(parentView: view, triggerButton: triggerButton)
        sideButtonsView.delegate = self
        sideButtonsView.dataSource = self
        
        buttons.append(RHButtonView {
            $0.image = UIImage(named: "qrcode_generate_icon")
            $0.hasShadow = true
        })
        buttons.append(RHButtonView {
            $0.image = UIImage(named: "qrcode_scan_icon")
            $0.hasShadow = true
        })
        sideButton = sideButtonsView
    }
}

extension QREntryViewController: RHSideButtonsDataSource {
    
    func sideButtonsNumberOfButtons(_ sideButtons: RHSideButtons) -> Int {
        return buttons.count
    }
    
    func sideButtons(_ sideButtons: RHSideButtons, buttonAtIndex index: Int) -> RHButtonView {
        return buttons[index]
    }
}

extension QREntryViewController: RHSideButtonsDelegate {
    func sideButtons(_ sideButtons: RHSideButtons, didTriggerButtonChangeStateTo state: RHButtonState) {
    }
    
    func sideButtons(_ sideButtons: RHSideButtons, didSelectButtonAtIndex index: Int) {
        if index == 0 {
            let viewController = QRGeneratorViewController()
            navigationController?.pushViewController(viewController, animated: true)
        } else if index == 1 {
            
            let viewController = QRScannerViewController()
            viewController.delegate = self
            navigationController?.present(UINavigationController(rootViewController: viewController), animated: true, completion: nil)
        }
    }
}

extension QREntryViewController: QRScannerViewControllerDelegate {
    func scannerViewController(_ viewController: UIViewController, didFinishScanWithResult result: String?) {
        viewController.dismiss(animated: true, completion: nil)
        
        qrcodeLabel.text = result
    }
}
