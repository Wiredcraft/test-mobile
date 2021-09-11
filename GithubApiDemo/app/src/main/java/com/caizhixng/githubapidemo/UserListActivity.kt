package com.caizhixng.githubapidemo

import androidx.core.widget.doAfterTextChanged
import com.caizhixng.githubapidemo.ToastUtils.toast
import com.caizhixng.githubapidemo.databinding.ActivityUserListBinding

/**
 * czx 2021/9/11
 */
class UserListActivity : BaseActivity() {

    private val viewBinding: ActivityUserListBinding by lazy {
        ActivityUserListBinding.inflate(layoutInflater)
    }
    private val userViewModel: UserViewModel by lazy {
        UserViewModel().apply {
            // 初始化调用
            searchUsers()
        }
    }
    private val adapter: UserAdapter by lazy {
        UserAdapter()
    }

    override fun initView() {
        super.initView()
        setContentView(viewBinding.root)
        viewBinding.rcv.adapter = adapter
    }

    override fun registerListener() {
        super.registerListener()
        viewBinding.swipe.setOnRefreshListener {
            userViewModel.searchUsers()
        }
        viewBinding.searchEt.doAfterTextChanged {

        }
    }

    override fun registerObserver() {
        super.registerObserver()
        userViewModel.userListResponse.launchAndCollectIn(this) {
            when (it.status) {
                Status.LOADING -> {
                    viewBinding.swipe.isRefreshing = true
                }
                Status.SUCCESS -> {
                    viewBinding.swipe.isRefreshing = false
                    adapter.setList(it.data)
                }
                Status.ERROR -> {
                    viewBinding.swipe.isRefreshing = false
                    toast(it.message ?: "")
                }
            }
        }
    }

}