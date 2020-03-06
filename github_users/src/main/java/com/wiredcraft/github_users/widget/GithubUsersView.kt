package com.wiredcraft.github_users.widget

import android.content.Context
import android.os.Handler
import android.os.Message
import android.support.design.widget.CoordinatorLayout
import android.support.v7.widget.LinearLayoutManager
import android.util.AttributeSet
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.widget.Toast
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.wiredcraft.github_users.R
import com.wiredcraft.testmoblie.adapter.UserRecyclerViewAdapter
import com.wiredcraft.testmoblie.bean.DataResponseBean
import com.wiredcraft.testmoblie.bean.UserBean
import com.wiredcraft.testmoblie.listener.OnLoadMoreListener
import com.wiredcraft.testmoblie.network.OkHttpManager
import com.wiredcraft.testmoblie.network.ResponseCallBack
import com.wiredcraft.testmoblie.util.NetworkUtil
import kotlinx.android.synthetic.main.layout_mygithub.view.*
import okhttp3.Response

class GithubUsersView @JvmOverloads constructor(
        context: Context, attrs: AttributeSet? = null, defStyleAttr: Int = 0
) : CoordinatorLayout(context, attrs, defStyleAttr) {

    private val BASE_URL = "https://api.github.com/search/users"

    companion object{
        val LOAD_MORE = 1001//加载更多数据
        val REFRESH = 1002//刷新数据
    }

    private val SUCCESS = 2001//接口请求成功
    private val FAIL = 2002//接口请求失败

    private var userList = ArrayList<UserBean>()//数据源
    private var userAdapter: UserRecyclerViewAdapter? = null//适配器
    private var page = 1//页码
    var searchText = "swift"//搜索关键字，因为api规定了q参数是必填项，所以我这里把搜索关键字默认为swift

    var onViewItemClickListener: OnViewItemClickListener? = null

    interface OnViewItemClickListener {
        fun onItemClick(view: View, userBean: UserBean)
    }

    private var handler = object: Handler() {
        override fun handleMessage(msg: Message?) {
            super.handleMessage(msg)
            if (swipe_refresh_layout.isRefreshing){//取消刷新动画
                swipe_refresh_layout.isRefreshing = false
            }
            when{
                msg?.what == SUCCESS -> {//刷新成功
                    if (userList.size == 0) {
                        userAdapter?.tipsMessage = context.resources.getString(R.string.empty_text)
                    }
                    userAdapter?.notifyDataSetChanged()//列表全局刷新
                }
                msg?.what == FAIL -> {//刷新接口请求失败
                    userAdapter?.hasMoreData = false
                    userAdapter?.tipsMessage = context.resources.getString(R.string.load_fail)
                    userAdapter?.notifyDataSetChanged()
                }
            }

        }
    }

    init {

        LayoutInflater.from(context).inflate(R.layout.layout_mygithub, this, true)
        initView()
        loadData(REFRESH)
    }

    private fun initView() {
        swipe_refresh_layout.setColorSchemeResources(R.color.colorPrimary)
        swipe_refresh_layout.setOnRefreshListener {
            loadData(REFRESH)//下拉刷新，加载数据
        }

        //初始化适配器
        userAdapter = UserRecyclerViewAdapter(context, userList)
        recycler_view.layoutManager = LinearLayoutManager(context)
        recycler_view.adapter = userAdapter

        //添加滑动监听，当滑动到最下面的时候加载更多
        recycler_view.addOnScrollListener(object : OnLoadMoreListener(){
            override fun onLoadMore() {
                loadData(LOAD_MORE)
            }
        })

        //列表点击监听
        userAdapter?.onItemClickListener = object : UserRecyclerViewAdapter.OnItemClickListener{
            override fun onClick(view: View, position: Int) {
                onViewItemClickListener?.onItemClick(view, userList[position])
            }
        }
    }

    /**
     * 数据网络请求
     * @param type 类型：1.下拉刷新；2.上拉加载更多
     */
    public fun loadData(type: Int) {
        if (!NetworkUtil.isNetworkAvailable(context.applicationContext)) {
            //如果没有网络，则取消加载动画
            if (swipe_refresh_layout.isRefreshing) {
                swipe_refresh_layout.isRefreshing = false
            }
            //Toast提示
            Toast.makeText(context, R.string.check_network_text, Toast.LENGTH_SHORT).show()
            handler.sendEmptyMessage(FAIL)
            return
        }

        if (type == REFRESH) {
            if (!swipe_refresh_layout.isRefreshing) {
                swipe_refresh_layout.isRefreshing = true //开启刷新动画
            }
            userList.clear()//清理userList所有数据
            page = 1 //page重新赋值为1
        } else if (type == LOAD_MORE) {
            page++ //页码加一
        }
        val url = "$BASE_URL?q=$searchText&page=$page" //拼接完全url
        Log.i("Test", url)
        OkHttpManager.mInstance.doGet(url, object : ResponseCallBack {

            override fun onFailure(e: Throwable) {//请求失败
                handler.sendEmptyMessage(FAIL)
                Log.i("Test", "Fail")
            }

            override fun onSuccess(response: Response) {//请求成功
                Log.i("Test", "Success")
                val responseJson = response.body?.string()
                //将返回值json字符串转成对象
                var data
                        = Gson().fromJson<DataResponseBean<UserBean>>(responseJson, object : TypeToken<DataResponseBean<UserBean>>(){}.type)

                if (data.items != null && data.items.size > 0) {//如果itmes的size大于0，就意味着获取到了正常的用户数据
                    userAdapter?.hasMoreData = data.items.size >= 30 //接口一页返回的数据最多是30条，所以如果小于30条，意味着下一页没有更多数据了。
                    userList.addAll(data.items)//加上最新加载到的数据集合
                } else {
                    userAdapter?.hasMoreData = false
                }
                handler.sendEmptyMessage(SUCCESS)//通知主线程接口调用成功
            }
        })
    }

    override fun onDetachedFromWindow() {
        super.onDetachedFromWindow()
        handler.removeCallbacksAndMessages(null)
    }
}