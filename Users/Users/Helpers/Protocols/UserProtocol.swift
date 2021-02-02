//
//  UserProtocol.swift
//  Users
//
//  Created by ivan on 2021/1/31.
//  Copyright © 2021 none. All rights reserved.
//

import Foundation

protocol UserDef {
    var id: UInt { get }
    var avatarURL: String { get }
    var htmlURL: String { get }
}
