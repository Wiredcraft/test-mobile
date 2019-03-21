//
//  QTNetworkApi.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/20.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import UIKit

class QTNetworkApiResult: NSObject {
    var responseData: NSDictionary?
    init(responseData: NSDictionary?) {
        self.responseData = responseData
    }
}

class QTNetworkApi: NSObject {
    func get(_ path: String?, _ params: NSDictionary?, _ success: @escaping (NSDictionary?) -> Void, _ fail: @escaping (QTNetworkError?) -> Void) {
        QTNetworkClient.shared().get(path, params, success, fail)
    }
}
