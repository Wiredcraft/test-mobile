package www.wiredcraft.testmobile.api.model

import android.view.View
import android.widget.TextView
import com.blankj.utilcode.util.SPUtils
import www.wiredcraft.testmobile.MApplication
import www.wiredcraft.testmobile.R
import www.wiredcraft.testmobile.api.MApi

/**
 *@Description:
 * #
 * #0000      @Author: tianxiao     2022/3/31      onCreate
 */
data class UserData(
    val incomplete_results: Boolean = false,
    val items: ArrayList<Item> = arrayListOf(),
    val total_count: Int = 0
)

data class Item(
    val avatar_url: String,
    val events_url: String,
    val followers_url: String,
    val following_url: String,
    val gists_url: String,
    val gravatar_id: String,
    val html_url: String,
    val id: Int,
    val login: String,
    val node_id: String,
    val organizations_url: String,
    val received_events_url: String,
    val repos_url: String,
    val score: Double,
    val site_admin: Boolean,
    val starred_url: String,
    val subscriptions_url: String,
    val type: String,
    val url: String,
) {
    companion object {
        val followText = MApplication.INITIALIZATION.getString(R.string.follow)
        val noFollowText = MApplication.INITIALIZATION.getString(R.string.no_follow)
    }

    fun getFollowStats(): String {
        SPUtils.getInstance().getString(
            "$id", ""
        )?.let {
            if (it.isNotEmpty()){
                return noFollowText
            }
        }
        return followText
    }

    fun followUser(v: View) {
        val textView = v as TextView
        SPUtils.getInstance().getString(
            "$id", followText
        )?.let {
            if (it == followText) {
                SPUtils.getInstance().put("$id", MApi.INITIALIZATION.gson.toJson(this))
                textView.text = noFollowText
            } else {
                SPUtils.getInstance().remove("$id")
                textView.text = followText
            }
        }
    }
}