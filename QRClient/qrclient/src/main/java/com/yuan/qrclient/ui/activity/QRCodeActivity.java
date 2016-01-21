package com.yuan.qrclient.ui.activity;

import android.content.Context;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.os.Message;
import android.os.PowerManager;
import android.support.design.widget.Snackbar;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.WindowManager;
import android.widget.ImageView;

import com.google.zxing.WriterException;
import com.yuan.qrclient.R;
import com.yuan.qrclient.api.seed.API;
import com.yuan.qrclient.model.Seed;
import com.yuan.qrclient.ui.util.AndroidUtil;
import com.yuan.qrclient.ui.util.BrightnessTools;
import com.yuan.qrclient.ui.util.QRCodeUtil;
import com.yuan.qrclient.ui.util.SpSetting;
import com.yuan.qrclient.utils.QLog;

import java.io.IOException;

import retrofit.Call;
import retrofit.Callback;
import retrofit.Response;
import retrofit.Retrofit;

/**
 * The Activity To Show The QR Code
 */
public class QRCodeActivity extends BaseTitleActivity {

    /**
     * the time of refresh QR Code
     */
    private static final int TIME = 60;

    private ImageView img;

    private Bitmap bitmap;

    private SpSetting setting;

    private int seconds = TIME;

    /**
     * keep the screen on
     */
    private PowerManager.WakeLock wakeLock;

    //private boolean isAutoBright;

    private int lastBright;

    /**
     * use Handler to control the QRCode to refreshs
     */
    private Handler hanlder = new Handler() {

        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            switch (msg.what) {
                case TIME:
                    if (seconds == 0) {
                        seconds = TIME;
                        initNewBitmap();
                    } else {
                        seconds--;
                        hanlder.sendEmptyMessageDelayed(TIME, 1000);
                    }
                    //Snackbar.make(img, seconds + "", Snackbar.LENGTH_SHORT).show();
                    break;
            }
        }

    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_qrcode);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);//keep the screen high light

        img = (ImageView) findViewById(R.id.img_qrcode);
        setting = SpSetting.newInstance(this);

        initWakeLock(this);
        initLastBitmap();
        initNewBitmap();

//        isAutoBright = BrightnessTools.isAutoBrightness(this);
//        if(isAutoBright){
//            BrightnessTools.stopAutoBrightness(this);
//        }
    }

    /**
     * init the last seed data to bitmap if not null
     */
    private void initLastBitmap() {
        String lastdata = setting.getString(SpSetting.KEY_SEED_DATA);
        if (!TextUtils.isEmpty(lastdata)) {
            try {
                QLog.i("seed last =  " + lastdata);
                img.setImageBitmap(bitmap = QRCodeUtil.create2DCode(lastdata));
            } catch (WriterException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * init the new seed data from server
     */
    private void initNewBitmap() {
        String expiretime = setting.getString(SpSetting.KEY_EXPIREAT);
        if(!TextUtils.isEmpty(expiretime)){
            long expiretime_int = Long.parseLong(expiretime);
            if(expiretime_int > System.currentTimeMillis()){
                return;
            }
        }
        try {
            Call<Seed> call = API.seed_get().seed();
            call.enqueue(new Callback<Seed>() {
                @Override
                public void onResponse(Response<Seed> response, Retrofit retrofit) {
                    Seed seed = response.body();
                    QLog.i("seed new = " + seed.toString());
                    if (response.isSuccess() && seed != null) {
                        try {
                            setting.save(SpSetting.KEY_SEED_DATA, seed.data);
                            setting.save(SpSetting.KEY_EXPIREAT, seed.expiredAt);
                            if (bitmap != null) {
                                bitmap.recycle();
                            }
                            img.setImageBitmap(bitmap = QRCodeUtil.create2DCode(seed.data));
                        } catch (WriterException e) {
                            e.printStackTrace();
                        }
                    }
                }

                @Override
                public void onFailure(Throwable t) {
                    Snackbar.make(img, "The network is error!", Snackbar.LENGTH_LONG).show();
                }
            });
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * release some memory
     */
    @Override
    protected void onDestroy() {
        if (bitmap != null) {
            bitmap.recycle();
        }
        hanlder.removeMessages(TIME);
        hanlder = null;
        super.onDestroy();
    }

    @Override
    protected void onResume() {
        super.onResume();
        acquireWakeLock();
        lastBright = BrightnessTools.getScreenBrightness(this);
        BrightnessTools.setBrightness(this, 255);
    }

    @Override
    protected void onPause() {
        releaseWakeLock();
        BrightnessTools.setBrightness(this, lastBright);
//        if(isAutoBright){
//            BrightnessTools.startAutoBrightness(this);
//        }
        super.onPause();
    }

    private void initWakeLock(Context context) {
        PowerManager powerManager = (PowerManager) (context
                .getSystemService(Context.POWER_SERVICE));
        wakeLock = powerManager.newWakeLock(
                PowerManager.SCREEN_DIM_WAKE_LOCK, "My Tag");
    }

    private void acquireWakeLock() {
        if (wakeLock != null) {
            wakeLock.acquire();
        }
    }

    private void releaseWakeLock() {
        if (wakeLock != null && wakeLock.isHeld()) {
            wakeLock.release();
            wakeLock = null;
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.genqrcode, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.action_save) {
            if (bitmap != null && !bitmap.isRecycled()) {
                String path = Environment.getExternalStorageDirectory().getPath() + "/aqrcode.jpg";
                boolean isSucces = AndroidUtil.saveBitmapNoBgToSdCard(bitmap, path);
                if (isSucces) {
                    Snackbar.make(img, "save to " + path, Snackbar.LENGTH_LONG).show();
                }
            }
            return true;
        }
        return super.onOptionsItemSelected(item);
    }
}
