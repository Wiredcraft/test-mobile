//
//  File.swift
//  GitHub-Users-List-AppTests
//
//  Created by 邹奂霖 on 2022/5/6.
//

import Foundation
@testable import GitHub_Users_List_App
struct MockNetworkSessionManager: NetworkSessionManager {
    let response: HTTPURLResponse?
    let data: Data?
    let error: Error?

    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) -> NetworkCancellable {
        completion(data, response, error)
        return URLSessionDataTask()
    }
}
