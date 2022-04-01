package www.wiredcraft.testmobile.viewmodel

import android.util.Log
import androidx.databinding.ObservableArrayList
import androidx.databinding.ObservableField
import com.blankj.utilcode.util.ToastUtils
import com.google.gson.reflect.TypeToken
import com.zhouyou.http.exception.ApiException
import www.wiredcraft.testmobile.api.MApi
import www.wiredcraft.testmobile.api.model.Item
import www.wiredcraft.testmobile.api.model.ReposData
import www.wiredcraft.testmobile.base.BaseViewModel

/**
 *@Description:
 * #
 * #0000      @Author: tianxiao     2022/3/31      onCreate
 */
class UserDetailsViewModel : BaseViewModel() {

    private val TAG = this.javaClass.simpleName
    val reposlist = ObservableArrayList<ReposData>()
    val userData = ObservableField<Item>()

    /**
     * 查询用户
     * @param name 用户名
     */
    fun searcheRepos(name:String){
        MApi.INITIALIZATION.repos(name,
            MApi.INITIALIZATION.link(
                object : MApi.MCallback {
                    override fun onError(e: ApiException?) {
                        Log.d(TAG, "$e")
                        ToastUtils.showLong(e?.message)
                    }

                    override fun onSuccess(t: String?) {
                        MApi.INITIALIZATION.gson.fromJson<List<ReposData>>(
                            t,
                            object : TypeToken<List<ReposData>>() {}.type
                        )?.let {
                            reposlist.addAll(it)
                        }
                    }
                })
        )

    }
}