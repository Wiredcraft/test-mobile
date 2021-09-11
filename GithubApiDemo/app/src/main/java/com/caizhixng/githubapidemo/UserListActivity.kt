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
            // reset page and load form the first page with keyword
            userViewModel.page.restPage()
            userViewModel.searchUsers()
        }
        viewBinding.searchEt.doAfterTextChanged {
            val keyWord = it.toString()
            userViewModel.page.keyWord = keyWord
            userViewModel.searchUsers()
        }
        adapter.loadMoreModule.setOnLoadMoreListener {
            userViewModel.page.addPage()
            userViewModel.searchUsers()
        }
        adapter.setOnItemClickListener { adapter, _, position ->
            val user = adapter.data[position] as User
            if (!user.mainPage.isNullOrBlank()) {
                UserDetailActivity.start(this, user.mainPage)
            } else {
                toast("The user does not have a main page")
            }
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
                    if (userViewModel.page.isFirstPage()) {
                        adapter.setList(it.data)
                    } else {
                        adapter.addData(it.data ?: emptyList())
                    }
                    if (it.data?.size ?: 0 < userViewModel.page.perPage) {
                        adapter.loadMoreModule.loadMoreEnd()
                    } else {
                        adapter.loadMoreModule.loadMoreComplete()
                    }
                    userViewModel.page.addPage()
                }
                Status.ERROR -> {
                    userViewModel.page.restPage()
                    adapter.loadMoreModule.loadMoreComplete()
                    viewBinding.swipe.isRefreshing = false
                    it.message?.let { message ->
                        toast(message)
                    }
                }
            }
        }
    }

}