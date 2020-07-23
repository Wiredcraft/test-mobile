//
//  LZNetAPIManager.swift
//  SMHCommerce
//
//  Created by lvzhao on 2020/6/30.
//  Copyright © 2020 lvzhao. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON


//初始化请求 provider

let APPProvider = MoyaProvider<APPApi>()


/**
 定义请求的endpodints (供provider使用)
 */
//请求分类
public enum APPApi{
    
    case userList(Int)                     //用户列表//https : //api.github.com/search/users?q=swift&page=1
    case search(String,Int)                //搜索

 
    
}

//请求配置
extension APPApi : TargetType{
    
    //服务地址
    public var baseURL: URL {
        
        switch self {
        case .userList(_):
            return URL(string: "https://api.github.com/")!
        default:
            return URL(string: "https://api.github.com/")!
        }
    }
    
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .userList:
            return "users"
        case .search:
            return "search/users"
        }
    }
    
    //请求类型
    public var method: Moya.Method {
        switch self {
        case .userList(_),
            .search(_,_):
            return .get
        default:
            return .post
        }
        
    }
    
    //请求任事件, 带上参数
    public var task: Task {
        
        var params: [String : Any] = [:]

        switch self {
        case .userList(let page):
            params["page"] = page
            
        case .search(let search, let page):
            params["q"] = search
            params["page"] = page
        
        default: break
            
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)

        
    }
    
    //是否执行Alamofire 验证
    public var validate: Bool
    {
        return false
    }
    
    
    ///请求头
    public var headers: [String : String]? {
        return nil
    }
    
    //这个做单元测试模拟数据使用, 只会在单元测试的文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
     }
}




struct APINetWork {
    
    static func request (
          _ target :APPApi,
          success successCallback: @escaping(JSON)->Void,
          error errorCallback: @escaping(Int)->Void,
          failure failureCallback: @escaping(MoyaError)->Void
      ) {
          
          APPProvider.request(target) { result in
              switch result{
              case let .success(response):
                  do {
                      //如果数据返回成功则直接将结果转为json
                      try response.filterSuccessfulStatusCodes()
                      let json =  try JSON(response.mapJSON())
                      print(json)
                      successCallback(json)
                  } catch let error {
                      //如果数据获取失败，则返回错误状态码
                      errorCallback((error as! MoyaError).response!.statusCode)
                      
                  }
              case let .failure(error):
              
                  failureCallback(error)
              }
              
          }
          
      }
    
    
}
