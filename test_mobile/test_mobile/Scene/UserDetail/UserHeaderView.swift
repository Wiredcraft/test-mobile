//
//  UserHeaderView.swift
//  test_mobile
//
//  Created by Jun Ma on 2022/3/20.
//

import UIKit
import SnapKit

class UserHeaderView: UIView {
    var heightConstraint: SnapKit.Constraint!
    var bottomConstraint: SnapKit.Constraint!
    
    let containerView = UIView()
    let arcView = UIView()
    let avatarImageView = UIImageView()
    let nameLabel = UILabel()
    let followButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        // container view
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // arc background
        containerView.addSubview(arcView)
        arcView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            self.bottomConstraint = make.bottom.equalToSuperview().constraint
            self.heightConstraint = make.height.equalToSuperview().constraint
        }
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 0, y: frame.height - 40))
        path.addQuadCurve(to: CGPoint(x: frame.width, y: frame.height - 40), controlPoint: CGPoint(x: frame.width / 2, y: frame.height + 40))
        path.addLine(to: CGPoint(x: frame.width, y: 0))
        path.close()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.fillColor = Constant.Color.color1a1a1a?.cgColor
        arcView.layer.addSublayer(shape)
        
        // avatar
        arcView.addSubview(avatarImageView)
        avatarImageView.contentMode = .scaleAspectFit
        let avatarWidth = 64.0
        avatarImageView.layer.cornerRadius = avatarWidth / 2
        avatarImageView.layer.masksToBounds = true
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: avatarWidth, height: avatarWidth))
        }
        
        // name
        arcView.addSubview(nameLabel)
        nameLabel.font = Constant.Font.ntr
        nameLabel.textColor = .white
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(avatarImageView.snp.bottom).offset(10)
        }
        
        // follow button
        arcView.addSubview(followButton)
        followButton.layer.cornerRadius = 4
        followButton.backgroundColor = .white
        followButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        followButton.setTitleColor(Constant.Color.color1a1a1a, for: .normal)
        followButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(11)
            make.width.equalTo(80)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        bottomConstraint.update(offset: offsetY >= 0 ? 0 : -offsetY / 2)
        heightConstraint.update(offset: max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top))
    }
}
