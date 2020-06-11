//
//  WCAPI.swift
//  Wiredcraft
//
//  Created by codeLocker on 2020/6/11.
//  Copyright © 2020 codeLocker. All rights reserved.
//

/*
 *  there are the name of server interface actions
 */
enum WCAPI: String {
    
    /// fetch the list of github users
    /// method -> get
    /// params
    ///    q: the keyword for query
    ///    page: current page index
    case usersList = "search/users"
    
}
