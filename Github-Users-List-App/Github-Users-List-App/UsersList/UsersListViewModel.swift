//
//  UsersListViewModel.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/5.
//

import Foundation
import Combine
protocol UsersListViewModelInputs {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
}

protocol UsersListViewModelOutputs {
    var usersListSubject: PassthroughSubject<[Int], Never> { get }
    var emptySubject: AnyPublisher<Bool, Never> { get }
}

struct UsersListViewModelActions {
    let showUserDetail: (User) -> Void
}

protocol UsersListViewModelType {
    var inputs: UsersListViewModelInputs { get }
    var outputs: UsersListViewModelOutputs { get }
}

final class UsersListViewModel: UsersListViewModelType, UsersListViewModelInputs, UsersListViewModelOutputs {
    var inputs: UsersListViewModelInputs { return self }
    var outputs: UsersListViewModelOutputs { return self }
    private let actions: UsersListViewModelActions
    private let usecase: UsersListUseCase
    init(with actions: UsersListViewModelActions, usecase: UsersListUseCase) {
        self.actions = actions
        self.usecase = usecase
        let test = usersListSubject.map { $0.isEmpty }
        emptySubject = test.eraseToAnyPublisher()
        
    }

//    MARK: - Outputs
    var usersListSubject = PassthroughSubject<[Int], Never>()
    var emptySubject: AnyPublisher<Bool, Never>
//MARK: - Inputs
    fileprivate let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    func viewDidLoad() {

    }

    func didSelectItem(at indexPath: IndexPath) {

    }
}
