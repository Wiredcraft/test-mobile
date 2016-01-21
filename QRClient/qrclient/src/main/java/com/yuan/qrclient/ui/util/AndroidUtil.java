package com.yuan.qrclient.ui.util;

import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * Created by Yuan on 16/1/19.
 */
public class AndroidUtil {

    /**
     * to get the screen's width (pixels)
     *
     * @return
     */
    public static int getScreeWidth() {
        return Resources.getSystem().getDisplayMetrics().widthPixels;
    }

    /**
     * to get the screen's height (pixels)
     *
     * @return
     */
    public static int getScreeHeight() {
        return Resources.getSystem().getDisplayMetrics().heightPixels;
    }

    /**
     * to get the screen's density
     *
     * @return
     */
    public static float getDeviceDensity() {
        return Resources.getSystem().getDisplayMetrics().density;
    }

    /**
     * save the bitmap to local,add give a white bg color
     * @param bitmap
     * @param path
     * @return
     */
    public static boolean saveBitmapNoBgToSdCard(Bitmap bitmap, String path) {
        BufferedOutputStream bos = null;
        try {
            File file = new File(path);
            if (file.exists()) file.delete();
            bos = new BufferedOutputStream(new FileOutputStream(file));

            int w = bitmap.getWidth();
            int h = bitmap.getHeight();
            int w_new = w;
            int h_new = h;
            Bitmap resultBitmap = Bitmap.createBitmap(w_new,h_new, Bitmap.Config.ARGB_8888);
//            Paint paint = new Paint();
//            paint.setColor(Color.WHITE);
            Canvas canvas = new Canvas(resultBitmap);
            canvas.drawColor(Color.WHITE);
            canvas.drawBitmap(bitmap, new Rect(0, 0, w, h), new Rect(0, 0, w_new, h_new), null);
            resultBitmap.compress(Bitmap.CompressFormat.JPEG, 100, bos);
            bos.flush();
            resultBitmap.recycle();
            return true;
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (bos != null) {
                try {
                    bos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return false;
    }

}
