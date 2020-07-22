//
//  ViewModel.swift
//  GithubUsers
//
//  Created by Apple on 2020/7/20.
//

import Foundation
import RxSwift

class SearchViewModel {
    var page: Int = 0
    var total: Int = 0
    var items: [GithubUser] = []
    
    func refreshData() {
        
    }
}
