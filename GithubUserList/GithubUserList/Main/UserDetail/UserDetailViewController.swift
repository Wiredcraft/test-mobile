//
//  UserDetailViewController.swift
//  GithubUserList
//
//  Created by zhaotianyang on 2022/3/31.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh

final class UserDetailViewController: UIViewController {
    private let bag = DisposeBag()
    private let vm: UserDetailViewModel

    private let headerView: UserDetailHeader
    private let table = UITableView(frame: CGRect.zero)
    
    init(user: UserItemData) {
        vm = UserDetailViewModel(user: user)
        headerView = UserDetailHeader(user: user)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        bindData()
    }

    private func initUI() {
        view.backgroundColor = Theme.Color.white
        
        view.addSubview(headerView)
        headerView.followAction = vm.followAction(_:)
        
        view.addSubview(table)
        table.tableFooterView = UIView()
        table.register(UserItemCell.self, forCellReuseIdentifier: UserItemCell.reuseId)
        table.separatorStyle = .none
        table.estimatedRowHeight = 83
        table.contentInsetAdjustmentBehavior = .never
        table.contentInset = UIEdgeInsets(top: 290, left: 0, bottom: 0, right: 0)
        table.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.width.equalTo(Const.Device.ScreenW)
            make.top.equalTo(0)
            make.bottom.equalTo(-Const.Device.BottomSafeH)
        }
        
        view.bringSubviewToFront(headerView)
    }

    private func bindData() {
        vm.userList
            .bind(to: table.rx.items) {(tableView, row, element) in
            let cell = UserItemCell.creatCell(tableView: tableView)
            cell.dataModel = element
            return cell
        }
        .disposed(by: bag)
        
//        table.rx.contentOffset.subscribe(onNext: {[weak self] ofset in
//            guard let this = self else {return}
//            let displacement = ofset.y+this.table.contentInset.top
//            if displacement > 0 && displacement < 30 {
//                self?.headerView.updateHeader(ofset.y+this.table.contentInset.top)
//            }
//        }).disposed(by: bag)
    }
}

