//
//  ViewModelType.swift
//  GithubClient
//
//  Created by Apple on 2020/7/21.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

import Foundation

/**
 This protocol define standard the input stream and output stream of ViewModel
 */
protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    /// With the input,  generate the output properly
    func transform(_ input: Input) -> Output
}
