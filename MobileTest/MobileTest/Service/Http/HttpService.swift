//
//  HttpService.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/26.
//


import Alamofire

protocol HttpService {
    var sessionManager: Session { get }
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest
}
