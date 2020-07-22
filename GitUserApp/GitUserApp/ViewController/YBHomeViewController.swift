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

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
      super.viewDidLoad()
       
      setupUI()
      bindViewModel()
    }

    /// bind viewModel
    func bindViewModel() {
      //搜索序列
      let searchAction = searchBar.rx.text.orEmpty.asDriver()
             .throttle(DispatchTimeInterval.seconds(2))
             .distinctUntilChanged()

      let viewModel = YBHomeViewModel(disposeBag: self.disposeBag,networkService: YBNetWorking())

      let outPut = viewModel.transform(input: (searchAction: searchAction,
      headerRefresh: self.tableView.mj_header!.rx.refreshing.asDriver(),
      footerRefresh: self.tableView.mj_footer!.rx.refreshing.asDriver()))

      outPut.0.drive(self.tableView.mj_header!.rx.endRefreshing)
             .disposed(by: disposeBag)
      outPut.1.drive(self.tableView.mj_footer!.rx.endRefreshing)
         .disposed(by: disposeBag)

      //单元格数据的绑定
      viewModel.tableData.asDriver()
         .drive(tableView.rx.items) { (tableView, row, element) in
             let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! YBHomeTableViewCell
             cell.scoreLabel.text = String(element.score)
             cell.loginLabel.text = element.login
             cell.urlLabel.text = element.htmlUrl
             cell.avatarImageView.kf.setImage(with: URL(string: element.avatarUrl),placeholder: UIImage(named: "placeholder"))
            
             return cell
         }
         .disposed(by: disposeBag)
    }
      
    /// UI Layout
    func setupUI() {
    self.title = "GitUserApp-杨斌"
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
      self.tableView.register(YBHomeTableViewCell.self,
                               forCellReuseIdentifier: "Cell")
      //设置头部刷新控件
      self.tableView.mj_header = MJRefreshNormalHeader()
      //设置尾部刷新控件
      self.tableView.mj_footer = MJRefreshBackNormalFooter()
    }

}
