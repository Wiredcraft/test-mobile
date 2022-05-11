//
//  MockEndPoint.swift
//  GitHub-Users-List-AppTests
//
//  Created by 邹奂霖 on 2022/5/6.
//

import Foundation
@testable import GitHub_Users_List_App
struct MockEndpoint<R>: ResponseRequestable {
    typealias Response = R



    var path: String
    var isFullPath: Bool = false
    var method: HTTPMethodType
    var headerParamaters: [String: String] = [:]
    var queryParametersEncodable: Encodable?
    var queryParameters: [String: Any] = [:]
    var bodyParamatersEncodable: Encodable?
    var bodyParamaters: [String: Any] = [:]
    var bodyEncoding: BodyEncoding = .stringEncodingAscii
    public let responseDecoder: ResponseDecoder = JSONResponseDecoder()
    init(path: String, method: HTTPMethodType) {
        self.path = path
        self.method = method
    }
}
