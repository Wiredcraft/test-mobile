//
//  MainViewController.swift
//  QRApp
//
//  Created by Ville Välimaa on 17/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import UIKit

/// Main ViewController of the application.
/// Provides small menu and welcoming text.
///
class MainViewController: QRBaseViewController {
    
    // Handles ActionButton displaying and menu-like functionality
    //
    private var buttonActionView: ActionButtonView?
    
    private let welcomeLabel = with(UILabel()) {
        $0.text = "Welcome to the QR scanner application!"
        $0.textAlignment = .center
    }
    
    private let viewModel: MainViewModel
    
    override init(backend: Backend) {
        self.viewModel = MainViewModel(backend: backend)
        super.init(backend: backend)
        self.buttonActionView = ActionButtonView(superview: view, delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
        
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.center)
            make.top.equalTo(view.snp.top).offset(100)
            make.left.right.equalTo(view)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// MARK: ActionButtonViewDelegate
///
extension MainViewController: ActionButtonViewDelegate {
    
    func numberOfButtonsInButtonActionView(_ buttonActionView: ActionButtonView) -> Int {
        return viewModel.menuConfigurator.count
    }
    
    func actionButtonView(_ buttonActionView: ActionButtonView, didSelectButtonAtIndex index: Int) {
        navigationController?.pushViewController(
            viewModel.menuConfigurator[index].getTargetVC(backend),
            animated: true)
    }
    
    func actionButtonView(_ buttonActionView: ActionButtonView, titleForButtonAtIndex index: Int) -> String? {
        return viewModel.menuConfigurator[index].title
    }
    
    func actionButtonView(_ buttonActionView: ActionButtonView, imageForButtonAtIndex index: Int) -> UIImage? {
        return viewModel.menuConfigurator[index].image
    }
}
