//
//  WCHomeNetworkService.swift
//  Wiredcraft
//
//  Created by codeLocker on 2020/6/11.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya_ObjectMapper

/*
 * the network service for home module
 */
class WCHomeNetworkService: NSObject {
    
    /// fetch the users list
    /// - Parameters:
    ///   - query: query keyworad
    ///   - page: page number(start from 1)
    /// - Returns: WCUserListModel's Observable to subscribe outside
    static func usersList(query: String, page: Int) -> Observable<WCUserListModel> {
        return AMHomeProvider
            .rx
            .request(.usersList(query: query, page: page))
            .mapObject(WCUserListModel.self)
            .asObservable()
    }
}
