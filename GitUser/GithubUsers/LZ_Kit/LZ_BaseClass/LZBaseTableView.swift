//
//  LZBaseTableView.swift
//  SMHCommerce
//
//  Created by lvzhao on 2020/5/29.
//  Copyright © 2020 lvzhao. All rights reserved.
//

import UIKit

class LZBaseTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.estimatedRowHeight = 0
        self.estimatedSectionFooterHeight = 0
        self.estimatedSectionHeaderHeight = 0
        self.separatorStyle = .none
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .automatic
        } else {
            // Fallback on earlier versions
        }
        
        /**
         self.estimatedRowHeight = 0;
              self.estimatedSectionFooterHeight = 0;
              self.estimatedSectionHeaderHeight = 0;
              self.separatorStyle = UITableViewCellSeparatorStyleNone;
              if (@available(iOS 11.0, *)) {
                  self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
              }
         */
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
