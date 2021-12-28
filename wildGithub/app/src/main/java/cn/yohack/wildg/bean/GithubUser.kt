package cn.yohack.wildg.bean

import com.google.gson.annotations.SerializedName

/**
 * @Author yo_hack
 * @Date 2021.12.28
 * @Description github user
 **/
class GithubUser {

    /** user id **/
    val id: Long = 0

    /** login **/
    val login: String = ""

    /**  **/
    val score: String = ""

    /**  **/
    @SerializedName("avatar_url")
    val avatarUrl: String = ""

    /**  **/
    @SerializedName("html_url")
    val htmlUrl: String = ""
}