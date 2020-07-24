//
//  WCTUserTableViewCellModel.swift
//  WiredcraftTest
//
//  Created by Richard on 2020/7/22.
//  Copyright © 2020 RichardSheng. All rights reserved.
//

import UIKit

typealias CellDidSelectHandler = (_ cellModel: WCTUserTableViewCellModel) -> Void

class WCTUserTableViewCellModel {
  var avatarURL: String?
  var name: String?
  var score: String?
  var url: String?
  
  var userModel: WCTUserModel?
  
  var didSelect: CellDidSelectHandler?
  
  
  var cellHeight: CGFloat = 70
  
  
  convenience init(with userModel: WCTUserModel) {
    self.init()
    avatarURL = userModel.avatar_url
    name = userModel.login
    score = String(userModel.score ?? 0)
    url = userModel.html_url
    
    self.userModel = userModel
  }
}
