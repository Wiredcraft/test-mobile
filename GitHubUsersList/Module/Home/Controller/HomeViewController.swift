//
//  HomeViewController.swift
//  GitHubUsersList
//
//  Created by YUI on 2022/3/27.
//

import UIKit

@objc class HomeViewController: CommonViewController {
    
    // TODO: 不知道swift怎样子类动态决议父类属性类型，可能要重写中层
    lazy var homeMainView: HomeView = HomeView()
    lazy var homeViewModel: HomeViewModel = HomeViewModel()
    lazy var homeViewManager: HomeViewManager = HomeViewManager()
    lazy var homeDataSourceObject: HomeDataSourceObject = HomeDataSourceObject()
    
    // MARK: - init
    
    override func configureArchitecture() {
        
        super.configureArchitecture(ArchitectureType.MVVM)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        viewModel.loadData?(nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
     
        super.viewDidAppear(animated)
    }
    
    override func configureBingding() {
        
        super.configureBingding()
        
        homeMainView = mainView as! HomeView
        homeViewManager = viewManager as! HomeViewManager
        homeViewManager.managerView = homeMainView
        homeViewModel = viewModel as! HomeViewModel
        
        homeDataSourceObject.modelManager = homeViewModel
//        homeMainView.tableView?.delegate = homeViewManager
        homeMainView.tableView?.delegate = homeDataSourceObject
        homeMainView.tableView?.dataSource = homeDataSourceObject
        homeMainView.hearderView.searchBar?.delegate = homeViewManager
        homeMainView.hearderView.searchBar.searchTextField.delegate = homeViewManager
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
    
    override func setData(_ parameter: Any) {
        
        self.homeViewModel.setData(parameter)
    }
    
    // MARK: - event response
    // MARK: - private methods
    // MARK: - getters and setters
}
