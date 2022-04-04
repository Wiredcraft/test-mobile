//
//  HomeViewManager.swift
//  GitHubUsersList
//
//  Created by YUI on 2022/3/28.
//

import UIKit
import QMUIKit

class HomeViewManager: CommonViewManager, QMUITableViewDelegate, UISearchBarDelegate, UITextFieldDelegate{
    
    @objc func refreshData(){
        
        let tempView = self.managerView as! HomeView
        tempView.tableView?.reloadData()
    }
    
    @objc func endRefreshing(){
        
        let tempView = self.managerView as! HomeView
        
        if ((tempView.tableView.mj_header?.isRefreshing) != nil){
            
            //            tempView.tableView.mj_header?.isAutomaticallyChangeAlpha = true
            tempView.tableView.mj_header?.endRefreshing()
        }
        if ((tempView.tableView.mj_footer?.isRefreshing) != nil){
            
            //            tempView.tableView.mj_footer?.isAutomaticallyChangeAlpha = true
            tempView.tableView.mj_footer?.endRefreshing()
        }
    }
    
    @objc func refreshCellFollow(_ parameter: NSDictionary){
        
        if (parameter as NSDictionary?) != nil && parameter.value(forKey: "index") != nil && parameter.value(forKey: "data") != nil{
            
            let index = Int(parameter["index"] as! String) ?? 0
            let tempView = self.managerView as! HomeView
            
            let cell = tempView.tableView.cellForRow(at: IndexPath.init(row: index, section: 0))
            
            if let homeTabelViewCell = cell as? HomeTabelViewCell{
                
                if let homeUserModelFrame = parameter["data"] as? HomeUserModelFrame{
                    
                    if (homeUserModelFrame.model?.isFollow ?? false){
                        
                        homeTabelViewCell.followBtn.isSelected = true
                    }
                    else{
                        
                        homeTabelViewCell.followBtn.isSelected = false
                    }
                }
            }
            else{
                
                tempView.tableView?.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: UITableView.RowAnimation.none)
            }
        }
    }
    
    @objc func tapFollow(_ parameter: NSDictionary){
        
        if (parameter as NSDictionary?) != nil && parameter["index"] != nil{
            
            self.viewManagerDelegate?.viewManager?(self, withInfo: ["name":"tapFollow", "index":parameter["index"]!])
        }
    }
    
    @objc func pullToRefresh(){
        
        self.viewManagerDelegate?.viewManager?(self, withInfo: ["name":"pullToRefresh"])
    }
    
    @objc func pullOnLoad(){
        
        self.viewManagerDelegate?.viewManager?(self, withInfo: ["name":"pullOnLoad"])
    }
    
    @objc func restoreSubview(){
        
        let tempView = self.managerView as! HomeView
        tempView.hearderView.searchBar.searchTextField.text = ""
    }
    
    
    // MARK: - <QMUITableViewDelegate>
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //        self.viewManagerDelegate?.viewManager?(self, withInfo: ["name":"jumpHomeDetail", "index":String(indexPath.row)])
    //    }
    
    
    //    @objc func jumpHomeDetail(_ parameter: NSDictionary){
    //
    //        self.viewManagerDelegate?.viewManager?(self, withInfo: ["name":"jumpHomeDetail", "index":String(indexPath.row)])
    //    }
    
    @objc func jumpHomeDetail(_ parameter: NSDictionary){
        
        if (parameter as NSDictionary?) != nil && parameter["data"] != nil && parameter["index"] != nil{
            
            let vc = HomeDetailViewController()
            vc.setData( ["name":"homeUserModelFrame", "data":parameter["data"], "index":parameter["index"]] )
            if let currentVC = self.managerView?.qmui_viewController as? YUIViewController{
                
                vc.viewControllerDelegate = currentVC
            }
            vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            self.managerView?.qmui_viewController?.present(vc, animated: true, completion: nil)
        }
    }
    
    // MARK: - <UITextFieldDelegate>
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        self.viewManagerDelegate?.viewManager?(self, withInfo: ["name":"searchBarShouldChange", "data":textField.text!])
        
        return true;
    }
    
    //    func textFieldDidEndEditing(_ textField: UITextField) {
    //
    //        self.viewManagerDelegate?.viewManager?(self, withInfo: ["name":"SearchBarDidEndEditing", "data":textField.text!])
    //    }
}
