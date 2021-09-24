package com.yxf.mvvmcommon.app

import android.app.Application
import android.content.Context
import org.koin.android.ext.koin.androidContext
import org.koin.android.ext.koin.androidLogger
import org.koin.androidx.fragment.koin.fragmentFactory
import org.koin.core.context.startKoin
import org.koin.core.module.Module
import org.koin.core.qualifier.named
import org.koin.dsl.module

open class CommonApplication : Application() {

    companion object {
        private lateinit var appContextInternal: Context

        private fun getAppContext(): Context {
            return appContextInternal
        }
    }

    private val defaultKoinModule = module {

        single(named("application")) {
            appContextInternal
        }

    }


    override fun onCreate() {
        super.onCreate()
        appContextInternal = this
        initKoin()
    }

    private fun initKoin() {
        startKoin {
            androidLogger()
            fragmentFactory()
            androidContext(this@CommonApplication)
            modules(ArrayList<Module>().apply {
                add(defaultKoinModule)
                addAll(getKoinModules())
            })
        }
    }

    open fun getKoinModules(): List<Module> {
        return emptyList()
    }


}