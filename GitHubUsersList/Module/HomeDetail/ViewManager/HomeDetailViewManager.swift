//
//  HomeDetailViewManager.swift
//  GitHubUsersList
//
//  Created by YUI on 2022/4/4.
//

import UIKit

import Hero
import QMUIKit

class HomeDetailViewManager: CommonViewManager, QMUITableViewDelegate, UIScrollViewDelegate, UISearchBarDelegate, UITextFieldDelegate{
    
    @objc func refreshData(){
        
        let tempView = self.managerView as! HomeDetailView
        tempView.tableView?.reloadData()
    }
    
    @objc func setHomeUserData(_ parameter: NSDictionary){
        
        let tempView = self.managerView as! HomeDetailView
        
        if let homeUserModelFrame = parameter["data"] as? HomeUserModelFrame{
            
            tempView.iconIV.sd_setImage(with: URL.init(string: homeUserModelFrame.model?.avatarURLStr ?? "") , completed: nil)
            tempView.nameLabel.text = homeUserModelFrame.model?.name
            if (homeUserModelFrame.model?.isFollow == true){
                
                tempView.followBtn.isSelected = true
            }
            else{
                
                tempView.followBtn.isSelected = false
            }
            
            tempView.iconIV.heroID = homeUserModelFrame.iconHeroID
            tempView.nameLabel.heroID = homeUserModelFrame.nameHeroID
            tempView.followBtn.heroID = homeUserModelFrame.followHeroID
        }
    }
    
    @objc func endRefreshing(){
        
        let tempView = self.managerView as! HomeDetailView
        
        if ((tempView.tableView.mj_header?.isRefreshing) != nil){
            
            tempView.tableView.mj_header?.endRefreshing()
        }
        if ((tempView.tableView.mj_footer?.isRefreshing) != nil){
            
            tempView.tableView.mj_footer?.endRefreshing()
        }
    }
    
    @objc func tapFollow(_ parameter: NSDictionary){
        
        self.viewManagerDelegate?.viewManager?(self, withInfo: ["name":"tapFollow"])
    }
    
    @objc func pullToRefresh(){
        
        self.viewManagerDelegate?.viewManager?(self, withInfo: ["name":"pullToRefresh"])
    }
    
    @objc func pullOnLoad(){
        
        self.viewManagerDelegate?.viewManager?(self, withInfo: ["name":"pullOnLoad"])
    }
    
    @objc func tapBack(){
        
        self.managerView?.qmui_viewController?.dismiss(animated: true, completion: {
            
            if let currentVC = self.managerView?.qmui_viewController as? YUIViewController{
                
                if let tapBackParameter = currentVC.getData(["name": "tapBack"]) as! [String:Any]? {
                    
                    currentVC.viewControllerDelegate?.viewController?(currentVC, withInfo: ["name":"setData", "data":["homeUserModelFrame":tapBackParameter["data"], "index":tapBackParameter["index"]]])
                }
            }
        })
    }
    
    // MARK: - <QMUITableViewDelegate>
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionView = HomeDetailSectionView()
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - <UIScrollViewDelegate>
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let tempView = self.managerView as! HomeDetailView
        
        var contentOffset = scrollView.contentOffset
        
        let underlyingValue = LayoutKit.sharedInstance().adaptWidthRatio(230 - 35) + LayoutKit.sharedInstance().statusBarHeight
        
        let x = CGFloat(underlyingValue) + contentOffset.y
        
        let y = CGFloat(underlyingValue) - CGFloat(LayoutKit.sharedInstance().safeAreaTopHeight)
        
        let percent = 1 - CGFloat(x) / CGFloat(y)
        
        ////        print(contentOffset.y)
        //
        ////        print(((LayoutKit.sharedInstance().adaptWidthRatio(230 - 35))))
//        //
//                print(contentOffset.y)
//                print(percent)
        
        
        
        tempView.iconIV.alpha = percent
        tempView.nameLabel.alpha = percent
        tempView.followBtn.alpha = percent
        
        //TopView高度控制
        let tempHeight = CGFloat(LayoutKit.sharedInstance().adaptWidthRatio(230)) - contentOffset.y - CGFloat(underlyingValue)
        let mainHeight = CGFloat(LayoutKit.sharedInstance().safeAreaTopHeight) + CGFloat(LayoutKit.sharedInstance().adaptWidthRatio(20))
        
//        print(tempHeight)
        
        if (tempHeight >= mainHeight){
            
            tempView.bgIV.snp.updateConstraints { make in
                
//                make.top.left.width.equalToSuperview()
                make.height.equalTo(tempHeight);
            }
        }
        else{
            
            tempView.bgIV.snp.updateConstraints { make in
                
//                make.top.left.width.equalToSuperview()
                make.height.equalTo(mainHeight);
            }
        }
    }
}
