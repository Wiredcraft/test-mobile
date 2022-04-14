package com.wiredcraft.githubuser.ui.activity

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import coil.load
import coil.transform.CircleCropTransformation
import com.google.gson.Gson
import com.wiredcraft.githubuser.R
import com.wiredcraft.githubuser.base.BaseActivity
import com.wiredcraft.githubuser.data.model.Item
import com.wiredcraft.githubuser.ui.adapter.RepoAdapter
import kotlinx.android.synthetic.main.activity_detail.*

class UserDetailActivity : BaseActivity() {
    private val viewModel by lazy { ViewModelProvider(this).get(UserDetailViewModel::class.java) }
    private val rAdapter by lazy { RepoAdapter() }

    private var needUpdateCount = 0

    override fun setLayoutId() = R.layout.activity_detail
    override fun isPadding() = false
    override fun isDark() = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initData()
    }

    private fun initData() {
        val userData = intent.getStringExtra(USERINFO)
        val userJson = userData?.let { Gson().fromJson<Item>(userData, Item::class.java) }
        userJson?.let {
            tvUserName.text = userJson.login
            ivAvatar.load(userJson.avatar_url) {
                placeholder(R.drawable.default_avatar)
                error(R.drawable.default_avatar)
                transformations(CircleCropTransformation())
            }
            tvDetailFollow.text = if (userJson.isFollow) "已关注" else "关注"
        }

        tvDetailFollow.setOnClickListener {
            needUpdateCount++
            if (userJson != null) {
                userJson.isFollow = !userJson.isFollow
                tvDetailFollow.text = if (userJson.isFollow) "已关注" else "关注"
            }
        }
        rvRepos.layoutManager = LinearLayoutManager(this)
        rvRepos.adapter = rAdapter

        viewModel.userRepos.observe(this, Observer { result ->
            if (result.isSuccess) {
                rAdapter.setList(result.getOrNull())
            }
        })
    }

    override fun onBackPressed() {
        super.onBackPressed()
        if (needUpdateCount % 2 == 1)
            getCallback()?.onFollowStatusChanged()
    }

    interface FollowListener {
        fun onFollowStatusChanged()
    }

    companion object {
        const val USERINFO = "userItemStr"
        private var mCallback: FollowListener? = null

        fun openBy(
            context: Context,
            userItem: String
        ) {
            context.startActivity(Intent(context, UserDetailActivity::class.java).also {
                it.putExtra(USERINFO, userItem)
            })
        }

        fun setCallback(followListener: FollowListener) {
            mCallback = followListener
        }

        fun getCallback() = mCallback
    }
}