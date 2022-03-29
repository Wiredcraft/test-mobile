//
//  AppCoordinator.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/26.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    
    private let navigationController: UINavigationController = {
       let navigationController = UINavigationController()
        navigationController.view.backgroundColor = .clear
        
        let navigationBar = navigationController.navigationBar
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        return navigationController
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let router = Router(navigationController: navigationController)
        
        let userListCoordinator = UserListCoordinator(router: router)
        
        self.add(coordinator: userListCoordinator)
        
        userListCoordinator.isCompleted = { [weak self, weak userListCoordinator] in
            guard let coordinator = userListCoordinator else { return }
            self?.remove(coordinator: coordinator)
        }
        
        userListCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
