package me.jludden.qrcodegenerator

import io.reactivex.Observable
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.moshi.MoshiConverterFactory
import retrofit2.http.GET

//class defining the structure of the return value
data class SeedResult(val seed: String, val expiresAt: String)

//interface to use - actual implementation to be injected
interface QRSeedProvider {
    fun getQRSeed(): Observable<SeedResult>
}

//define the API for accessing the QR code from the server
interface QRSeedGenAPI {

    @GET("/api/seed")
    fun getSeedFromServer(): Observable<SeedResult>

    companion object {
        fun create(): QRSeedGenAPI {
            val retrofit = Retrofit.Builder()
                    .addConverterFactory(MoshiConverterFactory.create())
                    .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
                    .baseUrl("http://qrcodeseedgenerator-dev.us-west-2.elasticbeanstalk.com")
                    .build()

            return retrofit.create(QRSeedGenAPI::class.java)
        }
    }
}
