package com.wiredcraft.mobileapp.ui.home

import android.os.Bundle
import androidx.activity.viewModels
import androidx.core.widget.addTextChangedListener
import androidx.viewbinding.ViewBinding
import com.gyf.immersionbar.ktx.immersionBar
import com.scwang.smart.refresh.layout.api.RefreshLayout
import com.scwang.smart.refresh.layout.listener.OnLoadMoreListener
import com.scwang.smart.refresh.layout.listener.OnRefreshListener
import com.wiredcraft.mobileapp.BaseActivity
import com.wiredcraft.mobileapp.R
import com.wiredcraft.mobileapp.databinding.ActivityMainLayoutBinding
import com.wiredcraft.mobileapp.domain.UIState
import com.wiredcraft.mobileapp.ext.shareViewModels
import com.wiredcraft.mobileapp.ext.toastLong
import com.wiredcraft.mobileapp.shareviewmodel.ShareViewModel
import com.wiredcraft.mobileapp.ui.userdetail.UserDetailActivity
import com.wiredcraft.mobileapp.ui.userdetail.UserDetailBean
import com.wiredcraft.mobileapp.utils.SimpleItemDecoration
import kotlin.system.exitProcess

/**
 * createTime：2023/5/30
 * author：lhq
 * desc: the MainActivity
 *
 */
class MainActivity : BaseActivity<ActivityMainLayoutBinding>(), OnRefreshListener, OnLoadMoreListener {

    private val mViewModel by viewModels<HomeActivityViewModel>()

    //Share data notifications from the user details page
    private val mShareViewModel by shareViewModels<ShareViewModel>()

    private lateinit var mAdapter: HomeAdapter

    private var lastTime = 0L
    private val interval = 1000L

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        //change system UI
        immersionBar {
            statusBarDarkFont(true)
            navigationBarColor(R.color.white)
            navigationBarDarkIcon(true)
        }
        mAdapter = HomeAdapter()
        initView()
        observeData()
    }

    /**
     * views initial
     */
    private fun initView() {
        mViewBinding.rvHome.run {
            addItemDecoration(
                SimpleItemDecoration.getInstance(context)
                    .setDividerColor(R.color.color_EFEFEF)
                    .setDividerSize(1F)
            )
            mAdapter.addChildClickViewIds(R.id.tv_follow)
            adapter = mAdapter
        }
        mViewBinding.refreshHome.run {
            setOnRefreshListener(this@MainActivity)
            setOnLoadMoreListener(this@MainActivity)
        }

        mAdapter.setOnItemClickListener { adapter, view, position ->
            val data = (mViewModel.users.value!!.uiState as UIState.Success).data
            val bean = data?.get(position) ?: //TODO handle error
            return@setOnItemClickListener
            UserDetailActivity.start(this, UserDetailBean(
                bean.identifyId,
                bean.userName,
                bean.avatarUrl,
                bean.isFollowed
            ))
        }
        mAdapter.setOnItemChildClickListener { adapter, view, position ->
            when (view.id) {
                R.id.tv_follow -> {
                    mShareViewModel.followUser.value = mAdapter.data[position].identifyId
                }
            }
        }

        mViewBinding.etHomeSearch.addTextChangedListener {
            //Limit the frequency, if we need to reuse, we can encapsulate it and share it.
            val currentTime = System.currentTimeMillis()
            if (currentTime - lastTime < interval) {
                return@addTextChangedListener
            }
            lastTime = currentTime
            val str = it.toString()
            val words = if (str.isBlank() || str.isEmpty()) mViewModel.defaultQueryWord else str
            mViewModel.queryWords.value = words
        }
    }

    /**
     * observe data change
     */
    private fun observeData() {
        mViewModel.queryWords.observe(this) {
            loadData(it, true)
        }
        mShareViewModel.followUser.observe(this) { identifyId ->
            //Only the in-memory data is modified here
            // In the actual development process,
            // the network should be requested or the database should be updated
            //find target data and update
            val sourceData = (mViewModel.users.value!!.uiState as UIState.Success).data!!
            for ((index, item) in sourceData.withIndex()) {
                if (item.identifyId == identifyId) {
                    sourceData[index].isFollowed = !sourceData[index].isFollowed
                    mAdapter.notifyItemChanged(index)
                    break
                }
            }
        }
        mViewModel.users.observe(this) { state ->
            val uiState = state.uiState
            if (state.isRefresh) {
                mViewBinding.refreshHome.finishRefresh()
            } else {
                mViewBinding.refreshHome.finishLoadMore()
            }
            when (uiState) {
                is UIState.Loading -> {
                    //TODO handle loading state
                }

                is UIState.Success -> {
                    if (uiState.data.isNullOrEmpty()) {
                        //TODO handle empty ui
                    }
                    uiState.data?.let { data ->
                        if (state.isRefresh) {
                            mAdapter.setNewInstance(data.toMutableList())
                        } else {
                            mAdapter.addData(data)
                        }
                    }
                }

                is UIState.Error -> {
                    //TODO show the error page
                }

                else -> {}
            }
        }
    }

    private fun loadData(queryWords: String, isRefresh: Boolean) {
        mViewModel.queryUsers(queryWords, isRefresh)
    }

    /**
     * refresh data
     */
    override fun onRefresh(refreshLayout: RefreshLayout) {
        loadData(mViewModel.queryWords.value!!, true)
    }

    /**
     * load more data
     */
    override fun onLoadMore(refreshLayout: RefreshLayout) {
        loadData(mViewModel.queryWords.value!!, false)
    }

    override fun findViewBinding(): ViewBinding = ActivityMainLayoutBinding.inflate(layoutInflater)

    private var extTime: Long = 0L
    override fun onBackPressed() {
        if (System.currentTimeMillis() - extTime > 2000) {
            "再按一次退出程序".toastLong(this)
            extTime = System.currentTimeMillis()
        } else {
            exitProcess(0)
        }
    }
}
