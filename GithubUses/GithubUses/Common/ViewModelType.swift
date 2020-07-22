//
//  ViewModelType.swift
//  GithubUsers
//
//  Created by Apple on 2020/7/21.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class ViewModel {
    let api = MoyaProvider<GitHub>()
}
