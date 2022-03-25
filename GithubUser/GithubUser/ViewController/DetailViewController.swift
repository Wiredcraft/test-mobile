//
//  DetailViewController.swift
//  GithubUser
//
//  Created by zhaitong on 2022/3/22.
//

import UIKit
import SVProgressHUD


class DetailViewController: UIViewController {

    var data: ListItem
    var dataSource: Array<RepoMode> = .init()
    
    lazy var headerView: GroupHeadView = {
        var headerView = GroupHeadView.init(frame: .zero)
        headerView.data = data
        headerView.followCallback = {[weak self]data in
            data?.isFollow = !(data?.isFollow ?? true)
            self?.headerView.data = data
        }
        return headerView
    }()

    lazy var tableView: UITableView = {
        var tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = view.backgroundColor
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    init(data:ListItem) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initUI()
        makeLayout()
        loadData()
    }
    func initUI(){
        view.addSubview(tableView)
        view.addSubview(headerView)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
    
    func makeLayout(){
        headerView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left)
            make.top.equalTo(view.snp.top)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(240)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
            make.top.equalTo(headerView.snp.bottom)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    func loadData() {
        SVProgressHUD.show(withStatus: "加载中")
        ApiService.repos(user: self.data.login ?? "") {[weak self] resp in
            SVProgressHUD.dismiss()
            switch resp {
            case .Success(let data):
                self?.dataSource.append(contentsOf: data ?? [])
                self?.tableView.reloadData()
                break
            case .Error(_, let msg):
                SVProgressHUD.showInfo(withStatus: msg)
                break
            }
            
        }
    }
    
}
extension DetailViewController: UIGestureRecognizerDelegate{
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return .init()
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = GroupTitleView.init(frame: .zero)
        view.backgroundColor = .white
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UserTableViewCell.self)) as? UserTableViewCell
        if(cell == nil){
            cell = UserTableViewCell.init(style: .default, reuseIdentifier: nil)
            cell?.followButton.isHidden = true
            cell?.selectionStyle = .none
        }
        let data = self.dataSource[indexPath.row]
        cell?.userNameLabel.text = data.name
        cell?.htmlUrlLabel.text = data.html_url
        cell?.scoreLabel.text = "\(data.stargazers_count)"
        cell?.headerView.kf.setImage(with: URL(string: data.owner?.avatar_url ?? ""), placeholder: UIImage.init(named: "man"), options: nil, completionHandler: nil)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
}
