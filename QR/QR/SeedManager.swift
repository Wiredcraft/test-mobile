//
//  SeedManager.swift
//  QR
//
//  Created by Samuel Zhang on 7/21/16.
//  Copyright © 2016 Samuel Zhang. All rights reserved.
//

import Foundation

public class SeedManager {
    let seedKey = "seedKey"
    let getSeedUrl = "http://localhost:3000/seed"

    let userDefaults = NSUserDefaults.standardUserDefaults()
    let session = NSURLSession.sharedSession()

    init() {}

    func getDataFromServer(callback: (NSData?) -> Void) {
        let task = session.dataTaskWithURL(NSURL(string: getSeedUrl)!, completionHandler: {
            (data, response, error) -> Void in
            callback(data)
        })
        task.resume()
    }
    
    func getDataFromCache() -> NSData? {
        let data = userDefaults.objectForKey(seedKey)
        return data as? NSData
    }
    
    func cacheData(data: NSData) {
        userDefaults.setObject(data, forKey: seedKey)
    }
    
    public func getSeedAsync(callback: (SeedModel?) -> Void) {
        func runCallbackOnMainThread(model: SeedModel?) {
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                callback(model)
            }
        }
        
        let data = getDataFromCache()
        // if there's a cached model, and it will not expire soon (in 1s), return it. 
        if let model = SeedModel(data: data) where model.expireTimeout() > 1.0 {
            print("getSeedAsync returns cached model \(model)")
            runCallbackOnMainThread(model)
            return
        }
        getDataFromServer { (data) -> Void in
            let model = SeedModel(data: data)
            print("getSeedAsync returns model from server \(model)")
            if let model = model where model.expireTimeout() > 0 {
                self.cacheData(data!)
            }
            runCallbackOnMainThread(model)
        }
    }
}