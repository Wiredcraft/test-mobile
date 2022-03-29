//
//  UserListViewController.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/26.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh

final class UserListViewController: UIViewController, Storyboardable {
    
    /// view
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet private weak var searchTextField: SearchTextField!
    
    
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    
    /// view model
    private var viewModel: UserListViewModel!
    
    private static let CellId = "UserCell"
    
    private let bag = DisposeBag()
    
    private var searchResults: UsersResponse?
    
    private var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
}

private extension UserListViewController {
    
    func setupUI() {
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: UserListViewController.CellId)
        tableView.addSubview(refreshControl)
        tableView.mj_header = MJRefreshNormalHeader()
        tableView.mj_footer = MJRefreshBackNormalFooter()
        
    }
    
    func setupBindings() {
        let searchAction = searchTextField.textField.rx.text.orEmpty.asDriver()
            .throttle(.milliseconds(500))
            .distinctUntilChanged()
        
        viewModel = UserListViewModel(searchAction: searchAction,
                                      headerRefresh: (tableView.mj_header?.rx.refresh.asDriver())!,
                                      footerRefresh: (tableView.mj_footer?.rx.refresh.asDriver())!,
                                      usersService: UsersService.shared)
        
        viewModel.searchResults.asDriver().drive(tableView.rx.items){ (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
            
            let url = URL(string: element.avator)
            cell.avatorImageView.kf.setImage(with: url,
                                             placeholder: UIImage(named: "avator_male_icon"))
            cell.userNameLabel.text = element.userName
            cell.userScoreLabel.text = "\(element.score)"
            cell.userURLabel.text = element.htmlUrl
            
            
            cell.followButton.setTitle((element.isfollowing == true) ? "已关注" : "关注", for: .normal)
            
            cell.followButton.rx.tap.subscribe { _ in
                element.isfollowing = !element.isfollowing
                if element.isfollowing {
                    cell.followButton.setTitle("已关注", for: .normal)
                }else{
                    cell.followButton.setTitle("关注", for: .normal)
                }
            }.disposed(by: cell.bag)
            
            return cell
        }.disposed(by: bag)
        
        /// data
        viewModel.searchResults.asObservable().subscribe(onNext: { response in
            self.searchResults = response
            self.tableView.mj_footer?.isHidden = response.isEmpty
        }).disposed(by: bag)
        
        /// empty
        let emptyDesc =  """
                    No Data
                    Please input something!
                    """
        viewModel.searchResults.asObservable().map { $0.count == 0 }.distinctUntilChanged()
            .bind(to: tableView.rx.isEmpty(message: emptyDesc)).disposed(by: bag)
        
        /// refresh
        tableView.mj_header?.setRefreshingTarget(self, refreshingAction: #selector(loadNewData))
        
        tableView.mj_footer?.setRefreshingTarget(self, refreshingAction: #selector(loadMoreData))
        
        /// push
        Observable.zip(tableView.rx.itemSelected,
                       tableView.rx.modelSelected(UserModel.self)).bind{ [weak self] (indexpath,item) in
            let view = UserDetailListController.instantiate(from: "UserDetail")
            
            view.selectItem = item
            view.searchResults = self?.searchResults
            view.changeState = { state in
                let cell = self?.tableView.cellForRow(at: indexpath) as! UserCell
                cell.followButton.setTitle((state == true) ? "已关注" : "关注", for: .normal)
            }
            self?.navigationController?.pushViewController(view, animated: true)
        }.disposed(by: bag)
    }
    
    @objc func loadNewData(){
        guard let text = viewModel.currentText else { return }
        UsersService.shared.fetchUsers(q: text, page: 1).asObservable()
            .subscribe (onNext: { response in
                self.viewModel.searchResults.accept(response)
            }).disposed(by: bag)
        tableView.mj_header?.endRefreshing()
    }
    
    @objc func loadMoreData(){
        guard let text = viewModel.currentText,
              let result = self.searchResults else { return }
        page = page + 1
        UsersService.shared.fetchUsers(q: text, page: page).asObservable()
            .subscribe (onNext: { response in
                self.searchResults = result + response
                self.viewModel.searchResults.accept(self.searchResults!)
            }).disposed(by: bag)
        tableView.mj_footer?.endRefreshing()
    }
}


extension UITableView {
    func setNoDataPlaceholder(_ message: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        label.text = message
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        
        self.isScrollEnabled = false
        self.backgroundView = label
        self.separatorStyle = .none
    }
}

extension UITableView {
    func removeNoDataPlaceholder() {
        self.isScrollEnabled = true
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}


extension Reactive where Base: UITableView {
    func isEmpty(message: String) -> Binder<Bool> {
        return Binder(base) { tableView, isEmpty in
            if isEmpty {
                tableView.setNoDataPlaceholder(message)
            } else {
                tableView.removeNoDataPlaceholder()
            }
        }
    }
}
