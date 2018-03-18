//
//  ButtonActionView.swift
//  QRApp
//
//  Created by Ville Välimaa on 18/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import UIKit
import SnapKit

@objc protocol ActionButtonViewDelegate {
    func numberOfButtonsInButtonActionView(_ buttonActionView: ActionButtonView) -> Int
    func actionButtonView(_ buttonActionView: ActionButtonView, titleForButtonAtIndex index: Int) -> String?
    func actionButtonView(_ buttonActionView: ActionButtonView, imageForButtonAtIndex index: Int) -> UIImage?
    func actionButtonView(_ buttonActionView: ActionButtonView, didSelectButtonAtIndex index: Int)
}

class ActionButtonView: UIView {
    
    static let buttonDiameter = CGFloat(60)
    
    private let buttonMargin = CGFloat(20)
    
    // Are the action buttons in the view displayed or not.
    //
    private var isOpen: Bool = false
    
    // Array to handle references to the action button
    //
    private var actionButtons: [ActionButton] = []
    
    weak var delegate: ActionButtonViewDelegate?
    
    private let triggerButton = with(TapButton(image: UIImage(named: "plus"))) {
        $0.backgroundColor = .darkBlue
        $0.layer.cornerRadius = ActionButtonView.buttonDiameter / 2
    }
    
    init(superview: UIView, delegate: ActionButtonViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        superview.addSubview(self)
        addSubview(triggerButton)
        
        snp.makeConstraints { make in
            make.edges.equalTo(superview)
        }
        
        triggerButton.snp.makeConstraints { make in
            make.width.height.equalTo(ActionButtonView.buttonDiameter)
            make.right.bottom.equalTo(superview).inset(20)
        }
        
        generateActionButtons()
        
        triggerButton.onClick = { [weak self] _ in
            guard let sself = self else { return }
            sself.displayButtonsState(!sself.isOpen)
        }
    }
    
    private func displayButtonsState(_ show: Bool) {
        // Present and animate individual buttons.
        //
        for (index, button) in self.actionButtons.enumerated() {
            UIView.animate(withDuration: 0.2, delay: index.asDouble() * 0.1, animations: {
                button.alpha = show ? 1 : 0
                button.transform =  show ? CGAffineTransform(translationX: 0, y: -20 - index.asCGFloat() * 20) : .identity
            }, completion: nil)
        }
        
        // Animate trigger button.
        //
        UIView.animate(withDuration: 0.2 + 0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: [], animations: {
            self.triggerButton.transform = show ? CGAffineTransform(rotationAngle: CGFloat.pi * 5 / 4) : .identity
        }, completion: nil)
        self.isOpen = show
    }
    
    private func generateActionButtons() {
        let numberOfButtons = delegate?.numberOfButtonsInButtonActionView(self) ?? 0
        
        for index in 0 ..< numberOfButtons {
            let title = delegate?.actionButtonView(self, titleForButtonAtIndex: index) ?? ""
            let image = delegate?.actionButtonView(self, imageForButtonAtIndex: index) ?? UIImage()
            
            let button = ActionButton(title: title, image: image)
            button.alpha = 0
            
            addSubview(button)
            
            button.snp.makeConstraints({ make in
                make.width.equalTo(200)
                make.height.equalTo(70)
                make.bottom.equalTo(triggerButton.snp.top).offset(getButtonOffsetForTriggerButton(index))
                make.right.equalTo(triggerButton.snp.right)
            })
            
            button.onClick = { [weak self] _ in
                guard let sself = self else { return }
                sself.delegate?.actionButtonView(sself, didSelectButtonAtIndex: index)
                sself.displayButtonsState(false)
            }
            
            actionButtons.append(button)
        }
    }
    
    private func getButtonOffsetForTriggerButton(_ index: Int) -> CGFloat {
        return -buttonMargin + CGFloat(index) * (-ActionButtonView.buttonDiameter - buttonMargin)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
