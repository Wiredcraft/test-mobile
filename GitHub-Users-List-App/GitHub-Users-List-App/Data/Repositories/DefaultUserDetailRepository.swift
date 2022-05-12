//
//  DefaultUserDetailRepository.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/11.
//

import Foundation
final class DefaultUserDetailRepository {
    private let dataTransferService: DataTransferService
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultUserDetailRepository: UserDetailRepository {
    func fetchUserDetailRepos(with userName: String, completion: @escaping (Result<[UserRepo], Error>) -> Void) -> Cancellable? {
        let dto = UserRepoRequestDTO(userName: userName)
        let task = RepositoryTask()
        if !task.isCancelled {
            let endpoint = APIEndpoints.getUserRepos(with: dto)
            task.networkTask = self.dataTransferService.request(with: endpoint) { result in
                switch result {
                    case .success(let response):
                        completion(.success(response.map { $0.toDomain()}))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        }
        return task
    }
}


