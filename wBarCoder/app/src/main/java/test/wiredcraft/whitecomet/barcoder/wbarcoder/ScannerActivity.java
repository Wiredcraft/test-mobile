package test.wiredcraft.whitecomet.barcoder.wbarcoder;

import android.graphics.Bitmap;
import android.os.Bundle;
import android.util.Log;
import android.view.SurfaceView;
import android.view.Window;
import android.view.WindowManager;

import com.google.zxing.Result;

import test.wiredcraft.whitecomet.barcoder.wbarcoder.capture.decode.CaptureActivity;
import test.wiredcraft.whitecomet.barcoder.wbarcoder.capture.decode.ViewfinderView;

/**
 * Created by 文戎 on 2016/7/12.
 */
public class ScannerActivity extends CaptureActivity {
    private static final String TAG = ScannerActivity.class.getSimpleName();

    @Override
    protected ViewfinderView getViewFinderView() {
        return (ViewfinderView) findViewById(R.id.viewfinder_view);
    }

    @Override
    protected SurfaceView getSurfaceView() {
        return (SurfaceView) findViewById(R.id.preview_view);
    }

    @Override
    public void handleDecode(Result rawResult, Bitmap barcode, float scaleFactor) {
        inactivityTimer.onActivity();
        beepManager.playBeepSoundAndVibrate();
        Log.d(TAG, rawResult.getText());
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Window window = getWindow();
        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        setContentView(R.layout.layout_capture);
    }

}
