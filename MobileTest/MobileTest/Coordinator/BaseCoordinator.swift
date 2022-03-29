//
//  BaseCoordinator.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/26.
//

class BaseCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var isCompleted: (() -> ())?
    
    func start() {
        fatalError("Children should implement 'start'")
    }
}
