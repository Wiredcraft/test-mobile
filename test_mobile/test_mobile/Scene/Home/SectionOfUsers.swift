//
//  SectionOfUsers.swift
//  test_mobile
//
//  Created by Jun Ma on 2022/3/19.
//

import Foundation
import RxDataSources

struct SectionOfUsers {
    var items: [Item]
}

extension SectionOfUsers: SectionModelType {
    typealias Item = User
    
    init(original: SectionOfUsers, items: [User]) {
        self = original
        self.items = items
    }
}
