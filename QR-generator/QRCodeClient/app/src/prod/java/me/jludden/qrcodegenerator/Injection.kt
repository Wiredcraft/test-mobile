package me.jludden.qrcodegenerator

import com.journeyapps.barcodescanner.BarcodeEncoder
import io.reactivex.Observable

object Injection {

    @JvmStatic fun provideBarcodeEncoder() = BarcodeEncoder()

    @JvmStatic fun provideQRSeedGenerator() : QRSeedProvider {
        return QRSeedGenImpl(QRSeedGenAPI.create())
    }

    class QRSeedGenImpl(private val api: QRSeedGenAPI) : QRSeedProvider {
        override fun getQRSeed(): Observable<SeedResult> = api.getSeedFromServer()
    }
}