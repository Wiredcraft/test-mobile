package com.wiredcraft.demo.repository

import com.wiredcraft.demo.network.RetrofitManager
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ApplicationComponent
import javax.inject.Singleton

@Module
@InstallIn(ApplicationComponent::class)
class RepositoryModule {

    @Provides
    @Singleton
    fun provideAccountApiService(): UserApiService {
        return RetrofitManager.create(UserApiService::class.java)
    }
}