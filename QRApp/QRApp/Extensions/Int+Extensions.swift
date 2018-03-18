//
//  Int+Extensions.swift
//  QRApp
//
//  Created by Ville Välimaa on 18/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import Foundation
import UIKit

public extension Int {
    
    func asDouble() -> Double {
        return Double(self)
    }
    
    func asCGFloat() -> CGFloat {
        return CGFloat(self)
    }
}
