//
//  SearchSection.swift
//  GithubClient
//
//  Created by Apple on 2020/7/21.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

import Foundation
import RxDataSources

enum UserSection {
    case users(items: [UserSectionItem])
}

enum UserSectionItem {
    case user(cellViewModel: UserCellViewModel)
}

extension UserSection: SectionModelType {
    typealias Item = UserSectionItem
    
    var items: [UserSectionItem] {
        switch self {
        case .users(items: let items):
            return items
        }
    }
    
    init(original: UserSection, items: [UserSectionItem]) {
        self = .users(items: items)
    }
}
