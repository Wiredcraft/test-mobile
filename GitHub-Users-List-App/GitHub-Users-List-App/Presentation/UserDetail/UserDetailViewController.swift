//
//  UserDetailViewController.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/10.
//

import Foundation
import UIKit
class UserDetailViewController: UITableViewController, UIGestureRecognizerDelegate {
    var viewModel: UserDetailViewModelType!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }

    static func create(with viewModel: UserDetailViewModelType) -> UserDetailViewController {
        let view = UserDetailViewController()
        view.viewModel = viewModel
        return view
    }
}
