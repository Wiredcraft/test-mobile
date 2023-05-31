package com.wiredcraft.mobileapp.data

import com.wiredcraft.mobileapp.bean.RepositoryBean
import com.wiredcraft.mobileapp.bean.UserBean

/**
 * createTime：2023/5/30
 * author：lhq
 * desc:
 *
 */


/**
 * createTime：2023/5/27
 * author：lhq
 * desc: data is for test
 *
 */


val exampleUser = UserBean(1,"","Jack", "http://www.a.b", 100, true)

val usersData = arrayListOf(
    exampleUser,
    UserBean(2,"","Tom", "http://www.a.b", 20, true),
    UserBean(3,"","Marry", "http://www.a.com", 10000, true),
    UserBean(4,"","Bob", "http://www.a.net", 30, false),
    UserBean(5,"","Ali", "http://www.a.cccc", 100, true),
    UserBean(6,"","Jerry", "http://www.aaaa.b", 199, false)
)

val userRepositoriesData = arrayListOf(
    RepositoryBean(1, "Java", "", 100, "http://www.github.com"),
    RepositoryBean(2, "Android", "", 10, "http://www.github.com"),
    RepositoryBean(3, "Go", "", 100, "http://www.github.com"),
    RepositoryBean(4, "FFmpeg", "", 222, "http://www.github.com"),
    RepositoryBean(5, "Kotlin", "", 3444, "http://www.github.com"),
    RepositoryBean(6, "Java", "", 1, "http://www.github.com"),
    RepositoryBean(7, "Html", "", 9999999, "http://www.github.com"),
    RepositoryBean(8, "Css", "", 333322, "http://www.github.com"),
    RepositoryBean(9, "C", "", 5544, "http://www.github.com"),
    RepositoryBean(10, "C++", "", 133, "http://www.github.com"),
    RepositoryBean(11, "C#", "", 2442, "http://www.github.com"),
)
