//
//  SectionOfRepo.swift
//  test_mobile
//
//  Created by Jun Ma on 2022/3/19.
//

import Foundation
import RxDataSources

struct SectionOfRepo {
    var items: [Item]
}

extension SectionOfRepo: SectionModelType {
    typealias Item = Repository
    
    init(original: SectionOfRepo, items: [Repository]) {
        self = original
        self.items = items
    }
}
