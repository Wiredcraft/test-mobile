//
//  DefaultUsersRepository.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/10.
//

import Foundation
final class DefaultUsersRepository {
    private let dataTransferService: DataTransferService
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}
extension DefaultUsersRepository: UsersRepository {
    func fectchUsersList(completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable {
//        let requestDTO = UsersRequestDTO(q: query.q, page: query.page)
        let task = RepositoryTask()
        let endpoint = APIEndpoints.getUsers()
        task.networkTask = self.dataTransferService.request(with: endpoint) { result in
            switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
        return task
    }
}
