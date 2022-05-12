//
//  UserDetailViewModel.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/11.
//

import Foundation

protocol UserDetailViewModelInputs {
    func viewDidLoad()
    func didClickFollow(with state: User.FollowState)
}

protocol UserDetailViewModelOutputs {
    var repoViewModels: Observable<[UserDetailRepoViewModel]> { get }
}

struct UserDetailViewModelActions {
    let followUser: (User) -> Void
}

protocol UserDetailViewModelType {
    var inputs: UserDetailViewModelInputs { get }
    var outputs: UserDetailViewModelOutputs { get }
    var user: User { get }
}

final class UserDetailViewModel: UserDetailViewModelType, UserDetailViewModelInputs, UserDetailViewModelOutputs {
    var inputs: UserDetailViewModelInputs { return self }
    var outputs: UserDetailViewModelOutputs { return self }
    private let actions: UserDetailViewModelActions?
    private let usecase: UserDetailUseCase
    var user: User
    private var loadRepoTask: Cancellable? { willSet { loadRepoTask?.cancel() }}
    // MARK: - Outputs
    var repoViewModels: Observable<[UserDetailRepoViewModel]> = Observable([])
    // MARK: - Init
    init(user: User, actions: UserDetailViewModelActions? = nil, usecase: UserDetailUseCase) {
        self.user = user
        self.actions = actions
        self.usecase = usecase
    }
    // MARK: - Private
    func loadRepos() {
        loadRepoTask = usecase.excute(requestValue: UserRepoRequestValue(userName: user.login), completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let repos):
                    self.outputs.repoViewModels.value = repos.map { UserDetailRepoViewModel(repo: $0) }
                case .failure(_):
                    print("error")
            }
        })
    }
}
// MARK: - Input
extension UserDetailViewModel {
    func viewDidLoad() {
        loadRepos()
    }

    func didClickFollow(with state: User.FollowState) {
        switch state {
            case .followed:
                user.follow()
            case .normal:
                user.unfollow()
        }
        self.actions?.followUser(user)
    }
}
