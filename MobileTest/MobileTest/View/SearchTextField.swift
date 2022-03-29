//
//  SearchTextField.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/26.
//

import Foundation
import SnapKit

class SearchTextField: UIView {
    
    private lazy var icon: UIImageView = {
        let imageV = UIImageView(image: UIImage.init(named: "search_icon"))
        imageV.contentMode = .scaleAspectFit
        return imageV
    }()
    
    
    public lazy var textField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
        
    
    private func commonInit() {
        backgroundColor = UIColor.init(hexString: "F5F5F5")
        layer.cornerRadius = 15.0
        addSubViews()
        layout()
    }
    
    
    private func addSubViews() {
        addSubview(icon)
        addSubview(textField)
    }
    
        
    private func layout() {
        icon.snp.makeConstraints { make in
            make.height.width.equalTo(15.0)
            make.right.equalTo(-15.0)
            make.centerY.equalToSuperview()
        }
        textField.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.right.equalTo(icon.snp.left).offset(-2.0)
            make.left.equalTo(15.0)
            make.centerY.equalToSuperview()
        }
    }
}

