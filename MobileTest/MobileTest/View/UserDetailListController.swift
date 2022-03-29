//
//  UserDetailListController.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/28.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh

final class UserDetailListController: UIViewController, Storyboardable {
    
    /// view
    ///
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet public weak var avatorImageView: UIImageView!
    
    @IBOutlet public weak var userNameLabel: UILabel!
    
    @IBOutlet public weak var followButton: UIButton!
    
    @IBOutlet public weak var headerView: HeaderView!
    
    
    public var searchResults : UsersResponse?

    public var selectItem : UserModel?
            
    public var changeState: ((Bool)-> ())?
    
    private static let CellId = "UserDetailCell"
    
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        setupUI()
        setupBindings()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
}

extension UserDetailListController: UITableViewDelegate {
    
    func setupUI() {
        avatorImageView.layer.cornerRadius = avatorImageView.frame.height / 2
        followButton.layer.cornerRadius = 4.0
        tableView.register(UINib(nibName: "UserDetailCell", bundle: nil), forCellReuseIdentifier: UserDetailListController.CellId)
        tableView.tableHeaderView = headerView
    }
    
    func setupBindings() {

        guard let selectItem = selectItem else {
            return
        }

        let url = URL(string: selectItem.avator)
        avatorImageView.kf.setImage(with: url,
                                    placeholder: UIImage(named: "avator_male_icon"))
        userNameLabel.text = selectItem.userName

        followButton.setTitle((selectItem.isfollowing == true) ? "已关注" : "关注", for: .normal)
        followButton.rx.tap.subscribe { _ in
            selectItem.isfollowing = !selectItem.isfollowing
            if selectItem.isfollowing {
                self.followButton.setTitle("已关注", for: .normal)
            }else{
                self.followButton.setTitle("关注", for: .normal)
            }
            guard let changeState = self.changeState else {
                return
            }
            changeState(selectItem.isfollowing)
        }.disposed(by: bag)

        guard let searchResults = searchResults else {
            return
        }

        let observable = Observable.just(searchResults)
        observable.asDriver(onErrorJustReturn: []).drive(tableView.rx.items){ (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailCell") as! UserDetailCell

            let url = URL(string: element.avator)
            cell.avatorImageView.kf.setImage(with: url,
                                             placeholder: UIImage(named: "avator_male_icon"))
            cell.userNameLabel.text = element.userName
            cell.userScoreLabel.text = "\(element.score)"
            cell.userURLabel.text = element.htmlUrl


            return cell
        }.disposed(by: bag)
    }

}


extension UserDetailListController:UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
