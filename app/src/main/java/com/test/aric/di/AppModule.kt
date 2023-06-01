package com.test.aric.di

import com.test.aric.common.Constants
import com.test.aric.data.remote.GithubApi
import com.test.aric.data.repository.GithubRepositoryImpl
import com.test.aric.domain.repository.GithubRepository
import com.pluto.plugins.network.PlutoInterceptor
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object AppModule {

    @Provides
    @Singleton
    fun provideOkHttpClient(): OkHttpClient {
        return OkHttpClient.Builder().addInterceptor(PlutoInterceptor())
            .addInterceptor(HttpLoggingInterceptor().apply { setLevel(HttpLoggingInterceptor.Level.BODY) })
            .build()
    }


    @Provides
    @Singleton
    fun provideGithubApi(okHttpClient: OkHttpClient): GithubApi {
        return Retrofit.Builder()
            .client(okHttpClient)
            .baseUrl(Constants.GITHUB_BASE_URL)
            .addConverterFactory(GsonConverterFactory.create())
            .build()
            .create(GithubApi::class.java)
    }

    @Provides
    @Singleton
    fun provideGithubRepository(api: GithubApi): GithubRepository {
        return GithubRepositoryImpl(api)
    }
}