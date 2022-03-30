//
//  UserListViewController.swift
//  GithubUserList
//
//  Created by zhaotianyang on 2022/3/26.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh

final class UserListViewController: UIViewController {
    private let bag = DisposeBag()
    private let vm = UserListViewModel()

    private let searchBar = SearchBar()
    private let table = UITableView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        bindData()
    }

    private func initUI() {
        view.backgroundColor = Theme.Color.white
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.top.equalTo(Const.Device.StatusBarH+16)
            make.height.equalTo(34)
        }
        
        view.addSubview(table)
        table.tableFooterView = UIView()
        table.register(UserItemCell.self, forCellReuseIdentifier: UserItemCell.reuseId)
        table.separatorStyle = .none
        table.estimatedRowHeight = 80
        table.mj_footer = MJRefreshAutoFooter(refreshingBlock: vm.loadNextPage)
        table.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.width.equalTo(Const.Device.ScreenW)
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.bottom.equalTo(-Const.Device.BottomSafeH)
        }
    }

    private func bindData() {
        vm.userList
            .bind(to: table.rx.items) {[weak self] (tableView, row, element) in
            let cell = UserItemCell.creatCell(tableView: tableView)
            cell.dataModel = element
            cell.followAction = self?.vm.followAction(_:)
            return cell
        }
        .disposed(by: bag)
        
        table.rx.modelSelected(UserPage.User.self).subscribe(onNext: {[weak self] item in
            self?.navigationController?.pushViewController(UserDetailViewController(user: item), animated: true)
        }).disposed(by: bag)
        
        vm.endRefresh.subscribe(onNext: { [weak self] _ in
            self?.table.mj_footer?.endRefreshing()
        }).disposed(by: bag)
        
        searchBar.field
            .rx
            .text
            .skip(1)
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: vm.search(_:))
            .disposed(by: bag)
    }
    
}
