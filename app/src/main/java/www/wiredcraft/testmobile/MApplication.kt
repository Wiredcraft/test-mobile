package www.wiredcraft.testmobile

import android.app.Application
import www.wiredcraft.testmobile.api.MApi

/**
 *@Description:
 * #
 * #0000      @Author: tianxiao     2022/3/30      onCreate
 */
class MApplication : Application() {

    companion object{
      lateinit var INITIALIZATION :MApplication
    }

    override fun onCreate() {
        super.onCreate()
        INITIALIZATION=this
        //初始化网络框架
        MApi.INITIALIZATION.init(this)
    }
}