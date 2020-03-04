package com.wiredcraft.testmoblie.ui

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.wiredcraft.testmoblie.R
import com.wiredcraft.testmoblie.bean.DataResponseBean
import com.wiredcraft.testmoblie.bean.UserBean
import com.wiredcraft.testmoblie.network.OkHttpManager
import com.wiredcraft.testmoblie.network.ResponseCallBack
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.layout_app_bar.*
import okhttp3.*


class MainActivity : AppCompatActivity() {

    private var userList = ArrayList<UserBean>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        initToolbar()
        initView()
    }

    private fun initToolbar() {
        toolbar.title = resources.getString(R.string.home_page)
    }

    private fun initView() {
        swipe_refresh_layout.setColorSchemeResources(R.color.colorPrimary)
        swipe_refresh_layout.setOnRefreshListener {
            initData()
        }
    }

    private fun initData() {
        val url = "https://api.github.com/search/users?q=${"swift"}&page=${1}"
        OkHttpManager.mInstance.doGet(url, object : ResponseCallBack{
            override fun onFailure(e: Throwable) {
                runOnUiThread {
                    if (swipe_refresh_layout.isRefreshing){
                        swipe_refresh_layout.isRefreshing = false
                    }
                }
            }

            override fun onSuccess(response: Response) {
                var gson = Gson()
                var data
                        = gson.fromJson<DataResponseBean<UserBean>>(response.body?.string(), object : TypeToken<DataResponseBean<UserBean>>(){}.type)
                userList.addAll(data.items)
                runOnUiThread {
                    if (swipe_refresh_layout.isRefreshing){
                        swipe_refresh_layout.isRefreshing = false
                    }
                }
            }

        })
    }
}
