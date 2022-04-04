//
//  HomeViewModel.swift
//  GitHubUsersList
//
//  Created by YUI on 2022/3/28.
//

import UIKit

import SwiftyJSON

class HomeViewModel: CommonViewModel {
    
    var pageNum = 0
    var userModelFrames = [HomeUserModelFrame]()
    
    override func loadData(_ parameter: Any?) {
        
        NetworkKit.sharedInstance().request(withRequest: HomeRequest.init(page: pageNum + 1)) { homeRequest, responsebject in
            
            let dataJSON = JSON.init(responsebject as Any)
            
            let users = dataJSON["items"].arrayValue
            
            if(users.count != 0){
                
                self.pageNum += 1
            }
            
            if(users.count != 0 && self.pageNum == 1){
                
                self.releaseData(nil)
            }
            
            for i in 0 ..< users.count {
                
                let homeUserModelFrame = HomeUserModelFrame()
                homeUserModelFrame.model = HomeUser.init(jsonData: users[i])
                homeUserModelFrame.identifier = "HomeTabelViewCellFollowSelected"
                homeUserModelFrame.size = CGSize(width: LayoutKit.sharedInstance().adaptWidthRatio(32), height: LayoutKit.sharedInstance().adaptWidthRatio(32))
                
                homeUserModelFrame.iconHeroID = "homeIcon" + String(i)
                homeUserModelFrame.nameHeroID = "homeName" + String(i)
                homeUserModelFrame.followHeroID = "homeFollow" + String(i)
                
                self.userModelFrames.append(homeUserModelFrame)
            }
            
            self.viewModelDelegate?.viewModel?( self, withInfo: ["name":"refreshData"])
            self.viewModelDelegate?.viewModel?( self, withInfo: ["name":"endRefreshing"])
            
        } failure: { error in
            
            self.viewModelDelegate?.viewModel?( self, withInfo: ["name":"endRefreshing"])
        }
    }
    
    @objc func pullToRefresh(){
        
        pageNum = 0
        self.viewModelDelegate?.viewModel?( self, withInfo: ["name":"restoreSubview"])
        
        self.loadData(nil)
    }
    
    @objc func pullOnLoad(){
        
        self.viewModelDelegate?.viewModel?( self, withInfo: ["name":"restoreSubview"])
        for i in 0 ..< self.userModelFrames.count {
            
            let homeUserModelFrame = userModelFrames[i]
            homeUserModelFrame.isShow = true
            homeUserModelFrame.identifier = "HomeTabelViewCellFollowSelected"
        }
        self.loadData(nil)
    }
    
    override func releaseData(_ parameter: Any?) {
        
        self.userModelFrames = [HomeUserModelFrame]()
    }
    
    @objc func searchBarShouldChange(_ parameter: NSDictionary){
        
        if let dict = parameter as NSDictionary? as! [String:Any]? {
            
            if let keyword = dict["data"] as! String? {
                
                for i in 0 ..< self.userModelFrames.count {
                    
                    let homeUserModelFrame = userModelFrames[i]
                    let homeUser = homeUserModelFrame.model!
                   
                    if(homeUser.name.contains(keyword)){
                        homeUserModelFrame.isShow = true
                        homeUserModelFrame.identifier = "HomeTabelViewCellFollowSelected"
                    }
                    else{
                        homeUserModelFrame.isShow = false
                        homeUserModelFrame.identifier = "HomeEmptyTabelViewCell"
                    }
                }
                self.viewModelDelegate?.viewModel?( self, withInfo: ["name":"refreshData"])
            }
        }
    }
    
    @objc func tapFollow(_ parameter: NSDictionary){
        
        if let dict = parameter as NSDictionary? as! [String:Any]? {
            
            let index = Int(dict["index"] as! String) ?? 0
            let userModelFrame = self.userModelFrames[index]
            let isSelected = !(userModelFrame.model?.isFollow ?? false)
            userModelFrame.model?.isFollow = isSelected
            self.viewModelDelegate?.viewModel?( self, withInfo: ["name":"refreshCellFollow", "index":String(index), "data":userModelFrame])
        }
    }
    
    @objc func jumpHomeDetail(_ parameter: NSDictionary?) {
        
        if let dict = parameter as NSDictionary? as! [String:Any]? {
            
            let index = Int(dict["index"] as! String) ?? 0
            let userModelFrame = self.userModelFrames[index]
            self.viewModelDelegate?.viewModel?( self, withInfo: ["name":"jumpHomeDetail", "data":userModelFrame, "index":String(index)])
        }
    }
    
    @objc override func setData(_ parameter: Any) {
        
        if let dict = parameter as Any? as! [String:Any]? {
            
            if let subDict = dict["data"] as! [String:Any]? {
                
                if(subDict["homeUserModelFrame"] != nil && subDict["index"] != nil){
                    
                    var homeUserModelFrame = userModelFrames[Int(subDict["index"] as! String)!]
                    homeUserModelFrame = subDict["homeUserModelFrame"] as! HomeUserModelFrame
                    self.viewModelDelegate?.viewModel?( self, withInfo: ["name":"refreshCellFollow", "index":subDict["index"]!, "data":homeUserModelFrame])
                }
            }
        }
    }
}
