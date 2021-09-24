package com.yxf.githubuserlist.app

import com.yxf.githubuserlist.koin.mainModule
import com.yxf.githubuserlist.koin.userListModule
import com.yxf.mvvmcommon.app.CommonApplication
import org.koin.core.module.Module

class GitHubApplication : CommonApplication() {


    override fun getKoinModules(): List<Module> {
        return listOf(mainModule, userListModule)
    }


}