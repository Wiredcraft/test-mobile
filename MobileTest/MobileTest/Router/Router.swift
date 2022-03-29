//
//  Router.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/26.
//

import UIKit

final class Router: NSObject {
    
    private let navigationController: UINavigationController
    private var closures: [String: NavigationBackClosure] = [:]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }
}

extension Router: Routing {
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigationBack: NavigationBackClosure?) {
        guard let viewController = drawable.viewController else { return }
        
        if let closure = onNavigationBack {
            closures.updateValue(closure, forKey: viewController.description)
        }

        navigationController.pushViewController(viewController, animated: isAnimated)
    }
    
    func pop(_ isAnimated: Bool) {
        navigationController.popViewController(animated: isAnimated)
    }
    
    func popToRoot(_ isAnimated: Bool) {
        navigationController.popToRootViewController(animated: isAnimated)
    }
    
    func present(_ drawable: Drawable, isAnimated: Bool, onDismiss: NavigationBackClosure?, isPopup: Bool = false) {
        guard let viewController = drawable.viewController else { return }
        
        if let closure = onDismiss {
            closures.updateValue(closure, forKey: viewController.description)
        }
        
        if isPopup {
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .overCurrentContext
        }
        
        navigationController.present(viewController, animated: isAnimated, completion: nil)
        viewController.presentationController?.delegate = self
    }
    
    func executeClosure(_ viewController: UIViewController) {
        guard let closure = closures.removeValue(forKey: viewController.description) else { return }
        closure()
    }
}

extension Router: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        executeClosure(presentationController.presentedViewController)
    }
}

extension Router: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let previousController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        guard !navigationController.viewControllers.contains(previousController) else { return }
        
        executeClosure(previousController)
    }
}
