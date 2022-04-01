package www.wiredcraft.testmobile.viewmodel


import android.util.Log
import androidx.databinding.ObservableArrayList
import cn.bingoogolapple.refreshlayout.BGARefreshLayout
import com.google.gson.reflect.TypeToken
import com.zhouyou.http.exception.ApiException
import kotlinx.coroutines.DelicateCoroutinesApi
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import www.wiredcraft.testmobile.adapter.UserAdapter
import www.wiredcraft.testmobile.api.MApi
import www.wiredcraft.testmobile.api.model.Item
import www.wiredcraft.testmobile.api.model.UserData
import www.wiredcraft.testmobile.base.BaseViewModel

/**
 *@Description:
 * #
 * #0000      @Author: tianxiao     2022/3/30      onCreate
 */
class MainViewModel : BaseViewModel(), BGARefreshLayout.BGARefreshLayoutDelegate {

    private val TAG = this.javaClass.simpleName
    var page = 1
    var id = "swift"
    val userlist = ObservableArrayList<Item>().apply {
        searche()
    }
    val userAdapter = UserAdapter(userlist)

    /**
     * 查询数据
     * @param oList
     */
    private fun searche(refreshLayout: BGARefreshLayout? = null) {
        MApi.INITIALIZATION.searchUsers(
            id, page, MApi.INITIALIZATION.link(
                object : MApi.MCallback {
                    override fun onError(e: ApiException?) {
                        Log.d(TAG, "$e")
                    }

                    override fun onSuccess(t: String?) {
                        refreshLayout?.endRefreshing()
                        refreshLayout?.endLoadingMore()
                        MApi.INITIALIZATION.gson.fromJson<UserData>(
                            t,
                            object : TypeToken<UserData>() {}.type
                        )?.let {
                            userlist.addAll(it.items)
                        }
                    }
                })
        )
    }

    /**
     * 根据名称搜索
     * @param text
     */
    fun onUsernameTextChanged(text: CharSequence?) {
        page = 1
        id = text.toString()
        text.toString()?.let {
            userlist.clear()
            if (it.isNotEmpty()) {
                searche()
            }
        }
    }

    override fun onBGARefreshLayoutBeginRefreshing(refreshLayout: BGARefreshLayout?) {
        page = 1
        userlist.clear()
        searche(refreshLayout)
    }

    override fun onBGARefreshLayoutBeginLoadingMore(refreshLayout: BGARefreshLayout?): Boolean {
        page++
        searche(refreshLayout)
        return true
    }

}