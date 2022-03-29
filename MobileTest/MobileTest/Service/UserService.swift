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
                    .responseJSON { (result) in
                        do {
                            let users = try UsersService.parseUsers(result: result)
                            single(.success(users))
                        } catch {
                            single(.failure(error))
                        }
                    }
            } catch {
                single(.failure(CustomError.error(message: "Users fetch failed")))
            }
            
            
            return Disposables.create()
        }
    }
    
    
}

extension UsersService {
    
    static func parseUsers(result: AFDataResponse<Any>) throws -> UsersResponse {
        guard let data = result.data,
              let usersItems = try? JSONDecoder().decode(UserItems.self, from: data)
        else {
            throw CustomError.error(message: "Invalid Users JSON")
        }
        return usersItems.items
    }

}
