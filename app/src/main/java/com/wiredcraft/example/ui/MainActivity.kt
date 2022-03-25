package com.wiredcraft.example.ui

import android.app.ActivityOptions
import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import androidx.annotation.VisibleForTesting
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.test.espresso.IdlingResource
import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.listener.OnItemClickListener
import com.chad.library.adapter.base.listener.OnLoadMoreListener
import com.makeramen.roundedimageview.RoundedImageView
import com.wiredcraft.example.BaseActivity
import com.wiredcraft.example.R
import com.wiredcraft.example.entity.User
import com.wiredcraft.example.listener.OnItemClickListenerWC
import com.wiredcraft.example.ui.adapter.UserAdapter
import com.wiredcraft.example.util.EspressoIdlingResource
import com.wiredcraft.example.viewmodel.MainViewModel
import com.wiredcraft.example.widget.CustomLoadMoreView
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.layout_search_bar.*

/**
 * @author 武玉朋
 *
 * 应用首页：loaddata和search功能
 */
class MainActivity : BaseActivity(), OnItemClickListenerWC<User> {

    lateinit var mainViewModel: MainViewModel
    lateinit var userAdapter: UserAdapter
    var refresh: Boolean = true
    var keyword: String = "swift"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        mainViewModel = ViewModelProviders.of(this).get(MainViewModel::class.java)

        initView(true)

        loadData()
    }

    override fun initActionBar() {}

    override fun initWidget() {

        swipe_refresh.isRefreshing = true

        userAdapter = UserAdapter()

        userAdapter.setOnItemClickListener(this)

        initLoadMore()

        recycle_view.layoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)

        recycle_view.addItemDecoration(DividerItemDecoration(this,DividerItemDecoration.VERTICAL))

        recycle_view.adapter = userAdapter
    }

    override fun initListener() {
        mainViewModel._user.observe(this, object : Observer<MutableList<User>?> {
            override fun onChanged(t: MutableList<User>?) {
                swipe_refresh.isRefreshing = false
                userAdapter.loadMoreModule.isEnableLoadMore = true

                updateData(t)
                if (!EspressoIdlingResource.idlingResource.isIdleNow()) {
                    EspressoIdlingResource.decrement();
                }
            }
        })

        swipe_refresh.setOnRefreshListener {
            refresh = true
            userAdapter.loadMoreModule.isEnableLoadMore = false
            loadData()
        }

        et_search.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence, start: Int, count: Int, after: Int) {}
            override fun onTextChanged(s: CharSequence, start: Int, before: Int, count: Int) {}
            override fun afterTextChanged(s: Editable) {
                keyword = s.toString().trim { it <= ' ' }
                refresh = true
                loadData()
            }
        })
    }

    /**
     * 点击item跳转至detail页面
     */
    override fun onClick(user: User,head:RoundedImageView) {
        val bundle = Bundle()
        bundle.putSerializable("user", user)
        bundle.putSerializable("keyword", keyword)

        val intent = Intent(this@MainActivity, UserDetailActivity::class.java)
        intent.putExtras(bundle)
        startActivityForResult(intent, 0x0001,ActivityOptions.makeSceneTransitionAnimation(this,head,"head").toBundle())
    }

    /**
     * 初始化加载更多View
     */
    private fun initLoadMore() {
        userAdapter.loadMoreModule
        userAdapter.loadMoreModule.loadMoreView = CustomLoadMoreView()
        userAdapter.loadMoreModule.setOnLoadMoreListener(OnLoadMoreListener {
            refresh = false
            loadData()
        })
        userAdapter.loadMoreModule.isAutoLoadMore = true
        userAdapter.loadMoreModule.isEnableLoadMoreIfNotFullPage = false
    }

    /**
     * loaddata
     */
    private fun loadData(){
        EspressoIdlingResource.increment();
        mainViewModel.getUsers(
            keyword,
            refresh,
            this@MainActivity
        )
    }

    /**
     * 响应数据，更新UI
     */
    private fun updateData(t: MutableList<User>?){
        t?.let {
            if (refresh) {
                userAdapter.setList(it)
            } else {
                userAdapter.addData(it)
            }

            if (it.size < 10) {
                userAdapter.loadMoreModule.loadMoreEnd(true)
            } else {
                userAdapter.loadMoreModule.loadMoreComplete()
            }
        } ?: let {
            userAdapter.loadMoreModule.loadMoreEnd(true)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        //更新变更的Item
        if (requestCode == 0x0001 && resultCode == RESULT_OK) {
            val item = data?.getSerializableExtra("user") as User
            userAdapter.updateItem(item)
        }
    }

    /**
     * 单元测试异步请求使用
     */
    @VisibleForTesting
    fun getCountingIdlingResource(): IdlingResource? {
        return EspressoIdlingResource.idlingResource
    }
}