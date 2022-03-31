package xyz.mengxy.githubuserslist.di

import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import xyz.mengxy.githubuserslist.api.NetworkService
import javax.inject.Singleton

/**
 * Created by Mengxy on 3/29/22.
 * network module provide the Retrofit Api Service
 * @InstallIn can inject the dependency to [SingletonComponent]
 */
@InstallIn(SingletonComponent::class)
@Module
class NetworkModule {

    @Singleton
    @Provides
    fun provideNetworkService(): NetworkService {
        return NetworkService.create()
    }
}