package www.wiredcraft.testmobile.api

import com.zhouyou.http.model.ApiResult


/**
 *@Description:
 * # 自定义 Result
 * #0000      @Author: tianxiao     2022/3/31      onCreate
 */
class CustomApiResult <T> : ApiResult<T>() {
    var reason: String? = null
    var total_count = 0
    var t: T? = null
    override fun setCode(code: Int) {
        super.setCode(0)
    }

    override fun setMsg(msg: String?) {
        super.setMsg("")
    }

    override fun setData(data: T) {
        super.setData(t)
    }

    override fun isOk(): Boolean {
        return true

    }
}