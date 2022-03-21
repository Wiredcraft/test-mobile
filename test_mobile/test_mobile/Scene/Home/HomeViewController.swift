//
//  HomeViewController.swift
//  test_mobile
//
//  Created by Jun Ma on 2022/3/19.
//

import UIKit
import Resolver
import SnapKit
import Reusable
import RxSwift
import RxCocoa
import NSObject_Rx
import RxOptional
import RxDataSources
import Nuke

class HomeViewController: UIViewController {

    @Injected
    var viewModel: HomePageViewModelType
    
    let searchBar = UISearchBar()
    let tableView = UITableView(frame: .zero, style: .plain)
    let refresh = UIRefreshControl()
    
    lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionOfUsers> { [unowned self] source, tableView, indexPath, model in
        let cell: UserTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        Nuke.loadImage(with: model.avatarUrl, into: cell.iconImageView)
        cell.nameLabel.text = model.login
        cell.scoreLabel.text = model.score != nil ? String(model.score!) : ""
        cell.urlLabel.text = model.htmlUrl
        cell.followButton.setTitle(model.followedDescription, for: .normal)
        cell.followButton.rx.tap
            .take(until: cell.rx.prepareForReuse)
            .map { _ in indexPath }
            .bind(to: self.viewModel.input.followTriggered)
            .disposed(by: self.rx.disposeBag)
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSearchBar()
        addTableView()
        
        bindViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        adjustSearchBarStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    func addSearchBar() {
        view.addSubview(searchBar)
        // initial search keyword
        searchBar.text = "swift"
        searchBar.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(view.snp.topMargin)
        }
    }
    
    func adjustSearchBarStyle() {
        // remove background separator
        searchBar.backgroundImage = UIImage()
        // round corder
        searchBar.searchTextField.layer.cornerRadius = 18
        searchBar.searchTextField.layer.masksToBounds = true
        // minimal change alignment of text input
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
        searchBar.searchTextField.leftView = padding
        // pretend to move icon to the right corner
        let image = UIImage(systemName: "magnifyingglass")
        searchBar.searchTextField.rightView = UIImageView(image: image)
        searchBar.searchTextField.rightViewMode = .always
        searchBar.searchTextField.tintColor = .lightGray
    }
    
    func addTableView() {
        // table view style
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.register(cellType: UserTableViewCell.self)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottomMargin)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
        
        // dismiss keyboard when scroll
        tableView.keyboardDismissMode = .onDrag
        
        // add pull to refresh function
        refresh.tintColor = .lightGray
        tableView.refreshControl = refresh
    }
    
    func bindViewModel() {
        // get search text from search bar
        let searchText = searchBar.rx.text.orEmpty
            .share(replay: 1, scope: .whileConnected)
        
        // bind input for refresh
        Observable.merge(
            refresh.rx.controlEvent(.valueChanged)
                .withLatestFrom(searchText),
            searchText.distinctUntilChanged()
        )
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(to: viewModel.input.refresh)
            .disposed(by: rx.disposeBag)
        
        // bind input for load more
        tableView.rx.reachedBottom()
            .filter({ [unowned self] _ in
                self.tableView.contentSize.height > 0
            })
            .withLatestFrom(searchText)
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(to: viewModel.input.loadMore)
            .disposed(by: rx.disposeBag)
        
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        // push to user detail page
        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] indexPath in

            })
            .disposed(by: rx.disposeBag)
        
        // bind output users to table view
        viewModel.output.users
            .do(onNext: { [unowned self] _ in
                self.refresh.endRefreshing()
            })
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        66
    }
}
