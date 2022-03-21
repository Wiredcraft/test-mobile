//
//  Constant.swift
//  test_mobile
//
//  Created by Jun Ma on 2022/3/20.
//

import Foundation
import UIKit

enum Constant {
    enum Color {
        // #1A1A1A
        static let color1a1a1a = UIColor(named: "color1a1a1a")
        // #6D6D6D
        static let color6d6d6d = UIColor(named: "color6d6d6d")
    }
    
    enum Font {
        // NTR font with default size
        static let ntr = UIFont(name: "NTR", size: 18)
    }
    
    enum UI {
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
    }
}
