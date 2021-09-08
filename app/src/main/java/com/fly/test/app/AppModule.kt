package com.fly.test.app

import com.fly.core.network.RetrofitClient
import com.fly.test.api.UserApi
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ApplicationComponent
import javax.inject.Singleton

@Module
@InstallIn(ApplicationComponent::class)
class AppModule {

    @Provides
    @Singleton
    fun provideUserApi(): UserApi {
        return RetrofitClient.create(UserApi::class.java)
    }
}