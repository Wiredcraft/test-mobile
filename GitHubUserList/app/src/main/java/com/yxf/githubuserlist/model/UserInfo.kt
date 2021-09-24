package com.yxf.githubuserlist.model

import com.yxf.githubuserlist.model.bean.UserDetail
import java.lang.ref.WeakReference

class UserInfo(val page: Int, val index: Int) {

    var detailReference: WeakReference<UserDetail>? = null


}