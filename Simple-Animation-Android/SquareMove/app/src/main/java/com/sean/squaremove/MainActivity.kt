package com.sean.squaremove

import android.content.Context
import android.support.v7.app.AppCompatActivity
import android.os.Bundle

import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager

import android.util.Log
import android.view.View
import android.view.Window
import android.view.WindowManager

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        requestWindowFeature(Window.FEATURE_NO_TITLE)
        window.setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
                WindowManager.LayoutParams.FLAG_FULLSCREEN)

        setContentView(R.layout.activity_main)

        sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        sensor = sensorManager?.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
    }

    internal var sensorManager: SensorManager? = null
    internal var sensor: Sensor? = null
    private var init = false

    private var squareMoveView: SquareMoveView? = null

    // x, y is between [-MAX_ACCELEROMETER, MAX_ACCELEROMETER]
    internal fun moveTo(x: Float, y: Float) {

        var squareX = squareMoveView!!.x
        var squareY = squareMoveView!!.y
        val squareWidth = squareMoveView!!.width.toFloat()
        val squareHeight = squareMoveView!!.height.toFloat()

        val container = findViewById(R.id.square_container)
        val container_width = container.width.toFloat()
        val container_height = container.height.toFloat()

        squareX += x
        squareY += y

        if (squareX < 0) {
            squareX = 0f
        }

        if (squareY < 0) {
            squareY = 0f
        }

        if (squareX > container_width - squareWidth) {
            squareX = container_width - squareWidth
        }

        if (squareY > container_height - squareHeight) {
            squareY = container_height - squareHeight
        }

        squareMoveView!!.moveTo(squareX.toInt(), squareY.toInt())
    }

    fun register() {
        sensorManager!!.registerListener(listener, sensor, SensorManager.SENSOR_DELAY_GAME)
    }

    fun unregister() {
        sensorManager!!.unregisterListener(listener)
    }

    internal var listener: SensorEventListener = object : SensorEventListener {

        override fun onAccuracyChanged(sensor: Sensor, accuracy: Int) {
            // TODO Auto-generated method stub

        }

        override fun onSensorChanged(event: SensorEvent) {
            if (!init)
                return
            val x = event.values[0] * 9
            val y = event.values[1] * 9

            moveTo(-x, y)
        }

    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        // TODO Auto-generated method stub
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus && !init) {
            init()
            init = true
        }
    }


    fun init() {
        squareMoveView = findViewById(R.id.square) as SquareMoveView
    }


    override fun onDestroy() {
        // TODO Auto-generated method stub
        super.onDestroy()
        unregister()
    }


    override fun onPause() {
        // TODO Auto-generated method stub
        super.onPause()
        unregister()
    }


    override fun onRestart() {
        // TODO Auto-generated method stub
        super.onRestart()
        register()
    }


    override fun onResume() {
        // TODO Auto-generated method stub
        super.onResume()
        register()
    }

    companion object {


        private val MAX_ACCELEROMETER = 9.81f
    }
}
