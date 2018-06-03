package me.jludden.qrcodegenerator

import com.journeyapps.barcodescanner.BarcodeEncoder
import io.reactivex.Observable

object Injection {

    @JvmStatic fun provideBarcodeEncoder() = BarcodeEncoder()

    @JvmStatic fun provideQRSeedGenerator() : QRSeedProvider {
        return FakeQRSeedGen()
    }

    class FakeQRSeedGen: QRSeedProvider{
        override fun getQRSeed(): Observable<SeedResult> = Observable.just(
                SeedResult("37790a1b728096b4141864f49159ad47", "1985-04-12T23:20:50.52Z")
        )
    }
}