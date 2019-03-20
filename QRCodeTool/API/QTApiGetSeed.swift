//
//  QTApiGetSeed.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/20.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import UIKit

class QTApiGetSeedResult: QTNetworkApiResult {
    var seed: QTSeed?
    override init(responseData: NSDictionary?) {
        super.init(responseData: responseData)
        
        let seed: QTSeed = QTSeed()
        seed.expireAt = ((responseData!["expires_at"] as? Double)!) / 1000.0
        seed.seed = responseData!["seed"] as? String
        self.seed = seed
    }
}

class QTApiGetSeed: QTNetworkApi {
    func getRandomSeed(_ success: @escaping (QTApiGetSeedResult?) -> Void, _ fail: @escaping (QTNetworkError?) -> Void) -> Void {
        let path = "seed"
        self.get(path, nil, { (responseData) in
            success(QTApiGetSeedResult.init(responseData: responseData))
        }, fail)
    }
}
