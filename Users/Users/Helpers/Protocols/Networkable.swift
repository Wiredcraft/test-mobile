//
//  Networkable.swift
//  Users
//
//  Created by ivan on 2021/1/31.
//  Copyright © 2021 none. All rights reserved.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<GithubApi> { get }
}
