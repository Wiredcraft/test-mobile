package me.jludden.qrcodegenerator

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import kotlinx.android.synthetic.main.activity_qrgenerator.*
import android.view.View
import com.google.zxing.BarcodeFormat
import com.journeyapps.barcodescanner.BarcodeEncoder
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.Disposable
import io.reactivex.schedulers.Schedulers


class QRGeneratorActivity : AppCompatActivity() {

    private var disposable: Disposable? = null //hold a reference so we can GC
    private val seedAPI : QRSeedProvider by lazy { //Seed Generation API
        Injection.provideQRSeedGenerator()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_qrgenerator)
        supportActionBar?.setDisplayHomeAsUpEnabled(true)
        startQRSeedRequest()
    }

    //Being operation to get QR code seed from server
    private fun startQRSeedRequest() {
        disposable =  seedAPI.getQRSeed()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(
                        {result -> onQRRequestResult(result.seed)},
                        {error -> onQRRequestTimeout()}
                )
    }

    //Operation successful, display QR code
    private fun onQRRequestResult(code: String) {
        qr_code_loading.visibility = View.GONE
        try {
            val barcodeEncoder = BarcodeEncoder()
            val bitmap = barcodeEncoder.encodeBitmap(code, BarcodeFormat.QR_CODE, 400, 400)
            qr_code_image.setImageBitmap(bitmap)
            qr_code_text.text = code

        } catch (e: Exception) {
            qr_code_text.text = getString(R.string.qr_gen_error)
        }
    }

    //Notify user the operation failed
    private fun onQRRequestTimeout() {
        qr_code_loading.visibility = View.GONE
        qr_code_text.text = getString(R.string.qr_request_timeout)
    }

    override fun onPause() {
        super.onPause()
        disposable?.dispose()
    }
}
