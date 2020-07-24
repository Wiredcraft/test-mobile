//
//  FetchUserResponseData.swift
//  WiredcraftTest
//
//  Created by Richard on 2020/7/22.
//  Copyright © 2020 RichardSheng. All rights reserved.
//

import Foundation
import ObjectMapper

struct FetchUserResponseData: Mappable {
  var total_count: Int = 0
  var incomplete_results: Bool = false
  var items: [WCTUserModel]?
  
  init() {
    
  }
  
  init?(map: Map) {
    
  }
  
  mutating func mapping(map: Map) {
    total_count <- map["total_count"]
    incomplete_results <- map["incomplete_results"]
    items <- map["items"]
  }
}
