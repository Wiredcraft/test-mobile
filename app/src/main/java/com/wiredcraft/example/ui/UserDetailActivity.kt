package com.wiredcraft.example.ui

import android.content.Intent
import android.os.Bundle
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import com.chad.library.adapter.base.listener.OnLoadMoreListener
import com.wiredcraft.example.BaseActivity
import com.wiredcraft.example.R
import com.wiredcraft.example.databinding.ActivityUserDetailBinding
import com.wiredcraft.example.entity.Repo
import com.wiredcraft.example.entity.User
import com.wiredcraft.example.ui.adapter.RepoAdapter
import com.wiredcraft.example.viewmodel.UserDetailViewModel
import com.wiredcraft.example.widget.ArcDrawable
import com.wiredcraft.example.widget.CustomLoadMoreView

/**
 * @author 武玉朋
 *
 * Detail页：loadrepo
 */
class UserDetailActivity : BaseActivity() {

    lateinit var userDetailViewModel: UserDetailViewModel

    lateinit var user: User
    lateinit var keyword: String

    lateinit var repoAdapter: RepoAdapter
    var refresh: Boolean = true

    lateinit var userDetailBinding: ActivityUserDetailBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        userDetailBinding = DataBindingUtil.setContentView(this, R.layout.activity_user_detail)

        userDetailViewModel = ViewModelProviders.of(this).get(UserDetailViewModel::class.java)

        user = intent.extras?.getSerializable("user") as User

        keyword = intent.extras?.getString("keyword")!!

        userDetailViewModel.user = user

        userDetailBinding.user = user

        userDetailBinding.executePendingBindings()

        initView(false)

        userDetailViewModel.getRepos(
            keyword, this@UserDetailActivity
        )
    }

    override fun initActionBar() {
        userDetailBinding.btnBack.setOnClickListener {
            onBackPressed()
        }
    }

    override fun initWidget() {
        userDetailBinding.layTemp.background = ArcDrawable(resources.getColor(R.color.white))

        repoAdapter = RepoAdapter()
        initLoadMore()
        userDetailBinding.repoList.layoutManager =
            LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)
        userDetailBinding.repoList.adapter = repoAdapter
        userDetailBinding.repoList.addItemDecoration(DividerItemDecoration(this, DividerItemDecoration.VERTICAL))

        if (user.follow) {
            userDetailBinding.btnFollow.setText("取消")
        } else {
            userDetailBinding.btnFollow.setText("关注")
        }
    }

    override fun initListener() {
        userDetailViewModel._repos.observe(this, object : Observer<List<Repo>?> {
            override fun onChanged(t: List<Repo>?) {
                repoAdapter.loadMoreModule.isEnableLoadMore = true
                updateData(t)
            }
        })

        userDetailBinding.btnFollow.setOnClickListener {
            follow()
        }

        userDetailBinding.imgHead.setOnClickListener {
            follow()
        }
    }

    /**
     * 初始化加载更多
     */
    private fun initLoadMore() {
        repoAdapter.loadMoreModule
        repoAdapter.loadMoreModule.loadMoreView = CustomLoadMoreView()
        repoAdapter.loadMoreModule.setOnLoadMoreListener(OnLoadMoreListener {
            refresh = false
            userDetailViewModel.getRepos(
                keyword,
                this@UserDetailActivity
            )
        })
        repoAdapter.loadMoreModule.isAutoLoadMore = true
        repoAdapter.loadMoreModule.isEnableLoadMoreIfNotFullPage = false
    }

    /**
     * 更新数据
     */
    private fun updateData(t: List<Repo>?){
        t?.let {
            if (refresh) {
                repoAdapter.setList(it)
            } else {
                repoAdapter.addData(it)
            }

            if (it.size < 10) {
                repoAdapter.loadMoreModule.loadMoreEnd(true)
            } else {
                repoAdapter.loadMoreModule.loadMoreComplete()
            }
        } ?: let {
            repoAdapter.loadMoreModule.loadMoreEnd(true)
        }
    }

    private fun follow(){
        if (user.follow) {
            userDetailBinding.btnFollow.setText("关注")
        } else {
            userDetailBinding.btnFollow.setText("取消")
        }
        user.follow = !user.follow
    }

    override fun onBackPressed() {
        val intent = Intent()
        intent.putExtra("user", user)
        setResult(RESULT_OK, intent)
        super.onBackPressed()
    }
}