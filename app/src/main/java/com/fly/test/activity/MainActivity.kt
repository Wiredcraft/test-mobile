package com.fly.test.activity

import androidx.core.widget.addTextChangedListener
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import com.fly.test.adapter.UserAdapter
import com.fly.core.base.bindbase.BaseBindActivity
import com.fly.core.webview.WebActivity
import com.fly.core.widget.SimpleClassicsFooter
import com.fly.core.widget.SimpleClassicsHeader
import com.fly.test.databinding.ActivityMainBinding
import dagger.hilt.android.AndroidEntryPoint

/**
 * Created by likainian on 2021/7/13
 * Description:  首界面
 */

@AndroidEntryPoint
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
        //ViewModelProvider方式创建，跟随生命周期。(不需实现生命周期，不用绑定owner)
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
            vm.requestUser(it.toString())
        }
    }

    override fun initData() {
        vm.requestUser(mViewDataBinding.etWord.text.toString())
        vm.userData.observe(this, Observer{
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