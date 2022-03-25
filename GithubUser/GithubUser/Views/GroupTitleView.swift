//
//  GroupHeadView.swift
//  GithubUser
//
//  Created by zhaitong on 2022/3/22.
//

import UIKit

class GroupTitleView: UIView {

    let lineView = UIView.init()
    let labelView = UILabel.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeLayout()
    }
    
    func initUI(){
        addSubview(lineView)
        addSubview(labelView)
        
        lineView.backgroundColor = .black
        labelView.text = "REPOSITORIES"
        labelView.textColor = .black
    }
    
    func makeLayout(){
        
        lineView.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(fitScale(size: 10))
            make.top.equalTo(labelView.snp.top)
            make.bottom.equalTo(labelView.snp.bottom)
            make.width.equalTo(fitScale(size: 3))
        }
        
        labelView.snp.makeConstraints { make in
            make.left.equalTo(lineView.snp.right).offset(fitScale(size: 5))
            make.centerY.equalTo(self.snp.centerY)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
