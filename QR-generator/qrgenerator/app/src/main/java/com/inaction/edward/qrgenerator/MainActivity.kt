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
        scanFab?.setOnClickListener {
            Toast.makeText(this@MainActivity, R.string.scan, Toast.LENGTH_SHORT).show()
            fabMenu?.collapse()
        }

        val generateFab: FloatingActionButton? = findViewById(R.id.generateFab)
        generateFab?.setOnClickListener {
            Toast.makeText(this@MainActivity, R.string.generate, Toast.LENGTH_SHORT).show()
            fabMenu?.collapse()
        }


    }
}

