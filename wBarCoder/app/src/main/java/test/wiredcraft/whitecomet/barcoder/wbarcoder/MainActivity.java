package test.wiredcraft.whitecomet.barcoder.wbarcoder;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.animation.ObjectAnimator;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.view.menu.MenuWrapperFactory;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.view.animation.Animation;
import android.view.animation.AnticipateInterpolator;
import android.view.animation.DecelerateInterpolator;
import android.view.animation.Interpolator;
import android.view.animation.OvershootInterpolator;
import android.view.animation.TranslateAnimation;
import android.widget.ImageView;

import com.google.zxing.WriterException;

import test.wiredcraft.whitecomet.barcoder.wbarcoder.encode.BarcodeFactory;
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

        seedManager = SeedManager.getInstantce(this.getApplicationContext());
        seedManager.registerRefreshCallback(this);
        barcodeFactory = new BarcodeFactory(this.getApplicationContext());
        viewBarcode = (ImageView) findViewById(R.id.view_barcode);

        initBarcode();
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
        try {
            viewBarcode.setImageBitmap(barcodeFactory.encodeBarcode(seed.getSeed()));
        } catch (Exception e) {
            WcLog.e(TAG,"encodeBarcode error",e);
            viewBarcode.setImageResource(R.drawable.ic_qrcode);
        }
    }

    private void refreshBarcode(){
        seedManager.refreshSeed();
    }

    @Override
    public void onRefresh(Seed seed) {
        try {
            viewBarcode.setImageBitmap(barcodeFactory.encodeBarcode(seed.getSeed()));
        } catch (Exception e) {
            WcLog.e(TAG,"encodeBarcode error",e);
            viewBarcode.setImageResource(R.drawable.ic_qrcode);
        }
    }
}
