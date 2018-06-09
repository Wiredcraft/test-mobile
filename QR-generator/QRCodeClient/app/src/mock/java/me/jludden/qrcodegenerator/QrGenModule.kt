package me.jludden.qrcodegenerator

import com.journeyapps.barcodescanner.BarcodeEncoder
import dagger.Module
import dagger.Provides
import io.reactivex.Observable
import javax.inject.Singleton

@Module(includes = [NetworkingModule::class])
class QrGenModule {
    @Singleton
    @Provides
    fun provideBarcodeEncoder() = BarcodeEncoder()

    @Singleton
    @Provides
    fun provideQRSeedGenerator() : QRSeedProvider {
        return QRSeedProvider(FakeQRSeedAPI())
    }
}

class FakeQRSeedAPI : QRSeedGenAPI {
    override fun getSeedFromServer(): Observable<SeedResult> = Observable.just(
        SeedResult("37790a1b728096b4141864f49159ad47", "1985-04-12T23:20:50.52Z")
    )
}