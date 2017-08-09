package com.inaction.edward.qrgenerator

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import com.getbase.floatingactionbutton.FloatingActionButton
import com.getbase.floatingactionbutton.FloatingActionsMenu

class MainActivity : AppCompatActivity() {

    var fabMenu: FloatingActionsMenu? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        setupFabMenu()
    }

    fun setupFabMenu() {
        fabMenu = findViewById(R.id.fabMenu)

        val scanFab: FloatingActionButton? = findViewById(R.id.scanFab)
        scanFab?.size = FloatingActionButton.SIZE_MINI
        scanFab?.setOnClickListener {
            toast(R.string.scan)
            fabMenu?.collapse()
        }

        val generateFab: FloatingActionButton? = findViewById(R.id.generateFab)
        generateFab?.size = FloatingActionButton.SIZE_MINI
        generateFab?.setOnClickListener {
            toActivity(GeneratorActivity::class.java)
            fabMenu?.collapse()
        }


    }
}
