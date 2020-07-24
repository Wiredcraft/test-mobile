//
//  WCTHomeViewController.swift
//  WiredcraftTest
//
//  Created by Richard on 2020/7/21.
//  Copyright © 2020 RichardSheng. All rights reserved.
//

import UIKit
import RxAlamofire
import RxSwift
import RxCocoa
import MJRefresh

class WCTHomeViewController: UIViewController {

  // MARK: - View Model
  var homeViewModel: WCTHomeViewModel!
  let networkService: WCTNetworkService = WCTNetworkService()

  // MARK: - UI Property
  @IBOutlet weak var contentTableView: UITableView!
  let WCTUserTableViewCellId: String = "WCTUserTableViewCell"

  var searchBar: UISearchBar = UISearchBar()

  var disposeBag: DisposeBag = DisposeBag()
// MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Home Page"

    searchBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
    searchBar.text = "swift"
    contentTableView.tableHeaderView = searchBar
    contentTableView.register(UINib(nibName: "WCTUserTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: WCTUserTableViewCellId)
    contentTableView.mj_header = MJRefreshGifHeader()
    contentTableView.mj_footer = MJRefreshBackGifFooter()

    // MARK: - Initiate View Model and Bind View Model
    homeViewModel = WCTHomeViewModel(searchBarText: searchBar.rx.text.orEmpty.asDriver().throttle(1).filter { $0.count > 0 },
                                     headerRefresh: contentTableView.mj_header!.rx.refreshing.asDriver(),
                                     footerLoad: contentTableView.mj_footer!.rx.refreshing.asDriver(), networkService: networkService)

    homeViewModel.cellModels.bind(to: self.contentTableView.rx.items(cellIdentifier: self.WCTUserTableViewCellId, cellType: WCTUserTableViewCell.self)) { (row, cellModel, cell) in
      cell.configure(with: cellModel)
    }.disposed(by: self.disposeBag)

    contentTableView.rx.itemSelected.subscribe(onNext: { [weak self] (indexPath) in
      guard let self = self else { return }
      self.contentTableView.deselectRow(at: indexPath, animated: true)
      guard let userModel = self.homeViewModel.cellModels.value[indexPath.row].userModel else { return }
      self.navigationController?.pushViewController(WCTUserDetailViewController(userModel: userModel), animated: true)
    }).disposed(by: disposeBag)

    homeViewModel.endHeaderRefresh.drive(onNext: { [weak self] (_) in
      self?.contentTableView.mj_header?.endRefreshing()
    }).disposed(by: disposeBag)

    homeViewModel.endFooterLoad.drive(onNext: { [weak self] (_) in
      self?.contentTableView.mj_footer?.endRefreshing()
    }).disposed(by: disposeBag)
  }
}

// MARK: - UITableViewDelegate
extension WCTHomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let cellModel: WCTUserTableViewCellModel = homeViewModel.cellModels.value[indexPath.row]
    return cellModel.cellHeight
  }
}



