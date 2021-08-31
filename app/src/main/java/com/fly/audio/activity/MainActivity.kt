package com.fly.audio.activity

import androidx.core.widget.addTextChangedListener
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import com.fly.audio.adapter.UserAdapter
import com.fly.audio.databinding.ActivityMainBinding
import com.fly.core.base.bindbase.BaseBindActivity
import com.fly.core.widget.SimpleClassicsFooter
import com.fly.core.widget.SimpleClassicsHeader

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
    }
    private val vm by lazy {
        MainViewModel()
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
        mViewDataBinding.etWord.setText("swift")
        vm.requestUser(mViewDataBinding.etWord.text.toString())
        vm.userData.observe(this, Observer {
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