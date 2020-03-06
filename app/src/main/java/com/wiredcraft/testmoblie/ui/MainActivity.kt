package com.wiredcraft.testmoblie.ui

import android.content.Intent
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.os.Handler
import android.os.Message
import android.support.v4.app.ActivityOptionsCompat
import android.support.v4.util.Pair
import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.SearchView
import android.view.Menu
import android.view.View
import android.widget.Toast
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.wiredcraft.testmoblie.R
import com.wiredcraft.testmoblie.adapter.UserRecyclerViewAdapter
import com.wiredcraft.testmoblie.bean.DataResponseBean
import com.wiredcraft.testmoblie.bean.UserBean
import com.wiredcraft.testmoblie.listener.OnLoadMoreListener
import com.wiredcraft.testmoblie.network.OkHttpManager
import com.wiredcraft.testmoblie.network.ResponseCallBack
import com.wiredcraft.testmoblie.util.NetworkUtil
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.layout_title_bar.*
import okhttp3.*


class MainActivity : AppCompatActivity() {

    private val BASE_URL = "https://api.github.com/search/users"

    private val LOAD_MORE = 1001//加载更多数据
    private val REFRESH = 1002//刷新数据

    private val SUCCESS = 2001//接口请求成功
    private val FAIL = 2002//接口请求失败

    private var searchView: SearchView? = null
    private var userList = ArrayList<UserBean>()//数据源
    private var userAdapter: UserRecyclerViewAdapter? = null//适配器
    private var page = 1//页码
    private var searchText = "swift"//搜索关键字，因为api规定了q参数是必填项，所以我这里把搜索关键字默认为swift

    var handler = object: Handler() {
        override fun handleMessage(msg: Message?) {
            super.handleMessage(msg)
            if (swipe_refresh_layout.isRefreshing){//取消刷新动画
                swipe_refresh_layout.isRefreshing = false
            }
            when{
                msg?.what == SUCCESS -> {//刷新成功
                    if (userList.size == 0) {
                        userAdapter?.tipsMessage = getString(R.string.empty_text)
                    }
                    userAdapter?.notifyDataSetChanged()//列表全局刷新
                }
                msg?.what == FAIL -> {//刷新接口请求失败
                    userAdapter?.hasMoreData = false
                    userAdapter?.tipsMessage = getString(R.string.load_fail)
                    userAdapter?.notifyDataSetChanged()
                }
            }

        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        initToolbar()
        initView()
        loadData(REFRESH)
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
                searchText = newText.toString()
                loadData(REFRESH)
                return false
            }
        })
        return super.onCreateOptionsMenu(menu)
    }

    override fun onDestroy() {
        super.onDestroy()
        handler.removeCallbacksAndMessages(null)
    }

    private fun initToolbar() {
        toolbar.title = resources.getString(R.string.home_page)
        setSupportActionBar(toolbar)
    }

    private fun initView() {
        swipe_refresh_layout.setColorSchemeResources(R.color.colorPrimary)
        swipe_refresh_layout.setOnRefreshListener {
            loadData(REFRESH)//下拉刷新，加载数据
        }

        //初始化适配器
        userAdapter = UserRecyclerViewAdapter(this, userList)
        recycler_view.layoutManager = LinearLayoutManager(this)
        recycler_view.adapter = userAdapter

        //添加滑动监听，当滑动到最下面的时候加载更多
        recycler_view.addOnScrollListener(object : OnLoadMoreListener(){
            override fun onLoadMore() {
                swipe_refresh_layout.isRefreshing = true //开始加载动画
                loadData(LOAD_MORE)
            }
        })

        //列表点击监听
        userAdapter?.onItemClickListener = object : UserRecyclerViewAdapter.OnItemClickListener{
            override fun onClick(view: View, position: Int) {
                //跳转到UserDetail页面
                var intent = Intent()
                intent.putExtra(UserDetailActivity.HTML_URL, userList[position].html_url)
                intent.setClass(this@MainActivity, UserDetailActivity::class.java)
                var optionsCompat = ActivityOptionsCompat.makeSceneTransitionAnimation(this@MainActivity,
                        Pair.create(view, getString(R.string.transition_name)))
                startActivity(intent, optionsCompat.toBundle())
            }
        }
    }

    /**
     * 数据网络请求
     * @param type 类型：1.下拉刷新；2.上拉加载更多
     */
    private fun loadData(type: Int) {
        if (!NetworkUtil.isNetworkAvailable(applicationContext)) {
            //如果没有网络，则取消加载动画
            swipe_refresh_layout.isRefreshing = false
            //Toast提示
            Toast.makeText(this, R.string.check_network_text, Toast.LENGTH_SHORT).show()
            handler.sendEmptyMessage(FAIL)
            return
        }

        if (type == REFRESH) {
            userList.clear()//清理userList所有数据
            page = 1 //page重新赋值为1
        } else if (type == LOAD_MORE) {
            page++ //页码加一
        }
        val url = "$BASE_URL?q=$searchText&page=$page" //拼接完全url
        OkHttpManager.mInstance.doGet(url, object : ResponseCallBack{

            override fun onFailure(e: Throwable) {//请求失败
                handler.sendEmptyMessage(FAIL)
            }

            override fun onSuccess(response: Response) {//请求成功
                val responseJson = response.body?.string()
                //将返回值json字符串转成对象
                var data
                        = Gson().fromJson<DataResponseBean<UserBean>>(responseJson, object : TypeToken<DataResponseBean<UserBean>>(){}.type)

                if (data.total_count > 0) {//如果总数大于0，就意味着获取到了正常的用户数据
                    userAdapter?.hasMoreData = true
                    userList.addAll(data.items)//加上最新加载到的数据集合
                    handler.sendEmptyMessage(SUCCESS)//通知主线程有新数据
                } else {
                    userAdapter?.hasMoreData = false
                }
            }
        })
    }
}
