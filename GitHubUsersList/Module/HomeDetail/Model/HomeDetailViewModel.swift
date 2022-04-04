//
//  HomeDetailViewModel.swift
//  GitHubUsersList
//
//  Created by YUI on 2022/4/4.
//

import UIKit

import SwiftyJSON

class HomeDetailViewModel: CommonViewModel {
    
    var pageNum = 0
    var index = 0
    var homeUserModelFrame : HomeUserModelFrame?
    var userModelFrames = [HomeDetailUserModelFrame]()
    
    override func loadData(_ parameter: Any?) {
        
        NetworkKit.sharedInstance().request(withRequest: HomeDetailRequest.init(page: pageNum + 1)) { homeRequest, responseObject in
            
            let dataJSON = JSON.init(responseObject as Any)
            
            let users = dataJSON.arrayValue
            
            if(users.count != 0){
                
                self.pageNum += 1
            }
            
            if(users.count != 0 && self.pageNum == 1){
                
                self.releaseData(nil)
            }
            
            for i in 0 ..< users.count {
                
                let homeUserModelFrame = HomeDetailUserModelFrame()
                homeUserModelFrame.model = HomeDetailUser.init(jsonData: users[i])
                homeUserModelFrame.identifier = "HomeTabelViewCell"
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
        self.loadData(nil)
    }
    
    @objc func pullOnLoad(){
        
        self.loadData(nil)
    }
    
    @objc override func setData(_ parameter: Any) {
        
        if let dict = parameter as Any? as! [String:Any]? {
            
            if(dict["name"] != nil && dict["name"] as! String == "homeUserModelFrame"){
                
                if(dict["data"] != nil && dict["index"] != nil){
                    
                    homeUserModelFrame = dict["data"] as? HomeUserModelFrame
                    index = Int((dict["index"] as! String))!
                }
            }
        }
    }
    
    @objc override func getData(_ parameter: Any) -> Any? {
        
        if let dict = parameter as Any? as! [String:Any]? {
            
            if(dict["name"] != nil && dict["name"] as! String == "tapBack"){
                
                return ["data":self.homeUserModelFrame!, "index":String(index)]
            }
        }
        return nil
    }
    
    override func releaseData(_ parameter: Any?) {
        
        self.userModelFrames = [HomeDetailUserModelFrame]()
    }
    
    @objc func tapFollow(_ parameter: NSDictionary){
        
        let isSelected = !(homeUserModelFrame?.model?.isFollow ?? false)
        homeUserModelFrame?.model?.isFollow = isSelected
        
        self.viewModelDelegate?.viewModel?( self, withInfo: ["name":"setHomeUserData", "data":homeUserModelFrame!])
        
        //        if let dict = parameter as NSDictionary? as! [String:Any]? {
        //
        //            let index = Int(dict["index"] as! String) ?? 0
        //            let userModelFrame = self.userModelFrames[index]
        //            let isSelected = !(userModelFrame.model?.isFollow ?? false)
        //            userModelFrame.model?.isFollow = isSelected
        //            self.viewModelDelegate?.viewModel?( self, withInfo: ["name":"refreshCellFollow", "index":String(index), "data":userModelFrame])
        //        }
    }
}
