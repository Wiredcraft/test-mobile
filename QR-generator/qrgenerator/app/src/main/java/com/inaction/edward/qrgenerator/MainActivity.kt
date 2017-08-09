package com.inaction.edward.qrgenerator

import android.Manifest
import android.content.pm.PackageManager
import android.os.AsyncTask
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.v4.app.ActivityCompat
import android.support.v4.content.ContextCompat
import android.support.v7.app.AlertDialog
import android.support.v7.widget.DividerItemDecoration
import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.RecyclerView
import android.view.View
import android.widget.TextView
import com.getbase.floatingactionbutton.FloatingActionButton
import com.getbase.floatingactionbutton.FloatingActionsMenu
import com.inaction.edward.qrgenerator.adapters.SeedAdapter
import com.inaction.edward.qrgenerator.asynctasks.LoadSeedListAsyncTask
import com.inaction.edward.qrgenerator.entities.Seed

class MainActivity : AppCompatActivity() {

    companion object {
        const val CAMERA_PERMISSION_REQUEST_CODE = 2333
    }

    var fabMenu: FloatingActionsMenu? = null
    var emptyTextView: TextView? = null
    var seedRecyclerView: RecyclerView? = null

    private var mLoadSeedListAsyncTask: LoadSeedListAsyncTask? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        setupUi()
    }

    private fun setupUi() {
        emptyTextView = findViewById(R.id.emptyTextView)
        seedRecyclerView = findViewById(R.id.seedRecyclerView)

        // floating action menu
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
    override fun onResume() {
        super.onResume()

        loadSeedList()
    }

    override fun onPause() {
        super.onPause()

        mLoadSeedListAsyncTask?.let {
            it.cancel(true)
            mLoadSeedListAsyncTask = null
        }
    }


    private fun loadSeedList() {
        LoadSeedListAsyncTask { list ->
            if (list.isNotEmpty()) {
                showList(list)
            }

            mLoadSeedListAsyncTask = null
        }.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR)
    }

    private fun showList(list: List<Seed>) {
        emptyTextView?.visibility = View.GONE

        seedRecyclerView?.let {
            val adapter = SeedAdapter(list)
            it.adapter = adapter

            val layoutManager = LinearLayoutManager(this)
            it.layoutManager = layoutManager

            it.addItemDecoration(DividerItemDecoration(this, DividerItemDecoration.VERTICAL))

            it.visibility = View.VISIBLE

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
