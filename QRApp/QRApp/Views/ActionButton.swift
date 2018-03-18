//
//  ActionButton.swift
//  QRApp
//
//  Created by Ville Välimaa on 18/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import UIKit


/// "Button" class to be presented in ActionButtonView.
/// Contains label for description of the action of the button and
/// the button itself.
///
class ActionButton: UIView {
    
    private let button = with(TapButton()) {
        $0.layer.cornerRadius = CGFloat(ActionButtonView.buttonDiameter) / 2
    }
    
    private let label = with(UILabel()) {
        $0.textColor = .black
        $0.font = $0.font.withSize(12)
    }
    
    private let buttonImageScale = Int(ActionButtonView.buttonDiameter * 0.5)
    
    /// Pass-through click handler to the underlying TapButton instance
    ///
    var onClick: ((_ sender: TapButton) -> Void)? {
        didSet {
            button.onClick = onClick
        }
    }
    
    private var highlighted: Bool = false {
        didSet {
            button.alpha = highlighted ? 0.5 : 1.0
        }
    }
    
    init(title: String?, image: UIImage, backgroundColor: UIColor = .darkBlue) {
        super.init(frame: .zero)
        
        button.backgroundColor = backgroundColor
        button.imageView?.backgroundColor = .white
        button.setImage(image.scaled(width: buttonImageScale, height: buttonImageScale), for: .normal)
        label.text = title
        
        addSubview(button)
        addSubview(label)
        
        button.snp.makeConstraints { make in
            make.size.equalTo(ActionButtonView.buttonDiameter)
            make.centerY.equalTo(self)
            make.right.equalTo(self)
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalTo(button)
            make.right.equalTo(button.snp.left).inset(-10)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
