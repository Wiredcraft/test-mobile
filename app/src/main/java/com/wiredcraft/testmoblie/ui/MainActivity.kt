package com.wiredcraft.testmoblie.ui

import android.content.Intent
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.os.Handler
import android.os.Message
import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.SearchView
import android.view.Menu
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
import kotlinx.android.synthetic.main.activity_main.*
import okhttp3.*


class MainActivity : AppCompatActivity() {

    private val BASE_URL = "https://api.github.com/search/users"

    private val LOAD_SUCCESS = 1000
    private val LOAD_ERROR = 1001
    private val LOAD_FAIL = 1002

    private var searchView: SearchView? = null
    private var userList = ArrayList<UserBean>()
    private var userAdapter: UserRecyclerViewAdapter? = null
    private var page = 1
    private var searchText = "swift"//搜索关键字，因为api规定了q参数是必填项，所以我这里把搜索关键字默认为swift

    var handler = object: Handler() {
        override fun handleMessage(msg: Message?) {
            super.handleMessage(msg)
            if (swipe_refresh_layout.isRefreshing){//取消刷新动画
                swipe_refresh_layout.isRefreshing = false
            }
            when{
                msg?.what == LOAD_SUCCESS -> {//请求成功
                    userAdapter?.notifyDataSetChanged()
                }
                msg?.what == LOAD_ERROR -> {//请求错误
                    if (msg?.obj is String) {
                        Toast.makeText(this@MainActivity, msg?.obj as String, Toast.LENGTH_SHORT).show()
                    }
                }
                msg?.what == LOAD_FAIL -> {//请求失败
                    userAdapter?.notifyItemChanged(userAdapter!!.itemCount)
                    Toast.makeText(this@MainActivity, R.string.load_fail, Toast.LENGTH_SHORT).show()
                }
            }

        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        initToolbar()
        initView()
        initData()
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
                initData()
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
            initData()//下拉刷新，加载数据
        }

        //初始化适配器
        userAdapter = UserRecyclerViewAdapter(this, userList)
        recycler_view.layoutManager = LinearLayoutManager(this)
        recycler_view.adapter = userAdapter

        //添加滑动监听，当滑动到最下面的时候加载更多
        recycler_view.addOnScrollListener(object : OnLoadMoreListener(){
            override fun onLoadMore() {
                page++
                loadMoreData()
            }
        })

        //列表点击监听
        userAdapter?.onItemClickListener = object : UserRecyclerViewAdapter.OnItemClickListener{
            override fun onClick(position: Int) {
                //跳转到UserDetail页面
                var intent = Intent()
                intent.putExtra(UserDetailActivity.HTML_URL, userList[position].html_url)
                intent.setClass(this@MainActivity, UserDetailActivity::class.java)
                startActivity(intent)
            }
        }
    }

    /**
     * 刷新数据
     */
    private fun initData() {
        userAdapter?.isRefreshing = true
        page = 1//每次刷新页码都设置为1
        val url = "$BASE_URL?q=$searchText&page=$page"
        OkHttpManager.mInstance.doGet(url, object : ResponseCallBack{
            override fun onFailure(e: Throwable) {
                userAdapter?.isRefreshing = false
                handler.sendEmptyMessage(LOAD_FAIL)
            }

            override fun onSuccess(response: Response) {
                userAdapter?.isRefreshing = false
                val responseJson = response.body?.string()
                //将返回值json字符串转成对象
                var data
                        = Gson().fromJson<DataResponseBean<UserBean>>(responseJson, object : TypeToken<DataResponseBean<UserBean>>(){}.type)

                if (data.total_count > 0) {//如果总数大于0，就意味着获取到了正常的用户数据
                    userList.clear()//清理userList所有数据
                    userList.addAll(data.items)//加上最新加载到的数据集合
                    page = 1 //下拉刷新后page重新赋值为1
                    handler.sendEmptyMessage(LOAD_SUCCESS)//通知主线程加载成功

                } else {//如果总数不大于0，则未获取到数据，有可能返回了错误信息
                    data.message.let {//如果存在message，则通知主线程
                        var msg = Message()
                        msg.what = LOAD_ERROR
                        msg.obj = it
                        handler.sendMessage(msg)
                    }
                }
            }

        })
    }

    /**
     * 加载更多数据
     */
    private fun loadMoreData() {
        val url = "$BASE_URL?q=$searchText&page=$page"
        OkHttpManager.mInstance.doGet(url, object : ResponseCallBack{
            override fun onFailure(e: Throwable) {
                userAdapter?.isLoadMoreSuccess = false
                handler.sendEmptyMessage(LOAD_FAIL)
            }

            override fun onSuccess(response: Response) {
                userAdapter?.isLoadMoreSuccess = true
                val responseJson = response.body?.string()
                //将返回值json字符串转成对象
                var data
                        = Gson().fromJson<DataResponseBean<UserBean>>(responseJson, object : TypeToken<DataResponseBean<UserBean>>(){}.type)

                if (data.total_count > 0) {//如果总数大于0，就意味着获取到了正常的用户数据
                    userList.addAll(data.items)//加上最新加载到的数据集合
                    handler.sendEmptyMessage(LOAD_SUCCESS)//通知主线程加载成功

                } else {//如果总数不大于0，则未获取到数据，有可能返回了错误信息
                    data.message.let {//如果存在message，则通知主线程
                        var msg = Message()
                        msg.what = LOAD_ERROR
                        msg.obj = it
                        handler.sendMessage(msg)
                    }
                }
            }
        })
    }
}
