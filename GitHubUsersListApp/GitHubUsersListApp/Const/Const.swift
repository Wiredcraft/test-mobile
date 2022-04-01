//
//  Const.swift
//  CJWProject
//
//  Created by Joy Cheng on 2022/3/31.
//

import Foundation

enum FollowCellStyle : String {
    case followList = "list"       // The cell is follow list
    case followDetail = "detail"   // The cell is detail list
}
enum LoadStyle : String {
    case pull = "pull"            // The load style is pull
    case refresh = "refresh"      // The load style is refresh
}
let toastMessager = "数据加载中..."
let headPullText = "上拉刷新..."
let footLoadText = "下拉加载..."
let followedText = "关注"
let unFollowText = "未关注"
// API
let searchAPI = "https://api.github.com/search/users?"
let followDetailAPI = "https://api.github.com/users/"
// CellID
let GitHupUserListCellID = "GitHupUserListCell_ID"
let GitHupUserListSearchHeaderViewID = "GitHupUserListSearchHeaderView_ID"
let GitHupUserDetailHeaderCellViewID = "GitHupUserDetailHeaderCellView_ID"

let detailBackGroundImage = "detail_back_ground_image"
let listIconPlaceholder = "home_list_icon_placeholder"
let listSearchIcon = "home_search"


