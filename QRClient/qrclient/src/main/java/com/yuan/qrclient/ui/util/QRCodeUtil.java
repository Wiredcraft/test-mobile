package com.yuan.qrclient.ui.util;

import android.graphics.Bitmap;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;

/**
 * Created by Yuan on 16/1/19.
 */
public class QRCodeUtil {

    /**
     * By the methord,return a simple sQRCode bitmap
     *
     * @param info String
     * @return Bitmap
     * @throws WriterException
     */
    public static Bitmap create2DCode(String info) throws WriterException {
        //生成二维矩阵,编码时指定大小,不要生成了图片以后再进行缩放,这样会模糊导致识别失败
        int w = AndroidUtil.getScreeWidth();
        w = w * 3 / 5;

        BitMatrix matrix = new MultiFormatWriter().encode(info, BarcodeFormat.QR_CODE, w, w);
        int width = matrix.getWidth();
        int height = matrix.getHeight();
        int[] pixels = new int[width * height];
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                if (matrix.get(x, y)) {
                    pixels[y * width + x] = 0xFF000000;
                }

            }
        }
        Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
        bitmap.setPixels(pixels, 0, width, 0, 0, width, height);
        return bitmap;
    }
}
