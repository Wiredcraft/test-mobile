package test.wiredcraft.whitecomet.barcoder.wbarcoder.view.capture.decode;

import android.app.Activity;
import android.content.pm.ActivityInfo;
import android.content.res.Configuration;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.Surface;
import android.view.SurfaceHolder;
import android.view.SurfaceView;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.DecodeHintType;
import com.google.zxing.Result;

import java.io.IOException;
import java.util.Map;
import java.util.Set;

import test.wiredcraft.whitecomet.barcoder.wbarcoder.view.capture.PreferencesConstants;
import test.wiredcraft.whitecomet.barcoder.wbarcoder.view.capture.camera.CameraManager;

/**
 * Created by 文戎 on 2016/7/11.
 */
public abstract class CaptureActivity extends Activity implements SurfaceHolder.Callback{
    private static final String TAG = CaptureActivity.class.getSimpleName();

    private ViewfinderView viewfinderView;
    private boolean hasSurface;
    private CameraManager cameraManager;
    private CaptureActivityHandler handler;
    protected BeepManager beepManager;
    protected AmbientLightManager ambientLightManager;
    protected InactivityTimer inactivityTimer;
    private Set<BarcodeFormat> decodeFormats;
    private Map<DecodeHintType,?> decodeHints = null;
    private String characterSet;

    protected abstract ViewfinderView getViewFinderView();
    protected abstract SurfaceView getSurfaceView();

    public abstract void handleDecode(Result rawResult, Bitmap barcode, float scaleFactor);

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        hasSurface =false;
        inactivityTimer = new InactivityTimer(this);
        beepManager = new BeepManager(this);
        ambientLightManager = new AmbientLightManager(this);
    }

    @Override
    protected void onResume() {
        super.onResume();

        cameraManager =  new CameraManager(getApplication());

        viewfinderView = getViewFinderView();
        viewfinderView.setCameraManager(cameraManager);

        handler = null;

        if (PreferencesConstants.KEY_DISABLE_AUTO_ORIENTATION) {
//            setRequestedOrientation(getCurrentOrientation());
            setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_SENSOR_LANDSCAPE);
        } else {
            setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_SENSOR_LANDSCAPE);
        }

        beepManager.updatePrefs();
        ambientLightManager.start(cameraManager);

        inactivityTimer.onResume();


        decodeFormats = null;
//        decodeFormats = DecodeFormatManager.PRODUCT_FORMATS;
        characterSet = null;

        SurfaceView surfaceView = getSurfaceView();
        SurfaceHolder surfaceHolder = surfaceView.getHolder();

        if (hasSurface) {
            initCamera(surfaceHolder);
        } else {
            surfaceHolder.addCallback(this);
        }
    }
    private int getCurrentOrientation() {
        int rotation = getWindowManager().getDefaultDisplay().getRotation();
        if (getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE) {
            switch (rotation) {
                case Surface.ROTATION_0:
                case Surface.ROTATION_90:
                    return ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE;
                default:
                    return ActivityInfo.SCREEN_ORIENTATION_REVERSE_LANDSCAPE;
            }
        } else {
            switch (rotation) {
                case Surface.ROTATION_0:
                case Surface.ROTATION_270:
                    return ActivityInfo.SCREEN_ORIENTATION_PORTRAIT;
                default:
                    return ActivityInfo.SCREEN_ORIENTATION_REVERSE_PORTRAIT;
            }
        }
    }

    @Override
    protected void onPause() {
        if (handler != null) {
            handler.quitSynchronously();
            handler = null;
        }
        inactivityTimer.onPause();
        ambientLightManager.stop();
        beepManager.close();
        cameraManager.closeDriver();
        if (!hasSurface) {
            SurfaceView surfaceView = getSurfaceView();
            SurfaceHolder surfaceHolder = surfaceView.getHolder();
            surfaceHolder.removeCallback(this);
        }
        super.onPause();
    }
    @Override
    protected void onDestroy() {
        inactivityTimer.shutdown();
        super.onDestroy();
    }

    private void initCamera(SurfaceHolder surfaceHolder) {
        if (surfaceHolder == null) {
            throw new IllegalStateException("No SurfaceHolder provided");
        }

        if (cameraManager.isOpen()) {
            Log.w(TAG,"initCamera() while already open -- late SurfaceView callback?");
            return;
        }
        try {
            cameraManager.openDriver(surfaceHolder);
            if (handler == null) {
                handler = new CaptureActivityHandler(this, decodeFormats, decodeHints, characterSet, cameraManager);
            }
        } catch (IOException ioe) {
            Log.w(TAG, ioe);
        } catch (RuntimeException e) {
            Log.w(TAG, "Unexpected error initializing camera", e);
        }
    }

    @Override
    public void surfaceChanged(SurfaceHolder holder, int format, int width,int height) {
    }

    @Override
    public void surfaceCreated(SurfaceHolder holder) {
        if (holder == null) {
            Log.e(TAG,"*** WARNING *** surfaceCreated() gave us a null surface!");
        }
        if (!hasSurface) {
            hasSurface =true;
            initCamera(holder);
        }
    }

    @Override
    public void surfaceDestroyed(SurfaceHolder holder) {
        hasSurface =false;
    }

    public Handler getHandler() {
        return handler;
    }

    public CameraManager getCameraManager() {
        return cameraManager;
    }

    public void drawViewfinder() {
        viewfinderView.drawViewfinder();
    }

    public ViewfinderView getViewfinderView() {
        return viewfinderView;
    }
}
