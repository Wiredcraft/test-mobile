//
//  UITableViewCell+GUL.swift
//  GithubUsersList
//
//  Created by 裘诚翔 on 2021/3/6.
//

import Foundation
import UIKit


extension UITableViewCell {
    @objc class func reuseIdentifier() -> String {
        return NSStringFromClass(self) as String
    }
}
