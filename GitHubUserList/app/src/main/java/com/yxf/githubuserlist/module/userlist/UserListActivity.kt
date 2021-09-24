package com.yxf.githubuserlist.module.userlist

import android.os.Bundle
import com.yxf.githubuserlist.R
import com.yxf.githubuserlist.databinding.ActivityUserListBinding
import com.yxf.mvvmcommon.mvvm.BaseVMActivity
import org.koin.androidx.viewmodel.ext.android.viewModel

class UserListActivity : BaseVMActivity<UserListViewModel, ActivityUserListBinding>() {

    private val TAG = UserListActivity::class.simpleName

    override val vm: UserListViewModel by viewModel()


    override fun initView(savedInstanceState: Bundle?) {
        supportFragmentManager.beginTransaction()
            .replace(R.id.fragment_container, UserListFragment::class.java, null)
            .commit()
    }

    override fun initData() {

    }
}