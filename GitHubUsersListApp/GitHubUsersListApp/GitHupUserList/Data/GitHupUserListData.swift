//
//  GitHupUserListData.swift
//  CJWProject
//
//  Created by Joy Cheng on 2022/3/31.
//

import Alamofire

struct FetchGitHupUserListData {
    static func getListData(searchText: String, pageValue: Int, succeedBlock: @escaping(Any) -> Void) {
        var url = ""
        if searchText.count == 0 {
            url = "\(searchAPI)q=swift&page=\(pageValue)"
        } else  {
            url = "\(searchAPI)q=\(searchText)&page=\(pageValue)"
        }
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let data = GitHupUserListData(json) {
                    succeedBlock(data.items)
                }
            case .failure(let error):
                print(error)
                succeedBlock([])
            }
        }
    }
}



