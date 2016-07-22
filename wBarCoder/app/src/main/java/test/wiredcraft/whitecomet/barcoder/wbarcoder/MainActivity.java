package test.wiredcraft.whitecomet.barcoder.wbarcoder;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.animation.ObjectAnimator;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.view.animation.Interpolator;
import android.view.animation.OvershootInterpolator;
import android.widget.ImageView;
import android.widget.Toast;

import test.wiredcraft.whitecomet.barcoder.wbarcoder.encode.BarcodeFactory;
import test.wiredcraft.whitecomet.barcoder.wbarcoder.seed.DefaultSeedParser;
import test.wiredcraft.whitecomet.barcoder.wbarcoder.seed.Seed;
import test.wiredcraft.whitecomet.barcoder.wbarcoder.seed.SeedManager;
import test.wiredcraft.whitecomet.barcoder.wbarcoder.utils.WcLog;

public class MainActivity extends AppCompatActivity implements View.OnClickListener,SeedManager.SeedRefreshedCallback{

    private static final String TAG = MainActivity.class.getSimpleName();
    private BarcodeFactory barcodeFactory;
    private FloatingActionButton fabSwitcher;
    private FloatingActionButton fabCamera;
    private FloatingActionButton fabRefresh;
    private ObjectAnimator animatorCamera;
    private ObjectAnimator animatorRefresh;
    private ImageView viewBarcode;
    private SeedManager seedManager;

    private ObjectAnimator refreshAnimator;

    private static final long RETRY_TIME = 5 * 1000;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.layout_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);


        fabSwitcher = (FloatingActionButton) findViewById(R.id.fab_switcher);
        fabCamera = (FloatingActionButton) findViewById(R.id.fab_camera);
        fabRefresh = (FloatingActionButton) findViewById(R.id.fab_refresh);
        fabSwitcher.setOnClickListener(this);
        fabCamera.setOnClickListener(this);
        fabRefresh.setOnClickListener(this);

        refreshAnimator = ObjectAnimator.ofFloat(fabRefresh, "rotation", 0, 360f);
        refreshAnimator.setDuration(1000);
        refreshAnimator.setRepeatCount(ObjectAnimator.INFINITE);
        seedManager = SeedManager.getInstance(this.getApplicationContext());
        seedManager.registerRefreshCallback(this);
//        seedManager.setSeedParser(new DefaultSeedParser());
//        seedManager.setSeedUrl();
        barcodeFactory = new BarcodeFactory(this.getApplicationContext());
        viewBarcode = (ImageView) findViewById(R.id.view_barcode);
    }

    @Override
    protected void onStart() {
        super.onStart();
        initBarcode();
    }

    @Override
    protected void onStop() {
        super.onStop();
        timerHandler.removeCallbacks(timerRunnable);
    }

    @Override
    public void onClick(View v) {
        int viewId = v.getId();
        switch (viewId){
            case R.id.fab_switcher:
                if(fabCamera.getVisibility() == View.INVISIBLE){
                    showButtons();
                    fabSwitcher.setImageResource(R.drawable.ic_minus);
                }else if(fabCamera.getVisibility() == View.VISIBLE && !animatorCamera.isStarted()){
                    hideButtons();
                    fabSwitcher.setImageResource(R.drawable.ic_plus);
                }
                break;
            case R.id.fab_camera:
                startActivity(new Intent(MainActivity.this, ScannerActivity.class));
                break;
            case R.id.fab_refresh:
                refreshBarcode();
                break;
            default:break;
        }
    }

    private void showButtons(){
        if(animatorCamera == null || animatorRefresh == null){
            Interpolator interpolator = new OvershootInterpolator(1f);
            float disCamera = fabSwitcher.getY() - fabCamera.getY() ;
            animatorCamera = ObjectAnimator.ofFloat(fabCamera, "translationY",disCamera, 0);
            animatorCamera.setInterpolator(interpolator);
            animatorCamera.setDuration(300);
            animatorCamera.addListener(new AnimatorListenerAdapter() {
                @Override
                public void onAnimationEnd(Animator animation) {
                    fabRefresh.setVisibility(View.VISIBLE);
                }
            });
            float disRefresh = fabSwitcher.getY() - fabRefresh.getY() ;
            animatorRefresh = ObjectAnimator.ofFloat(fabRefresh, "translationY",disRefresh, 0);
            animatorRefresh.setInterpolator(interpolator);
            animatorRefresh.setDuration(300);
            animatorRefresh.addListener(new AnimatorListenerAdapter() {
                @Override
                public void onAnimationEnd(Animator animation) {
                    fabCamera.setVisibility(View.VISIBLE);
                }
            });
        }
        fabCamera.setVisibility(View.VISIBLE);
        fabRefresh.setVisibility(View.VISIBLE);
        animatorCamera.removeAllListeners();
        animatorRefresh.removeAllListeners();
        animatorCamera.start();
        animatorRefresh.start();
    }

    private void hideButtons() {
        animatorCamera.addListener(new AnimatorListenerAdapter() {
            @Override
            public void onAnimationEnd(Animator animation) {
                fabCamera.setVisibility(View.INVISIBLE);
                fabRefresh.setVisibility(View.INVISIBLE);
            }
        });
        animatorCamera.reverse();
        animatorRefresh.reverse();
    }

    private void initBarcode(){
        Seed seed = seedManager.loadSeed();
        setBarcode(seed);
    }

    private void refreshBarcode(){
        seedManager.refreshSeed();
        refreshAnimator.start();
    }

    @Override
    public void onRefresh(Seed seed) {
        Message msg = viewHandler.obtainMessage();
        msg.what = 0;
        msg.obj = seed;
        msg.sendToTarget();
    }
    Handler viewHandler = new Handler(Looper.getMainLooper()){
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            switch (msg.what){
                case 0:
                    refreshAnimator.end();
                    Seed seed = (Seed) msg.obj;

                    if(seed == null){
                        Toast.makeText(MainActivity.this,"Refresh seed failed",Toast.LENGTH_LONG).show();
                        seed = seedManager.loadSeed();
                    }
                    setBarcode(seed);
                    break;
                default:
            }
        }
    };
    private void setBarcode(Seed seed){
        try {
            if(seed.getExpiredTime() <= System.currentTimeMillis()) throw new Exception("seed is expired");
            viewBarcode.setImageBitmap(barcodeFactory.encodeBarcode(seed.getSeed()));
            refreshDelay(seed.getExpiredTime() - System.currentTimeMillis());
        } catch (Exception e) {
            WcLog.e(TAG,"set Barcode error",e);
            viewBarcode.setImageResource(R.drawable.ic_qrcode);
            refreshDelay(RETRY_TIME);
        }
    }

    private Handler timerHandler = new Handler();
    private Runnable timerRunnable = new Runnable() {
        @Override
        public void run() {
            seedManager.refreshSeed();
            refreshAnimator.start();
        }
    };
    private void refreshDelay(long delay){
        timerHandler.removeCallbacks(timerRunnable);
        timerHandler.postDelayed(timerRunnable,delay);
    }
}
