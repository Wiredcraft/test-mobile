//
//  UserDetailViewController.swift
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

class UserDetailViewController: UIViewController {
    
    let index: IndexPath
    lazy var detailViewModel: UserDetailViewModelType = Resolver.resolve(args: index)
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let headerView = UserHeaderView(frame: CGRect(x: 0, y: 0, width: Constant.UI.screenWidth, height: 230))

    lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionOfRepo> { [unowned self] source, tableView, indexPath, model in
        let cell: UserTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.followButton.isHidden = true
        Nuke.loadImage(with: model.owner.avatarUrl, into: cell.iconImageView)
        cell.nameLabel.text = model.name
        cell.scoreLabel.text = String(model.starCount)
        cell.urlLabel.text = model.htmlUrl
        
        return cell
    }
    
    init(index: IndexPath) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        customizeNavigationBar()

        addTableView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    func customizeNavigationBar() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .top, barMetrics: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .lightGray
    }
    
    func addTableView() {
        tableView.tableHeaderView = headerView
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.contentInset = UIEdgeInsets(top: -80, left: 0, bottom: 0, right: 0)
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        tableView.register(cellType: UserTableViewCell.self)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottomMargin)
        }
    }
    
    func bindViewModel() {
        // fetch repos on view did appear
        rx.viewDidAppear
            .map { _ in }
            .bind(to: detailViewModel.input.fetchRepos)
            .disposed(by: rx.disposeBag)
        
        // follow button triggered
        headerView.followButton.rx.tap
            .bind(to: detailViewModel.input.followTriggerd)
            .disposed(by: rx.disposeBag)
        
        // bind repos to table view data source
        detailViewModel.output.repos
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        // basically to set cell height
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        
        // avatar
        if let avatarUrl = detailViewModel.output.avatarUrl {
            Nuke.loadImage(with: avatarUrl, into: headerView.avatarImageView)
        }
        
        // user name
        if let userName = detailViewModel.output.userName {
            headerView.nameLabel.text = userName
        }
        
        // followed or not
        detailViewModel.output.followed
            .bind(to: headerView.followButton.rx.title(for: .normal))
            .disposed(by: rx.disposeBag)
    }
}

extension UserDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        66
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView.scrollViewDidScroll(scrollView)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UserSectionHeaderView(frame: .zero)
        
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        44
    }
}
