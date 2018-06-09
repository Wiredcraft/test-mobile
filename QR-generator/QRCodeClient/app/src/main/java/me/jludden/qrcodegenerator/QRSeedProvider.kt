package me.jludden.qrcodegenerator

import dagger.Module
import dagger.Provides
import io.reactivex.Observable
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.moshi.MoshiConverterFactory
import retrofit2.http.GET
import javax.inject.Inject
import javax.inject.Singleton

//class the provides a seed value for generating a QR Code
@Singleton
class QRSeedProvider @Inject constructor(private var api: QRSeedGenAPI) {
    fun getQRSeed(): Observable<SeedResult> {
        return api.getSeedFromServer()
    }
}

//wrap the networking functions in a dagger module
@Module
class NetworkingModule {
    @Provides
    @Singleton
    fun apiService(retrofit: Retrofit): QRSeedGenAPI
            = retrofit.create(QRSeedGenAPI::class.java)

    @Provides
    @Singleton
    fun retrofit(): Retrofit = Retrofit.Builder()
            .addConverterFactory(MoshiConverterFactory.create())
            .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
            .baseUrl("http://qrcodeseedgenerator-dev.us-west-2.elasticbeanstalk.com")
            .build()
}

//define the API for accessing the QR code from the server
interface QRSeedGenAPI {
    @GET("/api/seed")
    fun getSeedFromServer(): Observable<SeedResult>
}

//class defining the structure of the return value
data class SeedResult(val seed: String, val expiresAt: String)
