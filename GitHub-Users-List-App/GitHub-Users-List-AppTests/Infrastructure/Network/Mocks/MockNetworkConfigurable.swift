//
//  MockNetworkConfigurable.swift
//  GitHub-Users-List-AppTests
//
//  Created by 邹奂霖 on 2022/5/6.
//

import Foundation
@testable import GitHub_Users_List_App
class MockNetworkConfigurable: NetworkConfigurable {
    var baseURL: URL = URL(string: "https://mock.test.com")!
    var headers: [String: String] = [:]
    var queryParameters: [String: String] = [:]
}
