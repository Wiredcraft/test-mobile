//
//  GitHupUserDetailData.swift
//  CJWProject
//
//  Created by Joy Cheng on 2022/3/31.
//

import Alamofire
import SwiftyJSON

struct GitHupUserDetailData {
    static func getDetailData(name: String, succeedBlock: @escaping(Any) -> Void) {
        let url = "\(followDetailAPI)\(name)/repos"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let data = GitHupUserDetailSource(json) {
                    succeedBlock(data)
                }
            case .failure(let error):
                print(error)
                succeedBlock([])
            }
        }
    }
}
