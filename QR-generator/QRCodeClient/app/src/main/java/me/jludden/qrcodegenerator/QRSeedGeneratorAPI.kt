package me.jludden.qrcodegenerator

import io.reactivex.Observable
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.moshi.MoshiConverterFactory
import retrofit2.http.GET
import java.time.Instant

class QRSeedGeneratorAPI {

    data class SeedResult(val seed: String, val expiresAt: String)

    interface QRSeedGenAPI {

        @GET("/api/seed")
        fun getQRseed(): Observable<SeedResult>
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
}