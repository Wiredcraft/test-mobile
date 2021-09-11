package com.caizhixng.githubapidemo.function

import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.webkit.WebView
import android.webkit.WebViewClient
import com.caizhixng.githubapidemo.base.BaseActivity
import com.caizhixng.githubapidemo.databinding.ActivityUserDetailBinding

class UserDetailActivity : BaseActivity() {

    companion object {
        fun start(context: Context, url: String) {
            val intent = Intent(context, UserDetailActivity::class.java)
            intent.putExtra("url", url)
            context.startActivity(intent)
        }
    }

    private lateinit var url: String

    private val viewBinding: ActivityUserDetailBinding by lazy {
        ActivityUserDetailBinding.inflate(layoutInflater)
    }

    override fun initView() {
        super.initView()
        setContentView(viewBinding.root)

        viewBinding.swipe.isEnabled = false

        url = intent.getStringExtra("url") ?: ""
        if (url.isNotBlank()) {
            viewBinding.webview.loadUrl(url)
        } else {
            finish()
        }
    }

    override fun registerListener() {
        super.registerListener()
        viewBinding.webview.webViewClient = object : WebViewClient() {

            override fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?) {
                super.onPageStarted(view, url, favicon)
                viewBinding.swipe.isRefreshing = true
            }

            override fun onPageFinished(view: WebView?, url: String?) {
                super.onPageFinished(view, url)
                viewBinding.swipe.isRefreshing = false
            }

        }
    }
}