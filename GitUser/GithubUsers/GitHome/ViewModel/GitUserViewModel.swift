//
//  GitUserViewModel.swift
//  GithubUsers
//
//  Created by lvzhao on 2020/7/22.
//  Copyright © 2020 吕VV. All rights reserved.
//

import UIKit
import SwiftyJSON

class GitUserViewModel: LZBaseViewModel {

    
    
    deinit {
        print("\(self)释放了");
    }

    //搜索的名字
    var searchName: String = ""

    
    //分页
    private var indexPage: Int = 1

    override init() {
        super.init()
    }

    
    //MARK :- 搜索用户
    func searchUser(search:String,isFirst :Bool) {
        if isFirst {
            self.dataArray.removeAll()
            self.indexPage = 1
        }
        APINetWork.request((search.count == 0) ?  .userList(self.indexPage) : .search(search, self.indexPage), success: { [weak self] result in
            dismiss()
            if let weakSelf = self {
                
                //根据是否搜索的结果
                if search.count == 0{
                    let dataArray = JSON(result)
                    //解析数据
                    if let items = dataArray.arrayObject {
                        for item in items {
                            let dataDict = item as? [String : Any]
                            if let object = GitUserModel.deserialize(from: dataDict) {
                                //添加元素
                                weakSelf.dataArray.append(object)
                            }
                        }
                    }
                    
                    //没有数据
                    if dataArray.count == 0{
                        weakSelf.publishSubject.onNext(0)
                        return
                    }
                } else {
                    let dictionary = JSON(result)
                    if let items = dictionary["items"].arrayObject {
                        for item in items {
                            let dataDict = item as? [String : Any]
                            if let object = GitUserModel.deserialize(from: dataDict) {
                                //添加元素
                                weakSelf.dataArray.append(object)
                            }
                        }
                        //没有数据
                        if items.count == 0{
                            weakSelf.publishSubject.onNext(0)
                            return
                        }
                    }
                }
                
                //分页加一
                weakSelf.indexPage += 1
                weakSelf.publishSubject.onNext(1)

            }
                  
            //回调
           }, error: { [weak self] code in
              if let weakSelf = self  {
                   dismiss()
                   weakSelf.publishSubject.onNext(1)
               }
           }) { [weak self] (error) in
                if let weakSelf = self  {
                   dismiss()
                   weakSelf.publishSubject.onNext(1)
               }
           }
        
        
        
        
        
    }
    
    
    
}



