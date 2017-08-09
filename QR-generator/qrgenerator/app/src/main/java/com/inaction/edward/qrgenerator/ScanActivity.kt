package com.inaction.edward.qrgenerator

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.v7.app.AlertDialog
import com.google.zxing.Result
import me.dm7.barcodescanner.zxing.ZXingScannerView

class ScanActivity : AppCompatActivity(), ZXingScannerView.ResultHandler {

    var scannerView: ZXingScannerView? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_scan)

        setupUi()
    }

    private fun setupUi() {
        scannerView = findViewById(R.id.scannerView)
        scannerView?.let {
            it.setResultHandler(this)
            it.setAutoFocus(true)
        }
    }

    override fun onResume() {
        super.onResume()
        scannerView?.startCamera()
    }

    override fun onPause() {
        super.onPause()
        scannerView?.stopCamera()
    }

    override fun handleResult(result: Result?) {
        result?.let {
            showResult(it.text)
        }
    }

    private fun showResult(message: String) {
        val alertDialog = AlertDialog.Builder(this)
                .setTitle(R.string.result_dialog_title)
                .setMessage(message)
                .setPositiveButton(R.string.result_dialog_copy) { _, _ ->
                    addClip(message)
                    toast(R.string.copy_to_clipboard_message)
                    finish()
                }
                .setNegativeButton(R.string.result_dialog_continue) { _, _ ->
                    scannerView?.resumeCameraPreview(this)
                }
        alertDialog.show()
    }

}
