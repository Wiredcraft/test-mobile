//
//  Routing.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/26.
//

typealias NavigationBackClosure = (() -> ())

protocol Routing {
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigationBack: NavigationBackClosure?)
    func pop(_ isAnimated: Bool)
    func popToRoot(_ isAnimated: Bool)
    func present(_ drawable: Drawable, isAnimated: Bool, onDismiss: NavigationBackClosure?, isPopup: Bool)
}
