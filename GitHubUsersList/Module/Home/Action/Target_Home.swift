//
//  Target_Home.swift
//  GitHubUsersList
//
//  Created by YUI on 2022/3/27.
//

import UIKit

class Target_Home: NSObject {

    func Action_nativeFetchHomeViewController(NSDictionary) -> UIViewController{
        
        let homeViewController = HomeViewController()
        return homeViewController
    }
}
