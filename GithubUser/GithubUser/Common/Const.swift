//
//  Const.swift
//  GithubUser
//
//  Created by zhaitong on 2022/3/22.
//

import Foundation
import UIKit

private let baseSize = 375.0

private let screenWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)

func fitScale(size: CGFloat) -> CGFloat {
    return (CGFloat(screenWidth)/CGFloat(baseSize)) * size
}
