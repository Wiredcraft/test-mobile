//
//  Configs.swift
//  GitUserApp
//
//  Created by Rock on 7/22/20.
//  Copyright © 2020 Rock. All rights reserved.
//

import UIKit

struct Configs {
    struct Network {
        static let kBaseUrl = "https://api.github.com"
    }
    struct UI {
        static let kViewMargin: CGFloat = 15
    }

}

struct Tool {
   static var isFullScreen: Bool {
          
          if #available(iOS 11, *) {
                guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
                    return false
                }
                
                if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
                   
                    return true
                }
          }
          return false
      }
      
      static var kNavigationBarHeight: CGFloat {
         return isFullScreen ? 88 : 64
      }
          
      static var kBottomSafeHeight: CGFloat {
         return isFullScreen ? 34 : 0
      }
}
