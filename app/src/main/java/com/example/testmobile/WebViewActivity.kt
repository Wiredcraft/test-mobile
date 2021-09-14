package com.example.testmobile

import android.graphics.Bitmap
import android.os.Bundle
import android.view.View
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.appcompat.app.AppCompatActivity
import com.example.testmobile.databinding.ActivityWebviewBinding
import com.example.testmobile.model.GithubUser

class WebViewActivity : AppCompatActivity() {

    private lateinit var binding: ActivityWebviewBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityWebviewBinding.inflate(layoutInflater)
        binding.lifecycleOwner = this
        setContentView(binding.root)

        val user = intent.getParcelableExtra<GithubUser>("user")

        binding.vActionBar.ivBack.setOnClickListener {
            finish()
        }
        binding.vActionBar.tvTitle.text = user?.name

        setLoadUrl(user?.htmlUrl)
    }

    private fun setLoadUrl(url: String?) {
        binding.webView.webViewClient = object : WebViewClient() {
            override fun onPageStarted(view: WebView, url: String, favicon: Bitmap?) {
                binding.progressBar.visibility = View.VISIBLE
            }

            override fun shouldOverrideUrlLoading(view: WebView, url: String): Boolean {
                view.loadUrl(url)
                return true
            }

            override fun onPageFinished(view: WebView, url: String) {
                binding.progressBar.visibility = View.GONE
            }

            override fun onReceivedError(
                view: WebView,
                errorCode: Int,
                description: String,
                failingUrl: String
            ) {
                binding.progressBar.visibility = View.GONE
            }
        }
        binding.webView.clearCache(true)
        binding.webView.clearHistory()
        binding.webView.settings.javaScriptCanOpenWindowsAutomatically = true
        binding.webView.loadUrl(url ?: "")
    }

}