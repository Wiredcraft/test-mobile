package com.wiredcraft.testmoblie.ui

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.view.View
import android.webkit.WebChromeClient
import android.webkit.WebView
import com.wiredcraft.testmoblie.R
import kotlinx.android.synthetic.main.activity_user_detail.*


/**
 * 用户详情页
 * @author Bruce
 * @date 2020/3/5
 */
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
        toolbar.navigationIcon = resources.getDrawable(R.mipmap.icon_back)//返回键文案
        setSupportActionBar(toolbar)
        //设置返回按钮监听
        toolbar.setNavigationOnClickListener {
            finish()
        }
    }

    private fun initView() {
        progress_bar.max = 100
        webview.loadUrl(url)
        webview.webChromeClient = object : WebChromeClient() {
            override fun onProgressChanged(view: WebView?, newProgress: Int) {
                super.onProgressChanged(view, newProgress)
                progress_bar.progress = newProgress
                if (newProgress == 100) {
                    progress_bar.visibility = View.GONE
                }
            }
        }
    }

    private fun initIntentData() {
        url = intent.getStringExtra(HTML_URL)
    }
}