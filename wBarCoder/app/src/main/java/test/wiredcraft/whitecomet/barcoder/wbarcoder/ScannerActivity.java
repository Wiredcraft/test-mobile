package test.wiredcraft.whitecomet.barcoder.wbarcoder;

import android.content.pm.ActivityInfo;
import android.graphics.Bitmap;
import android.graphics.Matrix;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.SurfaceView;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.ImageView;

import com.google.zxing.Result;

import java.util.zip.Inflater;

import test.wiredcraft.whitecomet.barcoder.wbarcoder.capture.decode.CaptureActivity;
import test.wiredcraft.whitecomet.barcoder.wbarcoder.capture.decode.ViewfinderView;

/**
 * Created by 文戎 on 2016/7/12.
 */
public class ScannerActivity extends CaptureActivity implements View.OnClickListener {
    private static final String TAG = ScannerActivity.class.getSimpleName();
    private FloatingActionButton fabBolt;
    private View addContentView;
    private ImageView imageView;
    private ViewfinderView viewfinderView;

    @Override
    protected ViewfinderView getViewFinderView() {
        return viewfinderView;
    }

    @Override
    protected SurfaceView getSurfaceView() {
        return (SurfaceView) findViewById(R.id.preview_view);
    }

    @Override
    public void handleDecode(Result rawResult, Bitmap barcode, float scaleFactor) {
        inactivityTimer.onActivity();
        beepManager.playBeepSoundAndVibrate();

        Snackbar snackbar = Snackbar.make(addContentView, rawResult.getText(), Snackbar.LENGTH_INDEFINITE);
        Snackbar.SnackbarLayout snackView = (Snackbar.SnackbarLayout) snackbar.getView();
        View imageLayoutView = LayoutInflater.from(this).inflate(R.layout.snackbar_image, snackView, false);
        imageView = (ImageView) imageLayoutView.findViewById(R.id.image_snackbar);
        snackView.addView(imageLayoutView,0);

        if(getCurrentOrientation() == ActivityInfo.SCREEN_ORIENTATION_REVERSE_LANDSCAPE){
            Matrix matrix = new Matrix();
            matrix.setRotate(180f,barcode.getWidth()/2,barcode.getHeight()/2);
            barcode = Bitmap.createBitmap(barcode,0,0,barcode.getWidth(),barcode.getHeight(),matrix,true);
        }

        imageView.setImageBitmap(barcode);
        viewfinderView.drawResultBitmap(barcode);
        if (getHandler() != null) {
            getHandler().sendEmptyMessageDelayed(R.id.restart_preview, 5000);
        }

        snackbar.show();

    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Window window = getWindow();
        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        setContentView(R.layout.layout_capture);

        fabBolt = (FloatingActionButton) findViewById(R.id.fab_bolt);
        fabBolt.setOnClickListener(this);
        addContentView = findViewById(R.id.view_content);
        viewfinderView = (ViewfinderView) findViewById(R.id.viewfinder_view);
        Snackbar.make(addContentView, R.string.scan_tips, Snackbar.LENGTH_SHORT).show();
    }

    private boolean isTorchOn = false;
    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.fab_bolt:
                isTorchOn = !isTorchOn;
                cameraManager.setTorch(isTorchOn);
                break;
            default:break;
        }
    }
}
