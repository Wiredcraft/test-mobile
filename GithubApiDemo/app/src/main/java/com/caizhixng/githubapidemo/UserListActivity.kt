package com.caizhixng.githubapidemo

import androidx.lifecycle.Lifecycle
import androidx.lifecycle.lifecycleScope
import androidx.lifecycle.repeatOnLifecycle
import com.caizhixng.githubapidemo.ToastUtils.toast
import com.caizhixng.githubapidemo.databinding.ActivityUserListBinding
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

/**
 * czx 2021/9/11
 */
class UserListActivity : BaseActivity() {

    private val viewBinding: ActivityUserListBinding by lazy {
        ActivityUserListBinding.inflate(layoutInflater)
    }
    private val userViewModel: UserViewModel by lazy {
        UserViewModel().apply {
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
        if(adapter::ini)
    }

    override fun registerObserver() {
        super.registerObserver()
        lifecycleScope.launch {
            lifecycle.repeatOnLifecycle(Lifecycle.State.STARTED) {
                userViewModel.userListResponse.collect {
                    when(it.status){
                        Status.LOADING->{
                            viewBinding.swipe.isRefreshing = true
                        }
                        Status.SUCCESS->{
                            viewBinding.swipe.isRefreshing = false
                            adapter.setList(it.data)
                        }
                        Status.ERROR->{
                            viewBinding.swipe.isRefreshing = false
                            toast(it.message?:"")
                        }
                    }
                }
            }
        }
    }

}