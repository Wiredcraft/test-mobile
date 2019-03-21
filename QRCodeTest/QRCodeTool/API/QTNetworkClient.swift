//
//  QTNetworkClient.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/20.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import UIKit

class QTNetworkClient: NSObject {
    
    let baseURL = "http://148.70.92.103:8080/"
    var session: URLSession?
    
    private static let _instance = QTNetworkClient()
    class func shared() -> QTNetworkClient {
        return _instance
    }
    
    override init() {
        super.init()
        
        self.session = URLSession.shared
    }
    
    func get(_ path: String?, _ params: NSDictionary?, _ success: @escaping (NSDictionary?) -> Void, _ fail: @escaping (QTNetworkError?) -> Void) {
        let urlString = "\(baseURL)" + path!
        let request: URLRequest = URLRequest.init(url: URL.init(string: urlString)!)
        
        let dataTask = self.session?.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {// http error
                    fail(QTNetworkError.init(error?.localizedDescription, (error as! URLError).code.rawValue))
                } else {
                    if let jsonObj: NSDictionary = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary {
                        if jsonObj["code"] as! Int == 200 {//backend operation success
                            success(jsonObj)
                        } else {// backend operation fail
                            fail(QTNetworkError.init("Service Error", jsonObj["code"] as? Int))
                        }
                    }
                }
            }
        })
        dataTask?.resume()
    }
}
