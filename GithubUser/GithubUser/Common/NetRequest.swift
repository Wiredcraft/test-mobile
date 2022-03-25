//
//  NetWork.swift
//  GithubUser
//
//  Created by zhaitong on 2022/3/22.
//

import Alamofire
import Foundation
import HandyJSON

enum NetResponse<T> {
    case Success(T?);
    case Error(Int, String);
}

typealias Callback<T> = (NetResponse<T>)->Void

class NetRequest{
    
    private static var _baseUrl: String = "https://api.github.com"
    
    static func config(baseUrl: String, timeout: TimeInterval = 30){
        _baseUrl = baseUrl
        AF.sessionConfiguration.timeoutIntervalForRequest = timeout
        AF.sessionConfiguration.timeoutIntervalForResource = timeout
    }
    
    
    static func GET<T:HandyJSON>(path: String, params: Parameters?, callback:@escaping Callback<T>){
        
        let request = AF.request("\(_baseUrl)\(path)", method: .get, parameters: params, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil)
        request.responseString { result in
            switch(result.result){
            case .success(let result):
                let data = T.deserialize(from: result, designatedPath: nil);
                callback(.Success(data))
                print("data:\(String(describing: data))")
                break
            case .failure(let err):
                callback(.Error(err.responseCode ?? -1, err.localizedDescription))
                break
            }
        }
    }
    
    static func getArray<T: HandyJSON>(path: String, params: Parameters?, callback:@escaping Callback<[T]>){
        
        let request = AF.request("\(_baseUrl)\(path)", method: .get, parameters: params, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil)
        request.responseString { result in
            switch(result.result){
            case .success(let result):
                let array = [T].deserialize(from: result, designatedPath: nil) as? [T]
                callback(.Success(array))
                break
            case .failure(let err):
                callback(.Error(err.responseCode ?? -1, err.localizedDescription))
                break
            }
        }
    }
}

