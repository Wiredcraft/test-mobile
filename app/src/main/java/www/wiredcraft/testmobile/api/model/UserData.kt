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
    var incomplete_results: Boolean ,
    var items: ArrayList<Item> = arrayListOf(),
    var total_count: Int = 0
)

data class Item(
    var avatar_url: String,
    var events_url: String,
    var followers_url: String,
    var following_url: String,
    var gists_url: String,
    var gravatar_id: String,
    var html_url: String,
    var id: Int,
    var login: String,
    var node_id: String,
    var organizations_url: String,
    var received_events_url: String,
    var repos_url: String,
    var score: Double,
    var site_admin: Boolean,
    var starred_url: String,
    var subscriptions_url: String,
    var type: String,
    var url: String,
) {
    companion object {
        var followText = MApplication.INITIALIZATION.getString(R.string.follow)
        var noFollowText = MApplication.INITIALIZATION.getString(R.string.no_follow)
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