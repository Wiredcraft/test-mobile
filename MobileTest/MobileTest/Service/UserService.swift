//
//  UserService.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/26.
//


import RxSwift
import Alamofire
import Foundation

final class UsersService {
    
    private lazy var httpService: UsersHttpService = UsersHttpService()
    
    private init() {
    }
    
    static let shared: UsersService = UsersService()
}


extension UsersService: UsersAPI {
    /// fetch data
    func fetchUsers(q: String, page: Int) -> Single<UsersResponse> {
        return Single.create { [httpService] single -> Disposable in
            do {
                try UsersHttpRouter.getUsersList(q: q, page: page)
                    .request(userHttpService: httpService)
                    .responseDecodable { (response: DataResponse<UserItems,AFError>)  in
                        switch response.result {
                        case .success(let userItems):
                            single(.success(userItems.items))
                        case .failure:
                            if let code = response.response?.statusCode{
                                let codeError = CustomError.error(message: "error code\(code)")
                                single(.failure(codeError))
                            }
                            let error = CustomError.error(message: "Invalid Users JSON")
                            debugPrint(error.localizedDescription)
                            single(.failure(error))
                        }
                    }
            } catch {
                let failedError = CustomError.error(message: "Users fetch failed")
                debugPrint(failedError.localizedDescription)
                single(.failure(failedError))
            }
            return Disposables.create()
        }
    }
}

extension UsersService {
    static func parseUsers(result: DataResponse<UserItems,AFError>) throws -> UsersResponse {
        guard let data = result.data,
              let usersItems = try? JSONDecoder().decode(UserItems.self, from: data)
        else {
            throw CustomError.error(message: "Invalid Users JSON")
        }
        return usersItems.items
    }

}
