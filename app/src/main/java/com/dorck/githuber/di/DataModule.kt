package com.dorck.githuber.di

import com.dorck.githuber.data.DefaultGithubRepository
import com.dorck.githuber.data.GithubDataRepository
import com.dorck.githuber.data.source.local.GithubLocalDataSource
import com.dorck.githuber.data.source.local.LocalDataSource
import com.dorck.githuber.data.source.remote.GithubRemoteDataSource
import com.dorck.githuber.data.source.remote.NetworkDataSource
import dagger.Binds
import dagger.Module
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
abstract class DataModule {

    @Singleton
    @Binds
    abstract fun bindLocalDataSource(dataSource: GithubLocalDataSource): LocalDataSource

    @Singleton
    @Binds
    abstract fun bindRemoteDataSource(dataSource: GithubRemoteDataSource): NetworkDataSource

    @Singleton
    @Binds
    abstract fun bindRepository(repository: DefaultGithubRepository): GithubDataRepository
}