package com.wiredcraft.mobileapp

import android.app.Application
import android.graphics.Color
import com.scwang.smart.refresh.footer.ClassicsFooter
import com.scwang.smart.refresh.header.ClassicsHeader
import com.scwang.smart.refresh.layout.SmartRefreshLayout

/**
 * createTime：2023/5/30
 * author：lhq
 * desc: the application
 *
 */
class App: Application() {

    override fun onCreate() {
        super.onCreate()
        initRefresh()
    }

    /**
     * init pull refresh
     */
    private fun initRefresh() {
        SmartRefreshLayout.setDefaultRefreshHeaderCreator { context, layout ->
            layout.setPrimaryColorsId(R.color.white, R.color.purple_700) //全局设置主题颜色
            ClassicsHeader(context)
        }
        SmartRefreshLayout.setDefaultRefreshFooterCreator { context, layout ->
            ClassicsFooter(context).apply {
                setTextSizeTitle(13F)
                setAccentColor(Color.parseColor("#BBBBBB"))
                setArrowBitmap(null)
                setProgressBitmap(null)
                setProgressResource(0)
            }
        }
    }
}