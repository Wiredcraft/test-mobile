//
//  HomeDetailViewController.swift
//  GitHubUsersList
//
//  Created by YUI on 2022/4/1.
//

import UIKit
import YUIArchitectureKit
import Hero

class HomeDetailViewController: CommonViewController {
    
    // TODO: 不知道swift怎样子类动态决议父类属性类型，可能要重写中层
    lazy var homeDetailMainView: HomeDetailView = HomeDetailView()
    lazy var homeDetailViewModel: HomeDetailViewModel = HomeDetailViewModel()
    lazy var homeDetailViewManager: HomeDetailViewManager = HomeDetailViewManager()
    lazy var homeDetailDataSourceObject: HomeDetailDataSourceObject = HomeDetailDataSourceObject()
    
    // MARK: - init
    
    override func configureArchitecture() {
        
        super.configureArchitecture(ArchitectureType.MVVM)
    }
    
    override func didInitialize() {
        
        super.didInitialize()
        self.hero.isEnabled = true
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        viewModel.loadData?(nil)
        homeDetailViewManager.setHomeUserData(["data":homeDetailViewModel.homeUserModelFrame!])
    }
    
    override func configureBingding() {
        
        super.configureBingding()
        
        homeDetailMainView = mainView as! HomeDetailView
        homeDetailViewManager = viewManager as! HomeDetailViewManager
        homeDetailViewManager.managerView = homeDetailMainView
        homeDetailViewModel = viewModel as! HomeDetailViewModel
        
        homeDetailDataSourceObject.modelManager = homeDetailViewModel
        homeDetailMainView.tableView?.delegate = homeDetailViewManager
        homeDetailMainView.tableView?.dataSource = homeDetailDataSourceObject
    }
    
    override func setupNavigationItems() {
        
        super.setupNavigationItems()
    }
    
    // MARK: - ViewDelegate
    
    // MARK: - <UITableViewDelegate>
    
    //- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //
    //    return <#view#>;
    //}
    //
    //- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    //    <#code#>
    //}
    
    // MARK: - CustomDelegate
    
//    @objc func setData(parameter : AnyObject) {
//
//        self.viewModel.setData?(parameter)
//    }
    
    override func setData(_ parameter: Any) {
        
        self.viewModel.setData?(parameter)
    }
    
    override func getData(_ parameter: Any) -> Any? {
        
        return self.viewModel.getData!(parameter)
    }
    
    // MARK: - event response
    // MARK: - private methods
    // MARK: - getters and setters
}
