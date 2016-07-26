package test.wiredcraft.whitecomet.barcoder.wbarcoder.encode;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.provider.Telephony;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

import java.util.Hashtable;

public class BarcodeFactory {
    private static final int DEFAULT_ICON_TARGET_SIZE = 40;
    private static final int DEFAULT_BARCODE_TARGET_SIZE = 400;

    private Context context;
    private Bitmap icon;
    private Hashtable<EncodeHintType, String> encodeHintSet = new Hashtable<>();
    private BarcodeFormat format;
    private int iconTargetWidth;
    private int iconTargetHeight;
    private int blackColor;
    private int whiteColor;
    private int width;
    private int height;

    public BarcodeFactory(Context context){
        this.context = context;
        encodeHintSet.put(EncodeHintType.CHARACTER_SET, "UTF-8");
        format = BarcodeFormat.QR_CODE;
        encodeHintSet.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H.toString());
        blackColor = 0xFF000000;
        whiteColor = 0xFFFFFFFF;
        width = DEFAULT_BARCODE_TARGET_SIZE;
        height = DEFAULT_BARCODE_TARGET_SIZE;
    }

    public void setInnerIcon(Bitmap icon, int targetWidth, int targetHeight){
        if(icon == null) {
            this.icon = null;
            return;
        }
        iconTargetWidth = targetWidth;
        iconTargetHeight = targetHeight;
        Matrix m = new Matrix();
        float sx = (float) 2 * targetWidth / icon.getWidth();
        float sy = (float) 2 * targetHeight / icon.getHeight();
        m.setScale(sx, sy);
        this.icon = Bitmap.createBitmap(icon, 0, 0, icon.getWidth(), icon.getHeight(), m, false);
    }
    public void setInnerIcon(int icon, int targetWidth, int targetHeight){
        Bitmap iconBitmap = BitmapFactory.decodeResource(context.getResources(), icon);
        setInnerIcon(iconBitmap,targetWidth,targetHeight);
    }
    public void setInnerIcon(Bitmap icon){
        setInnerIcon(icon,DEFAULT_ICON_TARGET_SIZE, DEFAULT_ICON_TARGET_SIZE);
    }
    public void setInnerIcon(int icon){
        setInnerIcon(icon,DEFAULT_ICON_TARGET_SIZE, DEFAULT_ICON_TARGET_SIZE);
    }

    public void setCharSet(String charSet){
        encodeHintSet.put(EncodeHintType.CHARACTER_SET, charSet);
    }
    public void setFormat(BarcodeFormat format){
        this.format = format;

        if(format == BarcodeFormat.QR_CODE)
            encodeHintSet.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H.toString());
        else
            encodeHintSet.remove(EncodeHintType.ERROR_CORRECTION);

    }

    public void setBlocksColor(int blackColor, int whiteColor){
        this.blackColor = blackColor;
        this.whiteColor = whiteColor;
    }

    public void setImageSize(int width, int height){
        this.width = width;
        this.height = height;
    }

    /**
     * 生成二维码
     * @param content 二维码中包含的文本信息
     * @return Bitmap 位图
     * @throws WriterException
     */
    public Bitmap encodeBarcode(String content) throws WriterException {
        MultiFormatWriter writer = new MultiFormatWriter();
        BitMatrix matrix = writer.encode(content, format, width, height, encodeHintSet);//生成二维码矩阵信息
        return getBitmap(matrix);
    }

    private Bitmap getBitmap(BitMatrix matrix){
        int width = matrix.getWidth();
        int height = matrix.getHeight();
        int halfW = width / 2;
        int halfH = height / 2;

        int[] pixels = new int[width * height];

        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                if(icon != null && ( x > halfW - iconTargetWidth
                                    && x < halfW + iconTargetWidth
                                    && y > halfH - iconTargetHeight
                                    && y < halfH + iconTargetHeight)) {

                    int iconX = x - halfW + iconTargetWidth;
                    int iconY = y - halfH + iconTargetHeight;
                    pixels[y * width + x] = icon.getPixel(iconX, iconY);
                } else {
                    if (matrix.get(x, y)) {
                        pixels[y * width + x] = blackColor;
                    }else{
                        pixels[y * width + x] = whiteColor;
                    }
                }
            }
        }

        Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
        bitmap.setPixels(pixels, 0, width, 0, 0, width, height);

        return bitmap;
    }


}
