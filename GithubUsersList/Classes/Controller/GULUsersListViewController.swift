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
import MJRefresh

class GULUsersListViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private lazy var tableView : UITableView = {
        let tv = UITableView(frame: CGRect.zero, style: .plain)
        tv.register(GULUsersListCell.self, forCellReuseIdentifier: GULUsersListCell.reuseIdentifier())
        return tv
    }()
    
    private lazy var searchBar : UISearchBar = {
        let sb = UISearchBar()
        return sb
    }()
    
    private lazy var viewModel : GULUsersListViewModel = {
        return GULUsersListViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindUI()
        bindViewModel()
        viewModel.output?.network.onNext(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    private func setup() {
        navigationController?.navigationBar.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(18.0)
            make.bottom.equalToSuperview().offset(-2.0)
            make.right.equalToSuperview().offset(-18.0)
            make.height.equalTo(40.0)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
             } else {
                make.bottom.equalTo(self.view.snp.bottom)
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            }
        }
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.viewModel.output?.network.onNext(true)
        })
        
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            self?.viewModel.output?.network.onNext(false)
        })
    }
    
    private func bindUI() {
        searchBar.rx.text.orEmpty
            .changed
            .subscribe(onNext: { (inputStr) in
                print(inputStr)
            }).disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.rx.modelSelected(GULUserItemViewModel.self).asDriver().drive { [weak self] (cellViewModel) in
            guard let url = cellViewModel.htmlUrl.value else {
                return
            }
            let detailVC = GULUserDetailViewController(url: url)
            self?.present(detailVC, animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        let input = GULUsersListViewModel.GULUsersListInput()
        viewModel.transform(input: input)
        
        viewModel.output?.usersItems.bind(to: tableView.rx.items(cellIdentifier: GULUsersListCell.reuseIdentifier(), cellType: GULUsersListCell.self)){row, post, cell in
            cell.bind(viewModel: post)
        }.disposed(by: disposeBag)
        
        viewModel.output?.refreshState.subscribe(onNext: { [weak self] (state) in
            switch state {
            case .endFooterRefresh:
                self?.tableView.mj_footer?.endRefreshing()
            case .endHeaderRefresh:
                self?.tableView.mj_header?.endRefreshing()
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
    
}

extension GULUsersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}
