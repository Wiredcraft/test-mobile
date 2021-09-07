package com.fly.core.webview

import android.content.Context
import android.content.Intent
import android.content.pm.ActivityInfo
import android.content.res.Configuration
import android.net.Uri
import android.view.View
import android.webkit.*
import com.fly.core.base.bindbase.BaseBindActivity
import com.fly.core.databinding.ActivityWebBinding

class WebActivity : BaseBindActivity<ActivityWebBinding>() {

    companion object {
        fun startActivity(context: Context, url: String) {
            val intent = Intent(context, WebActivity::class.java)
            intent.putExtra("url", url)
            context.startActivity(intent)
        }
    }

    override fun createBinding(): ActivityWebBinding {
        val binding = ActivityWebBinding.inflate(layoutInflater)
        binding.owner = this
        return binding
    }

    override fun initView() {
        initWebSetting()
        mViewDataBinding.flBack.setOnClickListener { finish() }
        val url = intent.getStringExtra("url")
        mViewDataBinding.webView.loadUrl(url)
    }

    private fun initWebSetting() {

        val webSettings = mViewDataBinding.webView.settings
        webSettings.cacheMode = WebSettings.LOAD_CACHE_ELSE_NETWORK //加载缓存否则网络
        webSettings.loadsImagesAutomatically = true //图片自动缩放 打开
        webSettings.mixedContentMode = WebSettings.MIXED_CONTENT_ALWAYS_ALLOW
        mViewDataBinding.webView.setLayerType(View.LAYER_TYPE_SOFTWARE, null) //软件解码
        mViewDataBinding.webView.setLayerType(View.LAYER_TYPE_HARDWARE, null) //硬件解码
        webSettings.javaScriptEnabled = true // 设置支持javascript脚本
        webSettings.setSupportZoom(true) // 设置可以支持缩放
        webSettings.builtInZoomControls =
            false // 设置出现缩放工具 是否使用WebView内置的缩放组件，由浮动在窗口上的缩放控制和手势缩放控制组成，默认false
        webSettings.displayZoomControls = true //隐藏缩放工具
        webSettings.useWideViewPort = true // 扩大比例的缩放
        //自适应屏幕
        webSettings.layoutAlgorithm = WebSettings.LayoutAlgorithm.SINGLE_COLUMN
        webSettings.useWideViewPort = true
        webSettings.loadWithOverviewMode = true
        webSettings.databaseEnabled = true //
        webSettings.savePassword = true //保存密码
        webSettings.domStorageEnabled =
            true //是否开启本地DOM存储  鉴于它的安全特性（任何人都能读取到它，尽管有相应的限制，将敏感数据存储在这里依然不是明智之举），Android 默认是关闭该功能的。
        mViewDataBinding.webView.isSaveEnabled = true
        mViewDataBinding.webView.keepScreenOn = true

        // 设置setWebChromeClient对象
        val mInsideWebChromeClient = InsideWebChromeClient()
        mViewDataBinding.webView.webChromeClient = mInsideWebChromeClient
        //设置此方法可在WebView中打开链接，反之用浏览器打开
        mViewDataBinding.webView.webViewClient = InsideWebViewClient()
        mViewDataBinding.webView.setDownloadListener { paramAnonymousString1: String?, _: String?, _: String?, _: String?, _: Long ->
            val intent = Intent()
            intent.action = Intent.ACTION_VIEW
            intent.data = Uri.parse(paramAnonymousString1)
            startActivity(intent)
        }

    }

    override fun onConfigurationChanged(newConfig: Configuration) {
        try {
            super.onConfigurationChanged(newConfig)
        } catch (ex: Exception) {
        }
    }

    override fun onBackPressed() {
        if (mViewDataBinding.webView.canGoBack()) {
            mViewDataBinding.webView.goBack()
        } else {
            super.onBackPressed()
        }
    }

    private inner class InsideWebViewClient : WebViewClient() {
        override fun onPageFinished(view: WebView, url: String) {
            if (!mViewDataBinding.webView.settings.loadsImagesAutomatically) {
                mViewDataBinding.webView.settings.loadsImagesAutomatically = true
            }
            super.onPageFinished(view, url)
        }

        override fun shouldInterceptRequest(
            view: WebView,
            request: WebResourceRequest
        ): WebResourceResponse? {
            val uriAuthority = request.url.authority ?: ""
            return if (uriAuthority.contains("misssglobal")
                || uriAuthority.contains("yuyue008")
                || uriAuthority.contains("mendoc")
                || uriAuthority.contains("hanmenghui")
            ) {
                WebResourceResponse(null, null, null)
            } else {
                super.shouldInterceptRequest(view, request)
            }
        }

        override fun shouldOverrideUrlLoading(view: WebView, url: String): Boolean {
            if (url.startsWith("http:") || url.startsWith("https:")) {
                view.loadUrl(url)
                return false
            }
            // Otherwise allow the OS to handle things like tel, mailto, etc.
            try {
                val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
                startActivity(intent)
            } catch (e: Exception) {
                e.printStackTrace()
            }
            return true
        }
    }

    private inner class InsideWebChromeClient : WebChromeClient() {
        private var mCustomView: View? = null
        private var mCustomViewCallback: CustomViewCallback? = null

        override fun onReceivedTitle(view: WebView?, title: String?) {
            super.onReceivedTitle(view, title)
            mViewDataBinding.tvTitle.text = title
        }

        override fun onShowCustomView(view: View, callback: CustomViewCallback) {
            super.onShowCustomView(view, callback)
            if (mCustomView != null) {
                callback.onCustomViewHidden()
                return
            }
            mCustomView = view
            mViewDataBinding.mFrameLayout.addView(mCustomView)
            mCustomViewCallback = callback
            mViewDataBinding.webView.visibility = View.GONE
            requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_UNSPECIFIED
        }

        override fun onHideCustomView() {
            mViewDataBinding.webView.visibility = View.VISIBLE
            if (mCustomView == null) {
                return
            }
            mCustomView?.visibility = View.GONE
            mViewDataBinding.mFrameLayout.removeView(mCustomView)
            mCustomViewCallback?.onCustomViewHidden()
            mCustomView = null
            requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_UNSPECIFIED
            super.onHideCustomView()
        }
    }
}