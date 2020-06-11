//
//  WCHomeUserCell.swift
//  Wiredcraft
//
//  Created by codeLocker on 2020/6/11.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit
import Kingfisher

class WCHomeUserCell: UITableViewCell {
    
    /// show user's avatar ->  use field avatar_url
    fileprivate lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.es_hex("#F5F5F5")
        imageView.layer.cornerRadius = 25.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    /// show user's nickname ->  use field login
    fileprivate lazy var nicknameLab: UILabel = {
        let lab = UILabel()
        lab.textColor = WCConstants.colors.text
        lab.font = WCConstants.font.title
        return lab
    }()
    
    /// show user's score ->  use field score
    fileprivate lazy var scoreLab: UILabel = {
        let lab = UILabel()
        lab.textColor = WCConstants.colors.text
        lab.font = WCConstants.font.subtitle
        return lab
    }()
    
    /// show user's score ->  use field html_url
    fileprivate lazy var homepageLinkLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.link
        lab.font = WCConstants.font.subtitle
        return lab
    }()
    
    
    public var nickname: String? {
        willSet {
            self.nicknameLab.text = newValue
        }
    }
    
    public var score: Int? {
        willSet {
            self.scoreLab.text = "\(score ?? 0)"
        }
    }
    
    public var avatar: String? {
        willSet {
            guard let urlStr = newValue,
                    urlStr.count > 0,
                    let url = URL.init(string: urlStr) else {
                        self.avatarImageView.image = nil
                        return
            }
            self.avatarImageView.kf.setImage(with: url)
        }
    }
    
    public var homepage: String? {
        willSet {
            self.homepageLinkLab.text = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.loadUI()
        self.layout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.loadUI()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Load_UI
    private func loadUI() {
        /// close the select effect
        self.selectionStyle = .none
        self.contentView.addSubview(self.avatarImageView)
        self.contentView.addSubview(self.nicknameLab)
        self.contentView.addSubview(self.scoreLab)
        self.contentView.addSubview(self.homepageLinkLab)
    }
    
    private func layout() {
        self.avatarImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(50)
        }
        self.nicknameLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.avatarImageView.snp.right).offset(15)
            make.bottom.equalTo(self.avatarImageView.snp.centerY).offset(-2)
        }
        
        self.scoreLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.nicknameLab)
            make.left.equalTo(self.nicknameLab.snp.right).offset(10)
            make.right.lessThanOrEqualToSuperview().offset(-15)
            /// avoid scopeLab's width is squeezed to 0, so set the width >= 0
            make.width.greaterThanOrEqualTo(1)
        }
        self.homepageLinkLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.nicknameLab)
            make.right.equalToSuperview().inset(15)
            make.top.equalTo(self.avatarImageView.snp.centerY).offset(2)
        }
    }
}
