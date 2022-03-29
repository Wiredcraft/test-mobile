//
//  UserListCoordinator.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/26.
//

import UIKit
import RxSwift

final class UserListCoordinator: BaseCoordinator {
    
    var router: Routing
    
    private let bag = DisposeBag()
    
    init(router: Routing) {
        self.router = router
    }
    
/// Push Controller into Stack
    override func start() {
        let view = UserListViewController.instantiate(from: "UserList")
        
        router.push(view, isAnimated: true, onNavigationBack: isCompleted)
    }
}

