//
//  APIManager.swift
//  UserList-LIUCHEN
//
//  Created by LC on 2020/6/23.
//  Copyright © 2020 LC. All rights reserved.
//

import Foundation

typealias SearchResult = (Bool, UserModel) -> Void

protocol APIClient {
    func performSearchUser(withName name: String, currentPage: Int, complete: @escaping SearchResult)
}
/// Can use Alamofire or Moya instead
class APIManager: APIClient {
    private var dataTask: URLSessionTask?  = nil
    private var errorMessage = ""
    let userListBaseURL = "https://api.github.com/search/users"
//    enum ResultEnum {
//        case success(UserModel)
//        case error(Error)
//    }
    /// https://api.github.com/search/users
    /// - Parameters:
    ///   - name: q=
    ///   - complete: Result(Bool) //Also can callback by enum
    func performSearchUser(withName name: String, currentPage: Int = 1, complete: @escaping SearchResult) {
        guard !name.isEmpty else {
            fatalError("NAME CAN NOT BE EMPTY")
        }
        dataTask?.cancel()
        var url: URL
        if currentPage > 1 {
            url = searchUserURL(withName: name, currentPage: currentPage)
        }else {
            url = searchUserURL(withName: name)
        }
      
        let session = URLSession.shared
        dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
            defer {
                self.dataTask = nil
            }
            if let error = error {
                self.errorMessage += "DataTask error: " + error.localizedDescription
            }else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                let userModel = self.mapJson(data: data, model: UserModel.self)
                DispatchQueue.main.async {
                    complete(true, userModel)
                }
            }
        })
        dataTask?.resume()
    }
}

// MARK: - Internal Utility
extension APIManager {
    func mapJson<T>(data: Data, model: T.Type) -> T where T : Decodable {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(model.self, from: data)
        } catch {
          fatalError("JSON Error: \(error)")
        }
    }
}

// MARK: - URL Function
extension APIManager {
    private func searchUserURL(withName login: String, currentPage: Int = 1) -> URL {
        let queryAllowedLogin = login.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let urlStr = "\(userListBaseURL)?q=\(queryAllowedLogin)&page=\(currentPage)"
        return URL(string: urlStr)!
    }
}
