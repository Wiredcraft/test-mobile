package com.wiredcraft.demo.ui.detail

import android.net.http.SslError
import android.webkit.SslErrorHandler
import android.webkit.WebChromeClient
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.databinding.ObservableField
import com.wiredcraft.demo.base.BaseViewModel
import javax.inject.Inject

class UserDetailViewModel @Inject constructor() : BaseViewModel() {

    val htmlUrl = ObservableField<String>()

    val webViewClient = object : WebViewClient() {
        override fun onReceivedSslError(
            view: WebView?,
            handler: SslErrorHandler?,
            error: SslError?
        ) {
            handler?.proceed()
        }
    }
    val webChromeClient = object : WebChromeClient() {

    }

    companion object {
        const val PAGE_DATA = "PAGE_DATA"
    }

    override fun onCreate() {
        super.onCreate()
        htmlUrl.set(arguments(PAGE_DATA))
    }
}