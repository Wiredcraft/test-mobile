//
//  WCTUserTableViewCell.swift
//  WiredcraftTest
//
//  Created by Richard on 2020/7/22.
//  Copyright © 2020 RichardSheng. All rights reserved.
//

import UIKit
import Kingfisher

class WCTUserTableViewCell: UITableViewCell {
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var urlLabel: UILabel!
  
  weak var cellModel: WCTUserTableViewCellModel?
  
  func configure(with cellModel: WCTUserTableViewCellModel) {
    
    avatarImageView.kf.setImage(with: URL(string: cellModel.avatarURL ?? ""))
    nameLabel.text = cellModel.name
    scoreLabel.text = cellModel.score
    urlLabel.text = cellModel.url
  }
}
