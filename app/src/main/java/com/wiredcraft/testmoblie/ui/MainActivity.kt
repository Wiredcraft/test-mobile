package com.wiredcraft.testmoblie.ui

import android.content.Intent
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.v4.app.ActivityOptionsCompat
import android.support.v4.util.Pair
import android.support.v7.widget.SearchView
import android.support.v7.widget.Toolbar
import android.view.Menu
import android.view.View
import com.wiredcraft.github_users.ui.UserDetailActivity
import com.wiredcraft.github_users.widget.GithubUsersView
import com.wiredcraft.github_users.widget.GithubUsersView.Companion.REFRESH
import com.wiredcraft.testmoblie.R
import com.wiredcraft.testmoblie.bean.UserBean
import kotlinx.android.synthetic.main.activity_main.*


class MainActivity : AppCompatActivity() {

    private var searchView: SearchView? = null
    private var toolbar: Toolbar? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        initToolbar()
        initView()
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        //初始化菜单
        menuInflater.inflate(R.menu.toolbar_menu, menu)
        //获取SearchView对象
        val searchItem = menu?.findItem(R.id.search)
        searchView = searchItem?.actionView as SearchView?
        searchView?.queryHint = "swift"
        //添加SearchView为监听
        searchView?.setOnQueryTextListener(object : SearchView.OnQueryTextListener{

            override fun onQueryTextSubmit(p0: String?): Boolean {
                return false
            }

            override fun onQueryTextChange(newText: String?): Boolean {
                github_users_view.searchText = newText.toString()
                github_users_view.loadData(REFRESH)
                return false
            }
        })
        return super.onCreateOptionsMenu(menu)
    }

    private fun initToolbar() {
        toolbar = findViewById(R.id.toolbar)
        toolbar?.title = resources.getString(R.string.home_page)
        setSupportActionBar(toolbar)
    }

    private fun initView() {
        //设置点击监听
        github_users_view.onViewItemClickListener = object : GithubUsersView.OnViewItemClickListener{
            override fun onItemClick(view: View, userBean: UserBean) {
                //跳转到UserDetail页面
                var intent = Intent()
                intent.putExtra(UserDetailActivity.HTML_URL, userBean.html_url)
                intent.setClass(this@MainActivity, UserDetailActivity::class.java)
                var optionsCompat = ActivityOptionsCompat.makeSceneTransitionAnimation(this@MainActivity,
                        Pair.create(view, getString(R.string.transition_name)))
                startActivity(intent, optionsCompat.toBundle())
            }
        }
    }
}
