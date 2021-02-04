//
//  UserViewModel.swift
//  Users
//
//  Created by ivanzeng on 2021/2/4.
//  Copyright © 2021 none. All rights reserved.
//

import Foundation
import SafariServices

class UserViewModel: NSObject {

    private var requestIsExcuting = false
    private(set) var dataArr: [GithubUser] = [] {
        didSet {
            self.usersDataDidChange?(self.dataArr)
        }
    }
    private var query = ""
    private var pageIndex = 1

    var usersDataDidChange: (([GithubUser]) -> Void)?
    var requestDidStart: (() -> Void)?
    var requestDidSuccess: (() -> Void)?
    var requestDidFail: ((String) -> Void)?

    func searchTextDidChange(_ searchText: String) {
        guard !searchText.isEmpty else {
            dataArr.removeAll()
            return
        }
        
        pageIndex = 1
        NSObject.cancelPreviousPerformRequests(withTarget: requestData())
        DispatchQueue.mainAfter(time: 0.5) {
            self.query = searchText
            self.requestData()
        }
    }

    func requestData() {
        if requestIsExcuting {
            return
        }
        requestIsExcuting = true
        APIClient.shared.getUsers(query: query, page: pageIndex) { result in
            self.requestIsExcuting = false
            switch result {
            case let .success(response):
                self.requestDidSuccess?()
                guard let users = response.result?.items else {
                    return
                }
                if self.pageIndex == 1 {
                    self.dataArr.removeAll()
                }
                self.dataArr += users
                if self.dataArr.isEmpty {
                    self.requestDidFail?(NetworkError.noData.description)
                }
            case let .error(err):
                self.dataArr.removeAll()
                self.requestDidFail?(err.description)
            }
        }
    }

    /// show the user github mainpage in safari
    /// - Parameter user: user model

    func showUserDetailMainPage(_ user: GithubUser) {
        guard let URL = URL(string: user.htmlURL) else {
            return
        }
        let safarivc: SFSafariViewController
        if #available(iOS 11.0, *) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            safarivc = SFSafariViewController(url: URL, configuration: config)
        } else {
            safarivc = SFSafariViewController(url: URL, entersReaderIfAvailable: true)
        }
        UIViewController.topViewController()?.present(safarivc, animated: true)
    }

    /// relaod the user data from begining
    func refreshData() {
        if !requestIsExcuting {
            pageIndex = 1
            requestData()
        }
    }

    /// load more data
    func loadMoreData() {
        if !requestIsExcuting {
            pageIndex += 1
            requestData()
        }
    }
}
