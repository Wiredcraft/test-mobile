package cn.yohack.wildg.view

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.webkit.WebChromeClient
import android.webkit.WebView
import android.widget.FrameLayout
import androidx.core.view.isVisible
import cn.yohack.wildg.databinding.ViewGWebviewBinding
import cn.yohack.wildg.utils.setDefaultWebSettings

/**
 * @Author yo_hack
 * @Date 2021.12.29
 * @Description webview
 **/
class GWebView @JvmOverloads constructor(
    context: Context, attrs: AttributeSet? = null, deStyleAttr: Int = 0,
) : FrameLayout(context, attrs, deStyleAttr) {
    /**
     * binding
     */
    private var binding: ViewGWebviewBinding =
        ViewGWebviewBinding.inflate(LayoutInflater.from(context), this, true)

    /**
     * first show loading
     */
    private var hasHidden = false

    init {
        setDefaultWebSettings(binding.webView)
        binding.webView.webChromeClient = object : WebChromeClient() {
            override fun onProgressChanged(view: WebView?, newProgress: Int) {
                showContent(newProgress > 85)
            }
        }
    }

    private fun showContent(flag: Boolean) {
        if (!hasHidden) {
            binding.webView.isVisible = flag
            binding.progress.isVisible = !flag
        }
        hasHidden = hasHidden or flag
    }

    fun getWebView() = binding.webView

    fun destroy() {
        binding.webView.destroy()
        removeAllViews()
    }

    override fun onDetachedFromWindow() {
        binding.webView.destroy()
        super.onDetachedFromWindow()
    }
}