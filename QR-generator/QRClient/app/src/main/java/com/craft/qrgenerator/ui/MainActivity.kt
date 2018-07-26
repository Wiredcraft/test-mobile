package com.craft.qrgenerator.ui

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.widget.Toast
import com.craft.qrgenerator.R
import com.craft.qrgenerator.move
import com.craft.qrgenerator.rotate
import com.uuzuche.lib_zxing.activity.CodeUtils
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    companion object {
        const val REQUEST_CODE_SCAN = 1001
    }

    private var mShowSubFab = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        initEvent()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_CODE_SCAN) {

            if (resultCode != Activity.RESULT_OK) {
                return
            }

            if (data != null) {
                val resultType = data.getIntExtra(CodeUtils.RESULT_TYPE, CodeUtils.RESULT_FAILED)

                if (resultType == CodeUtils.RESULT_SUCCESS) {
                    val resultString = data.getStringExtra(CodeUtils.RESULT_STRING)
                    Toast.makeText(this, resultString, Toast.LENGTH_LONG).show()
                } else {
                    Toast.makeText(this, R.string.scan_failed, Toast.LENGTH_LONG).show()
                }

            } else {
                Toast.makeText(this, R.string.scan_failed, Toast.LENGTH_LONG).show()
            }
        }
    }

    private fun initEvent() {
        fab.setOnClickListener { toggleSubFab() }
        fabGenerate.setOnClickListener({
            hideSubFab({
                val intent = Intent(this, QRGenerateActivity::class.java)
                startActivity(intent)
            })
        })
        fabScan.setOnClickListener({
            hideSubFab({
                val intent = Intent(this, ScanActivity::class.java)
                startActivityForResult(intent, REQUEST_CODE_SCAN)
            })
        })
    }

    private fun toggleSubFab() {
        if (mShowSubFab) {
            hideSubFab()
        } else {
            showSubFab()
        }
    }

    private fun showSubFab() {
        mShowSubFab = true
        fab.rotate(0f, 45f)
        fabGenerate.move(0f, resources.getDimension(R.dimen.fab_submenu_translation_y_generate), true)
        fabScan.move(0f, resources.getDimension(R.dimen.fab_submenu_translation_y_scan), true)
    }

    private fun hideSubFab(callback: () -> Unit = {}) {
        mShowSubFab = false
        fab.rotate(45f, 0f)
        fabGenerate.move(resources.getDimension(R.dimen.fab_submenu_translation_y_generate), 0f, false)
        fabScan.move(resources.getDimension(R.dimen.fab_submenu_translation_y_scan), 0f, false, callback)
    }

}
