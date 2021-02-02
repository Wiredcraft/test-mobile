//
//  DispatchQueue+extension.swift
//  gateio_app
//
//  Created by IvanZeng on 2019/6/13.
//  Copyright © 2019 Gate. All rights reserved.
//

import Foundation

extension DispatchQueue {

    private static var _onceTracker = [String]()

    static func mainAsync(_ block: @escaping (() -> Void)) {
        DispatchQueue.main.async {
            block()
        }
    }

    static func globalAsync(_ block: @escaping (() -> Void)) {
        DispatchQueue.global().async {
            block()
        }
    }

    static func backgroundAsync(_ block: @escaping (() -> Void)) {
        DispatchQueue(label: "background").async {
            block()
        }
    }

    static func once(token: String, block: @escaping (() -> Void)) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }

        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }

    static func mainAfter(time: TimeInterval, block: @escaping (() -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            block()
        }
    }
}
