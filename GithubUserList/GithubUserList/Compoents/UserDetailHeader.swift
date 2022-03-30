//
//  UserDetailHeader.swift
//  GithubUserList
//
//  Created by zhaotianyang on 2022/3/31.
//

import Foundation
import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class UserDetailHeader: UIView {
    private let bag = DisposeBag()
    
    private let userIcon = UIImageView()
    private let nameLabel = UILabel()
    private let followButton = UIButton()
    private let titleView = ReposTitleView()
    
    var followAction: ((UserItemData)->Void)?
    
    private let userData: UserItemData
    private let originalHeight: CGFloat
    private var originalTopH: CGFloat {
        return originalHeight-30
    }
    private let path = UIBezierPath()
    private let shape = CAShapeLayer()
    
    init(user: UserItemData) {
        userData = user
        originalHeight = 240
        super.init(frame: CGRect(x: 0, y: 0, width: Const.Device.ScreenW, height: 290))
        initUI()
        shape.path = path.cgPath
        layer.addSublayer(shape)
        drawBottom()
        
        AppGlobal.followSigle
            .filter({ [weak self] in
                $0.uid == self?.userData.id
            })
            .subscribe(onNext: { [weak self] followType in
                self?.updateFollowButton(type: followType)
        }).disposed(by: bag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateFollowButton(type: UserFollow) {
        switch type {
        case .follow:
            followButton.setTitle("UnFollow", for: .normal)
        case .unFolllow:
            followButton.setTitle("Follow", for: .normal)
        }
    }
    
    private func initUI() {
        backgroundColor = Theme.Color.white
        
        let top = UIView()
        top.backgroundColor = Theme.Color.main
        addSubview(top)
        top.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(originalTopH)
        }
        
        addSubview(userIcon)
        userIcon.layer.backgroundColor = Theme.Color.bgColor.cgColor
        userIcon.layer.cornerRadius = 20
        userIcon.layer.masksToBounds = true
        let url = URL(string: userData.avatar_url ?? "")
        let processor = DownsamplingImageProcessor(size: CGSize(width: 40, height: 40))
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        userIcon.kf.indicatorType = .activity
        userIcon.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25)),
            ]
        )
        userIcon.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 40, height: 40)).priority(900)
            make.centerX.equalToSuperview()
            make.top.equalTo(Const.Device.StatusBarH+20)
        }
        
        addSubview(nameLabel)
        nameLabel.text = userData.login
        nameLabel.textColor = Theme.Color.white
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userIcon.snp.bottom).offset(15)
        }
        
        addSubview(followButton)
        followButton.layer.backgroundColor = Theme.Color.white.cgColor
        followButton.layer.cornerRadius = 5
        if userData.isFollow {
            followButton.setTitle("UnFollow", for: .normal)
        } else {
            followButton.setTitle("Follow", for: .normal)
        }
        followButton.setTitleColor(Theme.Color.title, for: .normal)
        followButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        followButton.addTarget(self, action: #selector(followClick), for: .touchUpInside)
        followButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(24).priority(900)
            make.width.equalTo(80)
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
        }
        
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func drawBottom() {
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        path.move(to: CGPoint(x: 0, y: originalTopH))
        path.addCurve(to: CGPoint(x: width, y: originalTopH), controlPoint1: CGPoint(x: width/2.0, y: height-50), controlPoint2: CGPoint(x: width/2.0, y: height-50))
        
        shape.fillColor = Theme.Color.main.cgColor
        shape.path = path.cgPath
    }
    
    @objc private func followClick() {
        followAction?(userData)
    }
    
    func updateHeader(_ ofsetY: CGFloat) {
        print(ofsetY)
    }
}
