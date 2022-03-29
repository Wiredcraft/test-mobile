package xyz.mengxy.githubuserslist.model

/**
 * Created by Mengxy on 3/29/22.
 */
interface InfoPresenter {

    fun isUserInfo(): Boolean

    fun getAvatarUrl(): String

    fun getName(): String

    fun getScore(): String

    fun getUrl(): String
}