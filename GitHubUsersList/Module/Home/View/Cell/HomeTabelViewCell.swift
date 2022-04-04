//
//  HomeTabelViewCell.swift
//  GitHubUsersList
//
//  Created by YUI on 2022/3/28.
//

import UIKit

enum HomeTabelViewCellStyle {
    
    case displayOnly
    case followSelected
}

class HomeTabelViewCell: UITableViewCell {
    
    var iconIV : UIImageView!
    var nameLabel : UILabel!
    var scoreLabel : UILabel!
    var urlLabel : UILabel!
    var followBtn : UIButton!
    var homeTabelViewCellStyle = HomeTabelViewCellStyle.displayOnly
    var lineView : UIView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        if(reuseIdentifier == "HomeTabelViewCellDisplayOnly"){
            
            homeTabelViewCellStyle = HomeTabelViewCellStyle.displayOnly
        }
        else if(reuseIdentifier == "HomeTabelViewCellFollowSelected"){
            
            homeTabelViewCellStyle = HomeTabelViewCellStyle.followSelected
        }
        
        self.didInitialize()
        self.setupMainView()
        self.initSubviews()
        self.setupSubviewsConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupMainView() {
        
        self.contentView.backgroundColor = UIColor.white
    }
    
    override func initSubviews() {
        
        iconIV = UIImageView()
        self.contentView.addSubview(iconIV)
        
        nameLabel = UILabel()
        nameLabel.textColor = UIColor.qmui_color(withHexString: "#000000")
        nameLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.black)
        nameLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.horizontal)
        self.contentView.addSubview(nameLabel)
        
        scoreLabel = UILabel()
        scoreLabel.textColor = UIColor.qmui_color(withHexString: "#6D6D6D")
        scoreLabel.setContentHuggingPriority(UILayoutPriority.fittingSizeLevel, for: NSLayoutConstraint.Axis.horizontal)
        scoreLabel.font = UIFont.systemFont(ofSize: 13)
        self.contentView.addSubview(scoreLabel)
        
        urlLabel = UILabel()
        urlLabel.textColor = UIColor.qmui_color(withHexString: "#6D6D6D")
        urlLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.black)
        self.contentView.addSubview(urlLabel)
        
        if(homeTabelViewCellStyle == HomeTabelViewCellStyle.followSelected){
            
            followBtn = UIButton(type: UIButton.ButtonType.custom)
            followBtn.setTitle("关注", for: UIControl.State.normal)
            followBtn.setTitle("已关注", for: UIControl.State.selected)
            followBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
            followBtn.layer.cornerRadius = 4
            followBtn.backgroundColor = UIColor.black
            followBtn.titleLabel?.font =  UIFont.systemFont(ofSize: 11)
            followBtn.addTarget(self, action: #selector(tapFollow), for: UIControl.Event.touchDown)
            self.contentView.addSubview(followBtn)
        }
        
        lineView = UIView()
        lineView.backgroundColor = UIColor.qmui_color(withHexString: "#EFEFEF")
        self.contentView.addSubview(lineView)
    }
    
    override func setupSubviewsConstraints() {
        
        // TODO: adaptWidthRatio太长了宏不知道怎么处理
        iconIV.snp.makeConstraints { make in
            
            make.width.height.equalTo(LayoutKit.sharedInstance().adaptWidthRatio(32))
            make.left.equalToSuperview().offset(LayoutKit.sharedInstance().adaptWidthRatio(20))
            make.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            
            make.left.equalTo(iconIV.snp.right).offset(LayoutKit.sharedInstance().adaptWidthRatio(10))
            make.top.equalTo(iconIV)
        }
        
        if(homeTabelViewCellStyle == HomeTabelViewCellStyle.followSelected){
            
            scoreLabel.snp.makeConstraints { make in
                
                make.left.equalTo(nameLabel.snp.right).offset(LayoutKit.sharedInstance().adaptWidthRatio(10))
                make.right.equalTo(followBtn.snp.left).offset(-LayoutKit.sharedInstance().adaptWidthRatio(10))
                make.centerY.equalTo(nameLabel)
            }
        }
        else if(homeTabelViewCellStyle == HomeTabelViewCellStyle.displayOnly){
            
            scoreLabel.snp.makeConstraints { make in
                
                make.left.equalTo(nameLabel.snp.right).offset(LayoutKit.sharedInstance().adaptWidthRatio(10))
                make.right.equalToSuperview().offset(-LayoutKit.sharedInstance().adaptWidthRatio(10))
                make.centerY.equalTo(nameLabel)
            }
        }
        
        if(homeTabelViewCellStyle == HomeTabelViewCellStyle.followSelected){
            
            urlLabel.snp.makeConstraints { make in
                
                make.left.equalTo(iconIV.snp.right).offset(LayoutKit.sharedInstance().adaptWidthRatio(10))
                make.right.equalTo(followBtn.snp.left).offset(-LayoutKit.sharedInstance().adaptWidthRatio(10))
                make.top.equalTo(nameLabel.snp.bottom).offset(LayoutKit.sharedInstance().adaptWidthRatio(5))
            }
        }
        else if(homeTabelViewCellStyle == HomeTabelViewCellStyle.displayOnly){
            
            urlLabel.snp.makeConstraints { make in
                
                make.left.equalTo(iconIV.snp.right).offset(LayoutKit.sharedInstance().adaptWidthRatio(10))
                make.right.equalToSuperview().offset(-LayoutKit.sharedInstance().adaptWidthRatio(10))
                make.top.equalTo(nameLabel.snp.bottom).offset(LayoutKit.sharedInstance().adaptWidthRatio(5))
            }
        }
        
        if(homeTabelViewCellStyle == HomeTabelViewCellStyle.followSelected){
            
            followBtn.snp.makeConstraints { make in
                
                make.width.equalTo(LayoutKit.sharedInstance().adaptWidthRatio(55))
                make.height.equalTo(LayoutKit.sharedInstance().adaptWidthRatio(24))
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(LayoutKit.sharedInstance().adaptWidthRatio(-28))
            }
        }
        
        lineView.snp.makeConstraints { make in
           
            make.left.equalToSuperview().offset(LayoutKit.sharedInstance().adaptWidthRatio(20))
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    @objc func tapFollow(){
        
        self.viewDelegate?.view?(self, withEvent: ["name":"tapFollow", "index": String(self.tag)])
    }
}
