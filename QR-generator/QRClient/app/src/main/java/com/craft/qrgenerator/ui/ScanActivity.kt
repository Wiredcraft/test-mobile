package com.craft.qrgenerator.ui

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.graphics.Bitmap
import android.os.Build
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import com.craft.qrgenerator.R
import com.craft.qrgenerator.utils.PermissionManager
import com.uuzuche.lib_zxing.activity.CaptureFragment
import com.uuzuche.lib_zxing.activity.CodeUtils

class ScanActivity : AppCompatActivity() {

    companion object {
        const val REQUEST_CODE_ASK_PERMISSIONS = 123
    }

    private var mCallback: CodeUtils.AnalyzeCallback = object : CodeUtils.AnalyzeCallback {
        override fun onAnalyzeSuccess(mBitmap: Bitmap, result: String) {
            val resultIntent = Intent()
            val bundle = Bundle()
            bundle.putInt(CodeUtils.RESULT_TYPE, CodeUtils.RESULT_SUCCESS)
            bundle.putString(CodeUtils.RESULT_STRING, result)
            resultIntent.putExtras(bundle)
            setResult(Activity.RESULT_OK, resultIntent)
            finish()
        }

        override fun onAnalyzeFailed() {
            val resultIntent = Intent()
            val bundle = Bundle()
            bundle.putInt(CodeUtils.RESULT_TYPE, CodeUtils.RESULT_FAILED)
            bundle.putString(CodeUtils.RESULT_STRING, "failed")
            resultIntent.putExtras(bundle)
            setResult(Activity.RESULT_OK, resultIntent)
            finish()
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_scan)
        initCapture()
    }


    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String>, grantResults: IntArray) {
        if (requestCode == REQUEST_CODE_ASK_PERMISSIONS) {
            PermissionManager.onRequestPermissionsResult(this, grantResults)
        } else {
            super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        }
    }

    private fun initCapture() {
        val captureFragment = CaptureFragment()
        CodeUtils.setFragmentArgs(captureFragment, R.layout.scan_camera)
        captureFragment.analyzeCallback = mCallback
        supportFragmentManager.beginTransaction().replace(R.id.fl_my_container, captureFragment).commit()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            PermissionManager.checkPermission(this, Manifest.permission.CAMERA, REQUEST_CODE_ASK_PERMISSIONS)
        }
    }

}
