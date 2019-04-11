//
//  SearchResultViewController.swift
//  GitHubUsers
//
//  Created by lusheng tan on 2019/4/10.
//  Copyright © 2019 lusheng tan. All rights reserved.
//

import UIKit
import Moya
import Result
import RxSwift
import RxCocoa
import NSObject_Rx
import Kingfisher
import MJRefresh
import SnapKit

//tab
let navigationHeight = 64

class SearchUsersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel = SearchUsersViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersTableViewCell")
        if #available(iOS 11,*) {
            
        } else {
            tableView.snp.updateConstraints { maker in
                maker.top.equalToSuperview().offset(navigationHeight)
            }
        }

        
        // bind viewModel and view
        viewModel.users.bind(to: tableView.rx.items) { (tableView, row, user) in
            if let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell") as? UsersTableViewCell {
                cell.lblName.text = user.login
                cell.lblDetailURL.text = user.html_url
                cell.imgvwAvatar.kf.setImage(with: URL(string: user.avatar_url))
                return cell
            } else {
                return UITableViewCell()
            }
            }.disposed(by: rx.disposeBag)
    }
}
