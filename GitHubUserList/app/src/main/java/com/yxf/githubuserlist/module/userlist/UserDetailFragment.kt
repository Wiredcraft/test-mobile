package com.yxf.githubuserlist.module.userlist

import android.os.Bundle
import android.view.View
import com.yxf.githubuserlist.databinding.FragmentUserDetailBinding
import com.yxf.mvvmcommon.mvvm.BaseVMFragment

class UserDetailFragment : BaseVMFragment<UserListViewModel, FragmentUserDetailBinding>() {


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val detail = vm.selectedUserDetailData.value
        detail?.let { vb.webView.loadUrl(detail.htmlUrl) }
    }

}