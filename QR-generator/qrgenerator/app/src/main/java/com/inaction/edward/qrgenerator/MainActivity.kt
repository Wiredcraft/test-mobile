package com.inaction.edward.qrgenerator

import android.Manifest
import android.content.pm.PackageManager
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.v4.app.ActivityCompat
import android.support.v4.content.ContextCompat
import android.support.v7.app.AlertDialog
import com.getbase.floatingactionbutton.FloatingActionButton
import com.getbase.floatingactionbutton.FloatingActionsMenu

class MainActivity : AppCompatActivity() {

    companion object {
        const val CAMERA_PERMISSION_REQUEST_CODE = 2333
    }

    var fabMenu: FloatingActionsMenu? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        setupFabMenu()
    }

    private fun setupFabMenu() {
        fabMenu = findViewById(R.id.fabMenu)

        val scanFab: FloatingActionButton? = findViewById(R.id.scanFab)
        scanFab?.size = FloatingActionButton.SIZE_MINI
        scanFab?.setOnClickListener {
            if (checkCameraPermission()) {
                toActivity(ScanActivity::class.java)
            } else {
                requestCameraPermission()
            }

            fabMenu?.collapse()
        }

        val generateFab: FloatingActionButton? = findViewById(R.id.generateFab)
        generateFab?.size = FloatingActionButton.SIZE_MINI
        generateFab?.setOnClickListener {
            toActivity(GeneratorActivity::class.java)
            fabMenu?.collapse()
        }
    }

    private fun checkCameraPermission(): Boolean {
        val result = ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA)
        return result == PackageManager.PERMISSION_GRANTED
    }

    private fun requestCameraPermission() {
        if (ActivityCompat.shouldShowRequestPermissionRationale(this,
                Manifest.permission.CAMERA)) {
            val alertDialog = AlertDialog.Builder(this)
                    .setTitle(R.string.ask_permission_dialog_title)
                    .setMessage(R.string.ask_permission_dialog_message)
                    .setPositiveButton(R.string.ask_permission_dialog_grant) { _, _ ->
                        requestCameraPermissionInner()
                    }
                    .setNegativeButton(R.string.ask_permission_dialog_reject) { _, _ ->
                        toast(R.string.permission_reject_message)
                    }

            alertDialog.show()
        } else {
            requestCameraPermissionInner()
        }

    }

    private fun requestCameraPermissionInner() {
        ActivityCompat.requestPermissions(this,
                arrayOf(Manifest.permission.CAMERA),
                CAMERA_PERMISSION_REQUEST_CODE)
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        when (requestCode) {
            CAMERA_PERMISSION_REQUEST_CODE -> {
                val cameraIndex = permissions.indexOf(Manifest.permission.CAMERA)
                if (grantResults[cameraIndex] == PackageManager.PERMISSION_GRANTED) {
                    toActivity(ScanActivity::class.java)
                } else {
                    toast(R.string.permission_reject_message)
                }
            }
        }
    }

}
