package com.yxf.githubuserlist.module.userlist

import android.os.Bundle
import android.view.KeyEvent
import androidx.fragment.app.Fragment
import com.yxf.githubuserlist.R
import com.yxf.githubuserlist.databinding.ActivityUserListBinding
import com.yxf.mvvmcommon.mvvm.BaseVMActivity
import org.koin.androidx.viewmodel.ext.android.viewModel

class UserListActivity : BaseVMActivity<UserListViewModel, ActivityUserListBinding>() {

    private val TAG = UserListActivity::class.simpleName

    override val vm: UserListViewModel by viewModel()

    private var currentFragment:Fragment? = null

    override fun initView(savedInstanceState: Bundle?) {
        addFragment(UserListFragment::class.java)
    }

    override fun initData() {
        initObserver()
    }

    private fun initObserver() {
        vm.selectedUserDetailData.observe(this, {
            addFragment(UserDetailFragment::class.java)
        })
    }


    private fun addFragment(fClass: Class<out Fragment>, args: Bundle? = null) {
        val tag = fClass.canonicalName
        supportFragmentManager.beginTransaction().run {
            add(R.id.fragment_container, fClass, args, tag)
            addToBackStack(null)
            commit()
        }
        currentFragment = supportFragmentManager.findFragmentByTag(tag)
    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
        when (keyCode) {
            KeyEvent.KEYCODE_BACK -> {
                val count = supportFragmentManager.backStackEntryCount
                if (count <= 1) {
                    finish()
                    return true
                }
            }
        }
        return super.onKeyDown(keyCode, event)
    }
}