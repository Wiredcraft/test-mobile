package com.testmobile.githubuserslist.di

import com.testmobile.githubuserslist.api.UsersApi
import com.testmobile.githubuserslist.api.UsersApi.Companion.BASE_URL
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory


/**
 * App module that builds and provides the retroif Api service
 */
object AppModule {

    fun provideRetrofit(): Retrofit =
        Retrofit.Builder()
            .baseUrl(BASE_URL)
            .addConverterFactory(GsonConverterFactory.create())
            .build()

    fun provideUserApi(retrofit: Retrofit): UsersApi =
        retrofit.create(UsersApi::class.java)
}