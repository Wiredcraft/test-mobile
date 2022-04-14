package com.wiredcraft.githubuser

import android.content.Context
import android.os.Bundle
import android.view.inputmethod.InputMethodManager
import android.widget.EditText
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import com.google.gson.Gson
import com.wiredcraft.githubuser.base.BaseActivity
import com.wiredcraft.githubuser.data.model.Item
import com.wiredcraft.githubuser.ui.activity.MainViewModel
import com.wiredcraft.githubuser.ui.activity.UserDetailActivity
import com.wiredcraft.githubuser.ui.adapter.GithubAdapter
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : BaseActivity() {
    private val viewModel by lazy { ViewModelProvider(this).get(MainViewModel::class.java) }
    private val gAdapter by lazy { GithubAdapter() }

    private var page = 1
    private var userId = "swift"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initView()
        initData()
    }

    override fun setLayoutId() = R.layout.activity_main

    private fun initView() {
        rvGitHubUsers.layoutManager = LinearLayoutManager(this)
        rvGitHubUsers.adapter = gAdapter
        ivSearch.setOnClickListener {
            hideKeyboard()
            page = 1
            viewModel.getGitHubUsers(etSearch.text.toString(), page)
        }

        gAdapter.setOnItemChildClickListener { _, view, position ->
            when (view.id) {
                R.id.clUser -> {
                    val followListener = object : UserDetailActivity.FollowListener {
                        override fun onFollowStatusChanged() {
                            gAdapter.getItem(position).isFollow =
                                !gAdapter.getItem(position).isFollow
                            gAdapter.notifyItemChanged(position)
                        }
                    }
                    UserDetailActivity.setCallback(followListener)
                    UserDetailActivity.openBy(this, Gson().toJson(gAdapter.getItem(position)))
                }
                R.id.tvFollow -> {
                    gAdapter.getItem(position).isFollow = !gAdapter.getItem(position).isFollow
                    gAdapter.notifyItemChanged(position)
                }
            }
        }
    }

    private fun hideKeyboard() {
        val view = currentFocus
        val imm = getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
        if (view != null && view is EditText) {
            imm?.hideSoftInputFromWindow(view.windowToken, 0)
        }
    }

    private fun initData() {
        page = 1
        viewModel.getGitHubUsers(userId, page)

        //refresh
        swipeRefresh.setOnRefreshListener {
            page = 1
            viewModel.getGitHubUsers(userId, page)
        }

        //load more
        gAdapter.loadMoreModule.setOnLoadMoreListener {
            page++
            viewModel.getGitHubUsers(userId, page)
        }

        viewModel.userList.observe(this, Observer { result ->
            val users = result.getOrNull()
            if (users != null) {
                if (page == 1) {
                    swipeRefresh.isRefreshing = false
                    gAdapter.setList(users as ArrayList<Item>)
                } else {
                    gAdapter.loadMoreModule.loadMoreComplete()
                    gAdapter.addData(users as ArrayList<Item>)
                }
            } else {
                gAdapter.loadMoreModule.loadMoreEnd()
            }
        })
    }
}