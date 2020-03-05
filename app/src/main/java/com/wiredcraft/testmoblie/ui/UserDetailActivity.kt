package com.wiredcraft.testmoblie.ui

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import com.wiredcraft.testmoblie.R
import kotlinx.android.synthetic.main.activity_user_detail.*
import kotlinx.android.synthetic.main.layout_app_bar.*

class UserDetailActivity : AppCompatActivity() {

    companion object {
        val HTML_URL = "html_url"
    }

    private var url: String? =null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_user_detail)
        initIntentData()
        initToolbar()
        initView()
    }

    private fun initToolbar() {
        toolbar.title = resources.getString(R.string.user_detail)//标题名字
        toolbar.navigationContentDescription = resources.getString(R.string.back)//返回键文案
        //设置返回按钮监听
        toolbar.setNavigationOnClickListener {
            finish()
        }
    }

    private fun initView() {
        webview.loadUrl(url)
    }

    private fun initIntentData() {
        url = intent.getStringExtra(HTML_URL)
    }
}