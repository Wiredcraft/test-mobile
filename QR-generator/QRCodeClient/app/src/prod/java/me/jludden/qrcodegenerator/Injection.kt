package me.jludden.qrcodegenerator

import io.reactivex.Observable

object Injection {

    @JvmStatic fun provideQRSeedGenerator() : QRSeedProvider {
        return QRSeedGenImpl(QRSeedGenAPI.create())
    }

    class QRSeedGenImpl(private val api: QRSeedGenAPI) : QRSeedProvider {
        override fun getQRSeed(): Observable<SeedResult> = api.getSeedFromServer()
    }
}