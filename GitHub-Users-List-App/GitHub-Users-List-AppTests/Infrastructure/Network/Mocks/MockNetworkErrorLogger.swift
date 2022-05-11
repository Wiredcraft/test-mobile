//
//  MockNetworkErrorLogger.swift
//  GitHub-Users-List-AppTests
//
//  Created by 邹奂霖 on 2022/5/6.
//

import Foundation
@testable import GitHub_Users_List_App
class NetworkErrorLoggerMock: NetworkErrorLogger {
    var loggedErrors: [Error] = []
    func log(request: URLRequest) { }
    func log(responseData data: Data?, response: URLResponse?) { }
    func log(error: Error) { loggedErrors.append(error) }
}
