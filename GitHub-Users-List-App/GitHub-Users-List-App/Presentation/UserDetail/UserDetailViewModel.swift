//
//  UserDetailViewModel.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/11.
//

import Foundation

protocol UserDetailViewModelInputs {
    func viewDidLoad()
}

protocol UserDetailViewModelOutputs {

}

struct UserDetailViewModelActions {
    let followUser: (User) -> Void
}

protocol UserDetailViewModelType {
    var inputs: UserDetailViewModelInputs { get }
    var outputs: UserDetailViewModelOutputs { get }
}

final class UserDetailViewModel: UserDetailViewModelType, UserDetailViewModelInputs, UserDetailViewModelOutputs {
    var inputs: UserDetailViewModelInputs { return self }
    var outputs: UserDetailViewModelOutputs { return self }
    private let actions: UserDetailViewModelActions
    private let usecase: UserDetailUseCase
    init(with actions: UserDetailViewModelActions, usecase: UserDetailUseCase) {
        self.actions = actions
        self.usecase = usecase
    }
}

extension UserDetailViewModel {
    func viewDidLoad() {

    }
}
