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

    // the request is excuting
    private(set) var requestIsExcuting = false
    // the request fail messgae, not nil just when fail
    private(set) var errMsg: String?
    // the request data result
    private(set) var dataArr: [GithubUser] = [] {
        didSet {
            self.usersDataDidChange?(self.dataArr)
        }
    }
    private var query = ""
    private var pageIndex = 1

    var netAavilable: Bool {
        return APIClient.shared.netAavilable
    }

    var usersDataDidChange: (([GithubUser]) -> Void)?
    var requestDidStart: (() -> Void)?
    var requestDidSuccess: (() -> Void)?
    var requestDidFail: ((String) -> Void)?

    ///  search users
    /// - Parameters:
    ///   - searchText: keyword
    ///   - pageIndex:  page index
    func searchTextDidChange(_ searchText: String, pageIndex: Int = 1) {
        guard !searchText.isEmpty else {
            dataArr.removeAll()
            return
        }

        self.pageIndex = pageIndex
        query = searchText
        NSObject.cancelPreviousPerformRequests(withTarget: requestData())
        perform(#selector(requestData), with: nil, afterDelay: 0.3)
    }

    @objc
    func requestData() {
        if requestIsExcuting {
            return
        }
        requestIsExcuting = true
        requestDidStart?()
        APIClient.shared.getUsers(query: query, page: pageIndex) { result in
            self.requestIsExcuting = false
            switch result {
            case let .success(response):
                guard let users = response.result?.items else {
                    return
                }
                if self.pageIndex == 1 {
                    self.dataArr.removeAll()
                }
                self.dataArr += users
                self.errMsg = nil
                self.requestDidSuccess?()
            case let .error(err):
                self.errMsg = err.description
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
