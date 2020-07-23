//
//  YBHomeViewController.swift
//  GitUserApp
//
//  Created by Rock on 7/22/20.
//  Copyright © 2020 Rock. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import MJRefresh

class YBHomeViewController: UIViewController {
    
    // MARK: - Properties

    lazy var tableView: UITableView = {
      let tableView = UITableView()
      tableView.tableFooterView = UIView()
      tableView.estimatedRowHeight = 50
      tableView.rowHeight = UITableView.automaticDimension
      return tableView
    }()
    lazy var searchBar: UISearchBar = {
      let searchBar = UISearchBar()
      return searchBar
    }()
    let kYBHomeTableViewCellID = "YBHomeTableViewCell"
    let disposeBag = DisposeBag()
    var viewModel: YBHomeViewModel?
    let isHeaderLoading = BehaviorRelay(value: false)
    let isFooterLoading = BehaviorRelay(value: false)
    
    // MARK: - Life cycle

    override func viewDidLoad() {
      super.viewDidLoad()
       
      setupUI()
      bindViewModel()

    }
    
    // MARK: - bind viewModel
    
    func bindViewModel() {
        // search sequence
        let searchAction = searchBar.rx.text.orEmpty.asObservable()
 
        isHeaderLoading.bind(to: tableView.mj_header!.rx.loding).disposed(by: disposeBag)

        isFooterLoading.bind(to: tableView.mj_footer!.rx.loding).disposed(by: disposeBag)
        
        viewModel = YBHomeViewModel(disposeBag: self.disposeBag)
        
        viewModel?.bindAction(input: (searchAction: searchAction,
                                                        headerRefresh: self.tableView.mj_header!.rx.refreshing.asObservable(),
                                                        footerRefresh: self.tableView.mj_footer!.rx.refreshing.asObservable()))
        // bind output to tableview.mj_header and mj_footer
        viewModel?.headerLoading.asObservable().bind(to: isHeaderLoading).disposed(by: disposeBag)
        viewModel?.footerLoading.asObservable().bind(to: isFooterLoading).disposed(by: disposeBag)

        // bind tableData to tableView
        viewModel?.tableData.asDriver()
         .drive(tableView.rx.items) { [weak self] (tableView, row, element) in

            let cell = tableView.dequeueReusableCell(withIdentifier: self!.kYBHomeTableViewCellID) as! YBHomeTableViewCell
             cell.scoreLabel.text = String(element.score)
             cell.loginLabel.text = element.login
             cell.urlLabel.text = element.htmlUrl
             cell.avatarImageView.kf.setImage(with: URL(string: element.avatarUrl),placeholder: UIImage(named: "placeholder"))
            
             return cell
         }
         .disposed(by: disposeBag)
        
        // bind tableView select event
        tableView.rx
        .modelSelected(GitHubUser.self)
        .subscribe(onNext:  { [weak self] value in
            let webViewVC = YBWebViewController()
            webViewVC.load(url: URL(string: value.htmlUrl))
            self!.navigationController?.pushViewController(webViewVC, animated: true)
        })
        .disposed(by: disposeBag)
    }
      
    // MARK: - layout UI
    
    func setupUI() {
        self.title = "GitUserApp"
        view.addSubview(searchBar)
        view.addSubview(tableView)

        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(Tool.kNavigationBarHeight)
            make.left.right.equalTo(view)
            make.height.equalTo(60)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp_bottomMargin)
            make.left.right.equalTo(view)
            make.bottom.equalToSuperview().offset(-Tool.kBottomSafeHeight)
        }

        //创建一个重用的单元格
        tableView.register(YBHomeTableViewCell.self,
                               forCellReuseIdentifier: kYBHomeTableViewCellID)
        //设置头部刷新控件
        tableView.mj_header = MJRefreshNormalHeader()
        //设置尾部刷新控件
        tableView.mj_footer = MJRefreshBackNormalFooter()
        
        tableView.rx.willBeginDragging.subscribe { [weak self] _ in
            guard let self = self else { return }
            self.searchBar.resignFirstResponder()
        }.disposed(by: disposeBag)
        
    }

}
