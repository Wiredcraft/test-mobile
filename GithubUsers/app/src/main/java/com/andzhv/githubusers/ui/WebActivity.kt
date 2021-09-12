package com.andzhv.githubusers.ui

import android.content.Context
import android.graphics.*
import android.os.Bundle
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.core.content.ContextCompat
import androidx.webkit.WebSettingsCompat
import androidx.webkit.WebViewFeature
import com.andzhv.githubusers.R
import com.andzhv.githubusers.databinding.ActivityWebBinding
import com.andzhv.githubusers.ui.base.EmptyActivity
import com.andzhv.githubusers.utils.ex.isDarkMode
import com.andzhv.githubusers.utils.ex.showFailedToast
import org.jetbrains.anko.startActivity

/**
 * Created by zhaowei on 2021/9/12.
 */

class WebActivity : EmptyActivity() {

    companion object {

        private const val DATA_URL = "DATA_URL"

        fun start(context: Context, url: String) {
            val uppercase = url.uppercase()
            if (uppercase.startsWith("HTTP://") || uppercase.startsWith("HTTPS://")) {
                context.startActivity<WebActivity>(DATA_URL to url)
            } else {
                showFailedToast(context.getString(R.string.url_error))
            }
        }
    }

    override val layoutId: Int = R.layout.activity_web

    private val binding: ActivityWebBinding by generateViewBinding { ActivityWebBinding.bind(it) }

    override fun initView(savedInstanceState: Bundle?) {
        super.initView(savedInstanceState)
        with(binding.toolbar) {
            setSupportActionBar(this)
            setNavigationIcon(R.mipmap.round_close_black_24)
            setNavigationOnClickListener { finish() }
            navigationIcon?.colorFilter = PorterDuffColorFilter(
                ContextCompat.getColor(this@WebActivity, R.color.textPrimary),
                PorterDuff.Mode.SRC_IN
            )
        }
        supportActionBar?.title = ""

        with(binding.webView.settings) {
            useWideViewPort = true
            if (WebViewFeature.isFeatureSupported(WebViewFeature.FORCE_DARK)) {
                WebSettingsCompat.setForceDark(
                    this,
                    if (isDarkMode) WebSettingsCompat.FORCE_DARK_ON else WebSettingsCompat.FORCE_DARK_OFF
                )
            }
        }
        with(binding.refreshLayout) {
            setColorSchemeResources(R.color.textPrimary)
            setProgressBackgroundColorSchemeResource(R.color.refreshBackgroundColor)
        }
    }

    override fun initBinding() {
        super.initBinding()
        binding.webView.webViewClient = object : WebViewClient() {
            override fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?) {
                super.onPageStarted(view, url, favicon)
                binding.refreshLayout.isRefreshing = true
            }

            override fun onPageFinished(view: WebView?, url: String?) {
                super.onPageFinished(view, url)
                binding.refreshLayout.isRefreshing = false
            }
        }
        val url = intent.getStringExtra(DATA_URL) ?: ""
        binding.webView.loadUrl(url)
        binding.refreshLayout.setOnRefreshListener {
            binding.webView.reload()
        }
    }

    override fun onBackPressed() {
        if (binding.webView.canGoBack()) {
            binding.webView.goBack()
        } else {
            super.onBackPressed()
        }
    }
}