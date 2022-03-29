//
//  HttpRouter.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/26.
//

import Alamofire

protocol HttpRouter {
    
    var baseUrlString: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    func body() throws -> Data?

    func request(userHttpService service: HttpService) throws -> DataRequest
}

extension HttpRouter {
    var parameters: Parameters? { return nil }
    func body() throws -> Data? { return nil }
    var headers: HTTPHeaders? { return nil }
    
    func asUrlRequest() throws -> URLRequest {
        var url = try baseUrlString.asURL()
        url.appendPathComponent(path)
        
        var request = try URLRequest(url: url, method: method, headers: headers)
        request.httpBody = try body()
        
        let params = parameters
                
        return try URLEncoding.default.encode(request,with: params)
    }
    
    func request(userHttpService service: HttpService) throws -> DataRequest {
        return try service.request(asUrlRequest())
    }
}
