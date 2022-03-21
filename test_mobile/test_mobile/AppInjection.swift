//
//  AppInjection.swift
//  test_mobile
//
//  Created by Jun Ma on 2022/3/21.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    static public func registerAllServices() {
        registerHomePageViewModel()
    }
}
