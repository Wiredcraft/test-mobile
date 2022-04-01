package www.wiredcraft.testmobile.api

import android.app.Application
import com.google.gson.Gson
import com.zhouyou.http.EasyHttp
import com.zhouyou.http.callback.CallBackProxy
import com.zhouyou.http.callback.SimpleCallBack
import com.zhouyou.http.exception.ApiException


/**
 *@Description:
 * # 网络请求
 * #0000      @Author: tianxiao     2022/3/31      onCreate
 */
class MApi {

    companion object {
        val INITIALIZATION = MApi()
        const val BASE_URIL = "https://api.github.com"
    }

    val gson = Gson()

    fun init(context: Application) {
        EasyHttp.init(context)
        EasyHttp.getInstance().setBaseUrl(BASE_URIL)
            //如果使用默认的60秒,以下三行也不需要设置
            .setReadTimeOut(60 * 1000)
            .setWriteTimeOut(60 * 100)
            .setConnectTimeout(60 * 100)
            .debug(MApi.javaClass.simpleName, true)

    }

    /**
     * https://api.github.com/search/users?q=swift&page=1
     * @param id  用户id
     * @param page
     * @param callBack
     */
    fun searchUsers(
        id: String,
        page: Int,
        callBack: CallBackProxy<CustomApiResult<String>, String>
    ) {
        EasyHttp.get(ApiConstant.SEARCH_USERS)
            .params("q", id)
            .params("page", page.toString())
            .execute(callBack)

    }

    /**
     * https://api.github.com/users/swift/repos
     * @param id
     * @param callBack
     */
    fun repos(
        id :String,
        callBack: CallBackProxy<CustomApiResult<String>, String>
    ){
        EasyHttp.get(String.format(ApiConstant.REPOS,id))
            .execute(callBack)
    }

    /**
     * 网络请求简化
     *
     * @param callBack 回调
     */
    fun  link( callBack: MCallback?): CallBackProxy<CustomApiResult<String>, String> {
        return object :
            CallBackProxy<CustomApiResult<String>, String>(

                object :
                    SimpleCallBack<String>() {
                    override fun onError(e: ApiException?) {
                        callBack?.onError(e)
                    }

                    override fun onSuccess(t:String? ) {
                        callBack?.onSuccess(t)
                    }

                }
            ) {}
    }


    /**
     * 回调接口
     */
    interface MCallback {
        fun onError(e: ApiException?)
        fun onSuccess(t: String?)
    }
}