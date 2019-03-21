//
//  QTNetworkError.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/20.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import UIKit

class QTNetworkError: NSObject {
    var message: String?
    var code: Int?
    
    init(_ message: String?, _ code: Int?) {
        super.init()
        
        self.message = message
        self.code = code
    }
}
