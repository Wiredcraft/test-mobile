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
}
