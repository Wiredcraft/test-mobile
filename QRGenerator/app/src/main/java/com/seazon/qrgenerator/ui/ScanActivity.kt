package com.seazon.qrgenerator.ui

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.graphics.Bitmap
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import com.seazon.qrgenerator.R
import com.seazon.qrgenerator.utils.PermissionUtils
import com.uuzuche.lib_zxing.activity.CaptureFragment
import com.uuzuche.lib_zxing.activity.CodeUtils
import kotlinx.android.synthetic.main.activity_main.*

/**
 * Created by seazon on 2018/3/7.
 */
class ScanActivity : AppCompatActivity() {

    private val REQUEST_CODE_ASK_PERMISSIONS = 123

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_scan)
        setSupportActionBar(toolbar)

        // init capture
        val captureFragment = CaptureFragment()
        CodeUtils.setFragmentArgs(captureFragment, R.layout.my_camera)
        captureFragment.analyzeCallback = analyzeCallback
        supportFragmentManager.beginTransaction().replace(R.id.fl_my_container, captureFragment).commit()

        PermissionUtils.checkPermission(this, Manifest.permission.CAMERA, REQUEST_CODE_ASK_PERMISSIONS)
    }

    var analyzeCallback: CodeUtils.AnalyzeCallback = object : CodeUtils.AnalyzeCallback {
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
            bundle.putString(CodeUtils.RESULT_STRING, "")
            resultIntent.putExtras(bundle)
            setResult(Activity.RESULT_OK, resultIntent)
            finish()
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String>, grantResults: IntArray) {
        if (requestCode == REQUEST_CODE_ASK_PERMISSIONS) {
            PermissionUtils.onRequestPermissionsResult(this, grantResults)
        } else {
            super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        }
    }

}