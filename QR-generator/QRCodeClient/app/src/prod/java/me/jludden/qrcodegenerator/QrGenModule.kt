package me.jludden.qrcodegenerator

import com.journeyapps.barcodescanner.BarcodeEncoder
import dagger.Module
import dagger.Provides
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.moshi.MoshiConverterFactory
import javax.inject.Singleton

@Module(includes = [NetworkingModule::class])
class QrGenModule {
    @Singleton
    @Provides
    fun provideBarcodeEncoder() = BarcodeEncoder()

    @Singleton
    @Provides
    fun provideQRSeedGenerator() : QRSeedProvider {
        val net = NetworkingModule()
        return QRSeedProvider(net.apiService(net.retrofit()))
    }
}