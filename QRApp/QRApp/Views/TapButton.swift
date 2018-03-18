//
//  TapButton.swift
//  QRApp
//
//  Created by Ville Välimaa on 18/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import UIKit

/// Generic base class for button that highlights on tap
/// and provides basic click handler.
///
class TapButton: UIButton {
    
    var onClick: ((_ sender: TapButton) -> Void)?
    
    private var isBeingTapped: Bool = false {
        didSet {
            alpha = isBeingTapped ? 0.5 : 1.0
        }
    }
    
    init() {
        super.init(frame: .zero)
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(touchUpOutside), for: .touchUpOutside)
        addTarget(self, action: #selector(touchDragEnter), for: .touchDragEnter)
        addTarget(self, action: #selector(touchDragExit), for: .touchDragExit)
        addTarget(self, action: #selector(touchCancel), for: .touchCancel)
    }
    
    private func buttonClicked() {
        onClick?(self)
        
        isBeingTapped = true
        UIView.animate(withDuration: 0.1) {
            self.isBeingTapped = false
        }
    }
    
    @objc private func touchDown() {
        isBeingTapped = true
    }
    @objc private func touchUpInside() {
        buttonClicked()
    }
    @objc private func touchUpOutside() {
        isBeingTapped = false
    }
    @objc private func touchDragEnter() {
        isBeingTapped = true
    }
    @objc private func touchDragExit() {
        isBeingTapped = false
    }
    @objc private func touchCancel() {
        isBeingTapped = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
