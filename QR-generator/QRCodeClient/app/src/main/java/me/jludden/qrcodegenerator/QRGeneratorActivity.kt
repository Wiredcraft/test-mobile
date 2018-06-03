package me.jludden.qrcodegenerator

import android.databinding.BindingAdapter
import android.databinding.DataBindingUtil
import android.graphics.Bitmap
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.widget.ImageView
import com.google.zxing.BarcodeFormat
import com.journeyapps.barcodescanner.BarcodeEncoder
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.Disposable
import io.reactivex.schedulers.Schedulers
import me.jludden.qrcodegenerator.databinding.ActivityQrgeneratorBinding


//Main data binding model
data class QRCode(val bitmap: Bitmap, val text: String)

//Data binding adapter to load a bitmap into ImageView
@BindingAdapter("android:src")
fun setImageBitmap(view: ImageView, image : Bitmap?) {
    view.setImageBitmap(image)
}

//Activity that shows a QR Code
class QRGeneratorActivity : AppCompatActivity() {

    private lateinit var binding: ActivityQrgeneratorBinding
    private var disposable: Disposable? = null //hold a reference so we can GC
    private val seedAPI : QRSeedProvider by lazy { //Seed Generation API
        Injection.provideQRSeedGenerator()
    }
    private val barcodeEncoder by lazy { //Barcode Image Generation API
        Injection.provideBarcodeEncoder()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = DataBindingUtil.setContentView(this, R.layout.activity_qrgenerator)
        supportActionBar?.setDisplayHomeAsUpEnabled(true)
        startQRSeedRequest()
    }

    //Being operation to get QR code seed from server
    private fun startQRSeedRequest() {
        binding.isLoading = true
        disposable = seedAPI.getQRSeed()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(
                        {result -> onQRRequestResult(result.seed)},
                        {error -> onQRRequestTimeout()}
                )
    }

    //Operation successful, display QR code
    private fun onQRRequestResult(code: String) {
        binding.isLoading = false
        try {
            val bitmap = barcodeEncoder.encodeBitmap(code, BarcodeFormat.QR_CODE, 400, 400)
            binding.qrCode = QRCode(bitmap, code)
        } catch (e: Exception) { }
    }

    //Notify user the operation failed
    private fun onQRRequestTimeout() {
        binding.isLoading = false
    }

    override fun onPause() {
        super.onPause()
        disposable?.dispose()
    }
}
