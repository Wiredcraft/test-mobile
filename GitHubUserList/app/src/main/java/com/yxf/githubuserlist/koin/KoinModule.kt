package com.yxf.githubuserlist.koin

import com.yxf.githubuserlist.api.GitHubService
import com.yxf.githubuserlist.config.Constant
import com.yxf.githubuserlist.module.userlist.UserDetailFragment
import com.yxf.githubuserlist.module.userlist.UserListFragment
import com.yxf.githubuserlist.module.userlist.UserListViewModel
import com.yxf.githubuserlist.repo.UserRepo
import com.yxf.mvvmcommon.http.interceptor.RetryInterceptor
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import org.koin.androidx.fragment.dsl.fragment
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.core.qualifier.named
import org.koin.dsl.module
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.converter.moshi.MoshiConverterFactory

val mainModule = module {


    single(named("github")) {
        OkHttpClient.Builder()
            .addInterceptor(RetryInterceptor())
            .addInterceptor(HttpLoggingInterceptor().apply {
                level = HttpLoggingInterceptor.Level.BODY
            })
            .build()
    }

    single(named("github")) {
        Retrofit.Builder()
            .baseUrl(Constant.GITHUB_API_HOST)
            .client(get(named("github")))
            //.addConverterFactory(GsonConverterFactory.create())
            .addConverterFactory(MoshiConverterFactory.create())
            .build()
    }

    single {
        get<Retrofit>(named("github")).create(GitHubService::class.java)
    }

}

val userListModule = module {

    single {
        UserRepo(get())
    }

    viewModel { UserListViewModel(get()) }

    fragment { UserListFragment() }

    fragment { UserDetailFragment() }
}