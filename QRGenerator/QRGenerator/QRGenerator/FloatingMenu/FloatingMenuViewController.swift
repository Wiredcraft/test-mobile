//
//  FloatingMenuViewController.swift
//  QRGenerator
//
//  Created by 杨志超 on 2018/1/21.
//  Copyright © 2018年 buginux. All rights reserved.
//

import UIKit

class FloatingMenuViewController: UIViewController {
    enum Direction {
        case Up
        case Down
        case Left
        case Right
        
        func offsetPoint(_ point: CGPoint, offset: CGFloat) -> CGPoint {
            switch self {
            case .Up:
                return CGPoint(x: point.x, y: point.y - offset)
            case .Down:
                return CGPoint(x: point.x, y: point.y + offset)
            case .Left:
                return CGPoint(x: point.x - offset, y: point.y)
            case .Right:
                return CGPoint(x: point.x + offset, y: point.y)
            }
        }
    }
    
    let fromView: UIView
    
    let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    let closeButton = FloatingButton(image: UIImage.closeImage(withSize: CGSize(width: 50.0, height: 50.0)), backgroundColor: UIColor.flatRedColor)
    
    weak var delegate: FloatingMenuViewControllerDelegate?
    var direction = Direction.Up
    var buttonPadding: CGFloat = 70.0
    var buttonItems = [FloatingButton]()
    
    init(fromView: UIView) {
        self.fromView = fromView
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blurredView.frame = view.bounds
        view.addSubview(blurredView)
        
        closeButton.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
        view.addSubview(closeButton)
        
        for button in buttonItems {
            button.addTarget(self, action: #selector(handleMenuButton(sender:)), for: .touchUpInside)
            view.addSubview(button)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureButtons()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleCloseButton()
    }
    
    func configureButtons() {
        let parentController = presentingViewController!
        let center = parentController.view.convert(fromView.center, from: fromView.superview)
        
        closeButton.center = center
        
        for (index, button) in buttonItems.enumerated() {
            button.center = direction.offsetPoint(center, offset: buttonPadding * CGFloat(index + 1))
        }
    }
    
    @objc func handleMenuButton(sender: FloatingButton) {
        if let index = buttonItems.index(of: sender) {
            delegate?.floatingMenuController?(controller: self, didTapButton: sender, atIndex: index)
        }
    }
    
    @objc func handleCloseButton() {
        delegate?.floatingMenuControllerDidCancel?(controller: self)
        dismiss(animated: true, completion: nil)
    }
}

@objc
protocol FloatingMenuViewControllerDelegate: class {
    @objc optional func floatingMenuController(controller: FloatingMenuViewController, didTapButton button: UIButton, atIndex index: Int)
    @objc optional func floatingMenuControllerDidCancel(controller: FloatingMenuViewController)
}
