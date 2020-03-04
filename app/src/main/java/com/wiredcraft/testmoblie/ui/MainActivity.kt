package com.wiredcraft.testmoblie.ui

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.os.Handler
import android.os.Message
import android.support.v7.widget.LinearLayoutManager
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
import kotlinx.android.synthetic.main.layout_app_bar.*
import okhttp3.*


class MainActivity : AppCompatActivity() {

    private val BASE_URL = "https://api.github.com/search/users"

    private val LOAD_SUCCESS = 1000
    private val LOAD_ERROR = 1001
    private val LOAD_FAIL = 1002

    private var userList = ArrayList<UserBean>()
    private var userAdapter: UserRecyclerViewAdapter? = null
    private var page = 1
    private var searchTerm = "swift"//搜索关键字，因为api规定了q参数是必填项，所以我这里把搜索关键字默认为swift

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
                    Toast.makeText(this@MainActivity, msg?.obj as String, Toast.LENGTH_SHORT).show()
                }
                msg?.what == LOAD_FAIL -> {//请求失败
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

    override fun onDestroy() {
        super.onDestroy()
        handler.removeCallbacksAndMessages(null)
    }

    private fun initToolbar() {
        toolbar.title = resources.getString(R.string.home_page)
    }

    private fun initView() {
        swipe_refresh_layout.setColorSchemeResources(R.color.colorPrimary)
        swipe_refresh_layout.setOnRefreshListener {
            initData()//下拉刷新，加载数据
        }
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
    }

    /**
     * 刷新数据
     */
    private fun initData() {
        val url = "$BASE_URL?q=$searchTerm&page=1"
        OkHttpManager.mInstance.doGet(url, object : ResponseCallBack{
            override fun onFailure(e: Throwable) {
                handler.sendEmptyMessage(LOAD_FAIL)
            }

            override fun onSuccess(response: Response) {
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
        val url = "$BASE_URL?q=$searchTerm&page=$page"
        OkHttpManager.mInstance.doGet(url, object : ResponseCallBack{
            override fun onFailure(e: Throwable) {
                handler.sendEmptyMessage(LOAD_FAIL)
            }

            override fun onSuccess(response: Response) {
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
