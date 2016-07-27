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
import java.util.Map;

/**
 * Factory class for building barcode
 * @version 0.1 unstable
 * @author shiyinayuriko
 */
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

    /**
     * Create a barcode factory with default settings(UTF-8,QR_CODE,High ErrorCorrectionLevel,pure black/white block color and 400 * 400 output size).
     * @param context The context to use. Usually your package context is just ok.
     */
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

    /**
     * Add an icon among the barcode, with specific width and height.
     * @param icon The bitmap which you want to add in the middle of barcode
     * @param targetWidth The target width of the icon
     * @param targetHeight The target height of the icon
     */
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

    /**
     * Add an icon among the barcode, with specific width and height.
     * @param icon The resource id of the icon which you want to add in the middle of barcode
     * @param targetWidth The target width of the icon
     * @param targetHeight The target height of the icon
     */
    public void setInnerIcon(int icon, int targetWidth, int targetHeight){
        Bitmap iconBitmap = BitmapFactory.decodeResource(context.getResources(), icon);
        setInnerIcon(iconBitmap,targetWidth,targetHeight);
    }

    /**
     * Add an icon among the barcode, with default width and height of 40 * 40.
     * @param icon The bitmap which you want to add in the middle of barcode
     */
    public void setInnerIcon(Bitmap icon){
        setInnerIcon(icon,DEFAULT_ICON_TARGET_SIZE, DEFAULT_ICON_TARGET_SIZE);
    }

    /**
     * Add an icon among the barcode, with default width and height of 40 * 40.
     * @param icon The resource id of the icon which you want to add in the middle of barcode
     */
    public void setInnerIcon(int icon){
        setInnerIcon(icon,DEFAULT_ICON_TARGET_SIZE, DEFAULT_ICON_TARGET_SIZE);
    }

    /**
     * Set the charset of the content string in the output barcode. The default value is "UTF-8".
     * @param charset The name of the target charset, such as "UTF-8".
     */
    public void setCharSet(String charset){
        encodeHintSet.put(EncodeHintType.CHARACTER_SET, charset);
    }

    /**
     * Set the format of the output barcode. The default value is QR_CODE.
     * @param format The format of the output barcode.
     * @see BarcodeFormat
     */
    public void setFormat(BarcodeFormat format){
        this.format = format;

        if(format == BarcodeFormat.QR_CODE)
            encodeHintSet.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H.toString());
        else
            encodeHintSet.remove(EncodeHintType.ERROR_CORRECTION);

    }

    /**
     * Set the colors of the blocks in the output barcode, two similar color is not recommended. The default two color is #000000 and #ffffff.
     * @param blackColor The dark block color.
     * @param whiteColor The bright block color.
     */
    public void setBlocksColor(int blackColor, int whiteColor){
        this.blackColor = blackColor;
        this.whiteColor = whiteColor;
    }

    /**
     * Set the size of output barcode.Two equivalent value is suggested.
     * @param width The width of output barcode.
     * @param height The height of output barcode.
     */
    public void setImageSize(int width, int height){
        this.width = width;
        this.height = height;
    }

    /**
     * Export the target barcode with a specific content.
     * @param content The specific content.
     * @return Bitmap The output barcode.
     * @throws WriterException
     * @see MultiFormatWriter#encode(String, BarcodeFormat, int, int, Map)
     */
    public Bitmap encodeBarcode(String content) throws WriterException {
        MultiFormatWriter writer = new MultiFormatWriter();
        BitMatrix matrix = writer.encode(content, format, width, height, encodeHintSet);
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
