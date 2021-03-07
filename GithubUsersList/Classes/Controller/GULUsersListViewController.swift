//
//  GDHomeViewController.swift
//  GithubDemo
//
//  Created by 裘诚翔 on 2021/3/3.
//

import UIKit
import RxCocoa
import SnapKit
import RxSwift

class GULUsersListViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private lazy var tableView : UITableView = {
        let tv = UITableView(frame: CGRect.zero, style: .plain)
        tv.register(GULUsersListCell.self, forCellReuseIdentifier: GULUsersListCell.reuseIdentifier())
        return tv
    }()
    
    private lazy var viewModel : GULUsersListViewModel = {
        return GULUsersListViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { [unowned self] (make) in
            make.left.right.equalTo(self.view)
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
             } else {
                make.bottom.equalTo(self.view.snp.bottom)
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            }
        }
        
        viewModel.fetchUsers().bind(to: tableView.rx.items(cellIdentifier: GULUsersListCell.reuseIdentifier(), cellType: GULUsersListCell.self)){row, post, cell in
            cell.model = post
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(GULUsersListItemModel.self).asDriver().drive { [weak self] (itemModel) in
            guard let url = itemModel.html_url else {
                return
            }
            let detailVC = GULUserDetailViewController(url: url)
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }.disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
}

extension GULUsersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}
