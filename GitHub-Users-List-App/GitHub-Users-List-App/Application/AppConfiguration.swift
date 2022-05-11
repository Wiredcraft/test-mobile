//
//  AppConfiguration.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/7.
//

import Foundation
final class AppConfiguration {
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "APIBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()

    lazy var accessToken: String? = {
        guard let token = Bundle.main.object(forInfoDictionaryKey: "AccessToken") as? String, let encryptToken = "token:\(token)".data(using: .utf8)?.base64EncodedString() else {
            return nil
        }
        let ans = "Basic \(encryptToken)"
        return ans
    }()
}
