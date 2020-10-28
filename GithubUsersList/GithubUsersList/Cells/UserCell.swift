//
//  UserCell.swift
//  GithubUsersList
//
//  Created by Rusty on 2020/10/26.
//

import UIKit
import SDWebImage

class UserCell: UITableViewCell {
  
  var downloadTask: URLSessionDownloadTask?
  
  lazy var avatarImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    //imageView.image = UIImage(systemName: "stop")
    imageView.tintColor = .systemGray
    return imageView
  }()
  lazy var loginLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 18)
    label.textAlignment = .left
    return label
  }()
  lazy var scoreLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 18)
    label.textAlignment = .left
    return label
  }()
  lazy var urlLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 15)
    label.textAlignment = .left
    label.textColor = .systemGray
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(avatarImageView)
    avatarImageView.snp.makeConstraints { (make) in
      make.leading.equalToSuperview().offset(10)
      make.centerY.equalToSuperview()
      make.width.height.equalTo(60)
    }
    contentView.addSubview(scoreLabel)
    scoreLabel.snp.makeConstraints { (make) in
      make.trailing.lessThanOrEqualToSuperview().offset(-8)
      make.top.equalTo(avatarImageView).offset(8)
      //Make sure login label has it's minimum width (50)
      make.width.lessThanOrEqualTo(UIScreen.main.bounds.width - 10 - 60 - 8 - 50)
    }
    contentView.addSubview(loginLabel)
    loginLabel.snp.makeConstraints { (make) in
      make.leading.equalTo(avatarImageView.snp.trailing).offset(8)
      make.top.equalTo(avatarImageView).offset(8)
      make.trailing.equalTo(scoreLabel.snp.leading).offset(-8)
      
    }
    contentView.addSubview(urlLabel)
    urlLabel.snp.makeConstraints { (make) in
      make.leading.equalTo(avatarImageView.snp.trailing).offset(8)
      make.trailing.equalToSuperview().offset(8)
      make.bottom.equalTo(avatarImageView.snp.bottom).offset(-8)
    }
  }
  
  func configure(for user: User) {
    loginLabel.text = user.login
    scoreLabel.text = formattedScoreString(score: user.score)
    urlLabel.text = user.html_url
    avatarImageView.sd_setImage(with: URL(string: user.avatar_url ?? ""), placeholderImage: UIImage(systemName: "square.fill"))
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    downloadTask?.cancel()
    downloadTask = nil
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
