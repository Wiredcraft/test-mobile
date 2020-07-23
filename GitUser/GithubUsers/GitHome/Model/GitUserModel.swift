//
//  GitUserModel.swift
//  GithubUsers
//
//  Created by lvzhao on 2020/7/22.
//  Copyright © 2020 吕VV. All rights reserved.
//

import UIKit
import HandyJSON


struct GitUserModel :  HandyJSON{
    var login: String?
    var html_url: String?
    var avatar_url: String?
    var node_id: String?
    var score: Float?

}
