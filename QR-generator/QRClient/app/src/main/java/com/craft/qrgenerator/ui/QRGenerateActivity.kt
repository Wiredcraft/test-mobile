package com.craft.qrgenerator.ui

import android.content.Context
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import com.craft.qrgenerator.R
import com.craft.qrgenerator.api.ApiClient
import com.craft.qrgenerator.bean.SeedBean
import com.craft.qrgenerator.utils.AppUtils
import com.craft.qrgenerator.view.TimeView
import com.google.gson.Gson
import com.uuzuche.lib_zxing.activity.CodeUtils
import kotlinx.android.synthetic.main.activity_qrgenerate.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class QRGenerateActivity : AppCompatActivity() {

    companion object {
        private val TAG = QRGenerateActivity::class.java.simpleName
        const val SP_SEED_CACHE = "seed_cache"
        const val SP_SEED_CACHE_KEY = "cache"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_qrgenerate)
    }

    override fun onStart() {
        super.onStart()
        getSeed()
    }

    override fun onStop() {
        super.onStop()
        timeView.stop()
    }

    private fun getSeed() {
        Log.d(TAG, "getSeed")
        ApiClient.get().getApiService().getSeed().enqueue(object : Callback<SeedBean> {
            override fun onResponse(call: Call<SeedBean>, response: Response<SeedBean>) {
                try {
                    onBindData(response.body()!!)
                } catch (e: Exception) {
                    e.printStackTrace()
                    onFetchFailed()
                }
            }

            override fun onFailure(call: Call<SeedBean>, t: Throwable) {
                t.printStackTrace()
                onFetchFailed()
            }
        })
    }

    /**
     * show qr with seed and fetch seed again when expired
     */
    private fun onBindData(seed: SeedBean) {
        cachedSeed(seed)
        val bitmap = CodeUtils.createImage(seed.seed, 400, 400, null)
        imageCode.setImageBitmap(bitmap)
        val time = AppUtils.dateTolong(seed.expires_at)
        timeView.start(time, object : TimeView.TimerListener {
            override fun onFinish() {
                Log.d(TAG, "onFinish")
                getSeed()
            }
        })
    }

    /**
     * if load seed failed, use cached seed, and don't fetch again after expired
     */
    private fun onFetchFailed() {
        val seed = loadCachedSeed()
        val bitmap = CodeUtils.createImage(seed.seed, 400, 400, null)
        imageCode.setImageBitmap(bitmap)
        timeView.start(AppUtils.dateTolong(seed.expires_at), object : TimeView.TimerListener {
            override fun onFinish() {
                Log.d(TAG, "onFinish")
                timeView.text = AppUtils.showTime(0)
            }
        })
    }

    private fun cachedSeed(seed: SeedBean) {
        val preferences = getSharedPreferences(SP_SEED_CACHE, Context.MODE_PRIVATE)
        preferences?.edit()?.putString(SP_SEED_CACHE_KEY, Gson().toJson(seed))?.apply()
    }


    private fun loadCachedSeed(): SeedBean {
        val sp = getSharedPreferences(SP_SEED_CACHE, Context.MODE_PRIVATE)
        return Gson().fromJson(sp.getString(SP_SEED_CACHE_KEY, null), SeedBean::class.java)
    }

}
