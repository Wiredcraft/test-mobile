package cn.yohack.wildg.utils

import android.webkit.WebSettings
import android.webkit.WebView
import android.webkit.WebViewClient

/**
 * @Author yo_hack
 * @Date 2021.12.29
 * @Description
 **/


fun setDefaultWebSettings(webView: WebView?, client: WebViewClient = WebViewClient()) {
    if (webView == null) {
        return
    }
    val webSettings = webView.settings
    //5.0以上开启混合模式加载
    webSettings.mixedContentMode = WebSettings.MIXED_CONTENT_ALWAYS_ALLOW
    webSettings.loadWithOverviewMode = true
    webSettings.useWideViewPort = true
    //允许js代码
    webSettings.javaScriptEnabled = true
    webSettings.javaScriptCanOpenWindowsAutomatically = true
    //允许SessionStorage/LocalStorage存储
    webSettings.domStorageEnabled = true
    //禁用放缩
    webSettings.displayZoomControls = false
    webSettings.builtInZoomControls = false
    //禁用文字缩放
    webSettings.textZoom = 100
    webSettings.cacheMode = WebSettings.LOAD_DEFAULT
    //允许WebView使用File协议
    webSettings.allowFileAccess = true
    //设置UA
    webSettings.userAgentString += " plat=Android"
    //自动加载图片
    webSettings.loadsImagesAutomatically = true


    webSettings.blockNetworkImage = false

    webView.webViewClient = client
}