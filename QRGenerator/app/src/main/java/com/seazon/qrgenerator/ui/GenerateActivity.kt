package com.seazon.qrgenerator.ui

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import com.seazon.qrgenerator.R
import com.seazon.qrgenerator.api.ApiManager
import com.seazon.qrgenerator.entity.Seed
import com.uuzuche.lib_zxing.activity.CodeUtils
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.content_generate.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.io.IOException

/**
 * Created by seazon on 2018/3/7.
 */
class GenerateActivity : AppCompatActivity() {

    private val TAG = GenerateActivity::class.java.simpleName

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_generate)
        setSupportActionBar(toolbar)
    }

    override fun onStart() {
        Log.d(TAG, "onStart")
        super.onStart()
        getSeed()
    }

    override fun onStop() {
        super.onStop()
        timeView.stop()
    }

    private fun getSeed() {
        Log.d(TAG, "getSeed")
        ApiManager.getInstence().getApiService().getSeed().enqueue(object : Callback<Seed> {
            override fun onResponse(call: Call<Seed>, response: Response<Seed>) {
                try {
                    onSeedReceived(response.body())
                } catch (e: IOException) {
                    e.printStackTrace()
                }
            }

            override fun onFailure(call: Call<Seed>, t: Throwable) {
                t.printStackTrace()
            }
        })
    }

    private fun onSeedReceived(seed: Seed) {
        val bitmap = CodeUtils.createImage(seed.seed, 400, 400, null)
        codeView.setImageBitmap(bitmap)
        timeView.start(seed.expires_at_long, object : CountdownView.TicListener {
            override fun onFinish() {
                Log.d(TAG, "onFinish")
                getSeed()
            }
        })
    }

}