//
//  UserHttpService.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/26.
//

import Alamofire

final class UsersHttpService: HttpService {
    
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
}
