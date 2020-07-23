//
//  LZBaseTableViewCell.swift
//  SMHCommerce
//
//  Created by lvzhao on 2020/5/29.
//  Copyright © 2020 lvzhao. All rights reserved.
//

import UIKit

class LZBaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white;
        self.selectionStyle = .none;
        self.accessoryType  = .none;
        
        setupBaseUI()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: setupBaseUI
    func setupBaseUI()  {
        self.contentView.addSubview(self.lineView)
        self.lineView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.width.equalTo(kScreenWidth-30)
            make.bottom.equalTo(-0.5)
            make.height.equalTo(0.5)
        }
        
        self.contentView.addSubview(self.rightImageView)
        self.rightImageView.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.size.equalTo(self.rightImageView.image!.size)
        }
    }
    
    var modelObject : AnyObject?{
        didSet{
            
        }
        
    }
    
    // MARK:懒加载
    lazy var rightImageView : UIImageView = {
       let rightImageView = UIImageView()
        rightImageView.image = UIImage.init(named: "ico_next_xiaojiantou")
        rightImageView.isHidden = true
        return rightImageView
    }()
    
    
    lazy var lineView : UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColorFromHex(rgbValue: 0xE5E5E5)
        lineView.isHidden = true
        return lineView
    }()
    
    
}
