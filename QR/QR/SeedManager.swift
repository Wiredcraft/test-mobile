//
//  SeedManager.swift
//  QR
//
//  Created by Samuel Zhang on 7/21/16.
//  Copyright © 2016 Samuel Zhang. All rights reserved.
//

import Foundation
import Alamofire

public class SeedManager {
    let seedKey = "seedKey"
    static let apiUrl = "http://localhost:3000"
//    static let apiUrl = "http://10.126.52.103:3000"
    let getSeedUrl = "\(apiUrl)/seed"
    let validateSeedUrl = "\(apiUrl)/validate"

    let userDefaults = NSUserDefaults.standardUserDefaults()
    let session = NSURLSession.sharedSession()

    init() {}

    func getModelFromServer(callback: (SeedModel?) -> Void) {
        let task = session.dataTaskWithURL(NSURL(string: getSeedUrl)!, completionHandler: {
            (data, response, error) -> Void in
            callback(SeedModel(data:data))
        })
        task.resume()
    }

    func getModelFromCache() -> SeedModel? {
        let data = userDefaults.objectForKey(seedKey) as? NSData
        return SeedModel(data:data)
    }

    func cacheModel(model: SeedModel) {
        userDefaults.setObject(model.rawData, forKey: seedKey)
    }

    public func getSeedAsync(callback: (SeedModel?) -> Void) {
        func runCallbackOnMainThread(model: SeedModel?) {
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                callback(model)
            }
        }

        // if there's a cached model, and it will not expire soon (in 1s), return it.
        if let model = getModelFromCache() where model.expireTimeout() > 1.0 {
            print("getSeedAsync returns cached model \(model)")
            runCallbackOnMainThread(model)
            return
        }
        getModelFromServer { (model) -> Void in
            print("getSeedAsync returns model from server \(model)")
            if let model = model where model.expireTimeout() > 0 {
                self.cacheModel(model)
            }
            runCallbackOnMainThread(model)
        }
    }

    public func validateSeed(seed:NSString, callback:(Bool?) -> Void) {
        Alamofire.request(.POST, validateSeedUrl, parameters:["seed":seed], encoding: .JSON)
                .responseJSON { (response) -> Void in
                    callback(response.result.value?["result"] as? Bool)
        }
    }
}
