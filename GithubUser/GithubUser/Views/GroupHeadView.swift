//
//  HeaderView.swift
//  GithubUser
//
//  Created by zhaitong on 2022/3/22.
//

import UIKit

class GroupHeadView: UIView {

    let headerView = UIImageView.init()
    let userLabel = UILabel.init()
    let followBtn = UIButton.init()
    var followCallback:FollowCallback?
    
    var data:ListItem?{
        didSet {
            headerView.kf.setImage(with: URL(string: data?.avatar_url ?? ""), placeholder: UIImage.init(named: "man"), options: nil, completionHandler: nil)
            userLabel.text = data?.login
            if(data?.isFollow ?? false){
                followBtn.setTitle("已关注", for: .normal)
            }else{
                followBtn.setTitle("关注", for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        initUI();
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeLayout()
    }
    
    func initUI(){
        addSubview(headerView)
        addSubview(userLabel)
        addSubview(followBtn)
        
        headerView.layer.cornerRadius = fitScale(size: 30)
        headerView.layer.masksToBounds = true
        headerView.image = .init(named: "man")
        
        userLabel.text = ""
        userLabel.font = .systemFont(ofSize: fitScale(size: 15))
        userLabel.textColor = .white
        
        followBtn.setTitle("关注", for: .normal)
        followBtn.setTitleColor(.black, for: .normal)
        followBtn.titleLabel?.font = .systemFont(ofSize: fitScale(size: 11))
        followBtn.backgroundColor = .white
        followBtn.layer.cornerRadius = fitScale(size: 5)
        followBtn.layer.masksToBounds = true
        followBtn.contentEdgeInsets = .init(top: fitScale(size: 5), left: fitScale(size: 15), bottom: fitScale(size: 5), right: fitScale(size: 15))
        
        followBtn.addTarget(self, action: #selector(followAction), for: .touchUpInside)
    }
    
    func makeLayout(){
        headerView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(fitScale(size: 60))
            make.centerY.equalTo(self.snp.centerY).offset(fitScale(size: -20))
        }
        
        userLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(headerView.snp.bottom).offset(fitScale(size: 10))
        }
        
        followBtn.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(userLabel.snp.bottom).offset(fitScale(size: 10))
        }
    }
    
    @objc
    func followAction(){
        followCallback?(data)
    }
    
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        let path = UIBezierPath.init()
        path.move(to: .zero)
        path.addLine(to: .init(x: rect.width, y: 0))
        path.addLine(to: .init(x: rect.width, y: rect.height * 0.9))
        path.addQuadCurve(to: .init(x: rect.width*0.5, y: rect.height), controlPoint: .init(x: rect.width*0.75, y: rect.height))
        path.addQuadCurve(to: .init(x: 0, y: rect.height * 0.9), controlPoint: .init(x: rect.width*0.25, y: rect.height))
        path.close()
        ctx?.setFillColor(UIColor.init(white: 0.1, alpha: 1.0).cgColor)
        ctx?.addPath(path.cgPath)
        ctx?.fillPath()
        super.draw(rect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
