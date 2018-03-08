package com.seazon.qrgenerator.ui

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.support.design.widget.Snackbar
import android.support.v7.app.AppCompatActivity
import android.widget.Toast
import com.seazon.qrgenerator.R
import com.uuzuche.lib_zxing.activity.CodeUtils
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.fab_submenu.*

/**
 * Created by seazon on 2018/3/7.
 */
class MainActivity : AppCompatActivity() {

    val REQUEST_CODE_SCAN = 1001;

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setSupportActionBar(toolbar)

        fab.setOnClickListener { view ->
            Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
                    .setAction("Action", null).show()
        }
        fabGenerate.setOnClickListener({
            val intent = Intent(this, GenerateActivity::class.java)
            startActivity(intent)
        })
        fabScan.setOnClickListener({
            val intent = Intent(this, ScanActivity::class.java)
            startActivityForResult(intent, REQUEST_CODE_SCAN)
        })
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_CODE_SCAN) {

            if (resultCode != Activity.RESULT_OK) {
                return
            }

            if (data == null) {
                Toast.makeText(this, R.string.scan_failed, Toast.LENGTH_LONG).show()
                return
            }

            val resultType = data.getIntExtra(CodeUtils.RESULT_TYPE, CodeUtils.RESULT_FAILED)
            if (resultType == CodeUtils.RESULT_SUCCESS) {
                val resultString = data.getStringExtra(CodeUtils.RESULT_STRING)
                Toast.makeText(this, resultString, Toast.LENGTH_LONG).show()
            } else {
                Toast.makeText(this, R.string.scan_failed, Toast.LENGTH_LONG).show()
            }
        }
    }

}
