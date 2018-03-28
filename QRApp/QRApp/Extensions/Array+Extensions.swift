//
//  Array+Extensions.swift
//  QRApp
//
//  Created by Ville Välimaa on 17/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import Foundation

public extension Array {
    
    func addToBeginning(_ element: Element) -> [Element] {
        var copy = self
        copy.insert(element, at:0)
        return copy
    }
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
}
