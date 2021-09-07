package com.fly.test.activity

import androidx.core.widget.addTextChangedListener
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import com.fly.test.adapter.UserAdapter
import com.fly.core.base.bindbase.BaseBindActivity
import com.fly.core.webview.WebActivity
import com.fly.core.widget.SimpleClassicsFooter
import com.fly.core.widget.SimpleClassicsHeader
import com.fly.test.databinding.ActivityMainBinding

/**
 * Created by likainian on 2021/7/13
 * Description:  首界面
 */
class MainActivity : BaseBindActivity<ActivityMainBinding>() {

    val layoutManager by lazy {
        LinearLayoutManager(this)
    }
    val adapter by lazy {
        UserAdapter()
            .apply {
                onClickItem = {
                    WebActivity.startActivity(this@MainActivity,it.html_url)
                }
            }
    }
    private val vm by lazy {
        ViewModelProvider(this).get(MainViewModel::class.java)
    }

    override fun createBinding() = ActivityMainBinding.inflate(layoutInflater)
        .apply {
            owner = this@MainActivity
        }

    override fun initView() {
        mViewDataBinding.smartRefresh.setRefreshHeader(SimpleClassicsHeader(this))
        mViewDataBinding.smartRefresh.setRefreshFooter(SimpleClassicsFooter(this))
        mViewDataBinding.smartRefresh.setOnRefreshListener {
            vm.requestUser(mViewDataBinding.etWord.text.toString())
        }
        mViewDataBinding.smartRefresh.setOnLoadMoreListener {
            vm.requestNext(mViewDataBinding.etWord.text.toString())
        }
        mViewDataBinding.etWord.addTextChangedListener {
            vm.requestNext(it.toString())
        }
    }

    override fun initData() {
        vm.requestUser(mViewDataBinding.etWord.text.toString())
        vm.userData.observe(this, {
            mViewDataBinding.smartRefresh.finishRefresh()
            mViewDataBinding.smartRefresh.finishLoadMore()
            if (vm.page == 1) {
                adapter.setNewData(it.items)
            } else {
                adapter.addData(it.items)
            }
        })
    }
}