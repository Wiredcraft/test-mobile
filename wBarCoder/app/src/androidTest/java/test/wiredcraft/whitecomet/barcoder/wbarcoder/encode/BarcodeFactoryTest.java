package test.wiredcraft.whitecomet.barcoder.wbarcoder.encode;

import android.graphics.Bitmap;
import android.support.test.InstrumentationRegistry;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.Binarizer;
import com.google.zxing.BinaryBitmap;
import com.google.zxing.LuminanceSource;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.NotFoundException;
import com.google.zxing.Result;
import com.google.zxing.common.HybridBinarizer;

import org.junit.Before;
import org.junit.Test;

import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

import test.wiredcraft.whitecomet.barcoder.wbarcoder.R;

import static org.junit.Assert.assertEquals;

public class BarcodeFactoryTest {

    private MultiFormatReader decoder;
    private BarcodeFactory factory;
    private Random ran;

    @Before
    public void setUp() throws Exception {
        decoder = new MultiFormatReader();
        factory = new BarcodeFactory(InstrumentationRegistry.getContext());
        ran = new Random();
    }

    @Test
    public void testEncodeBarcode() throws Exception {
        String str = ranStr(ran.nextInt(40)+10);
        Bitmap ret = factory.encodeBarcode(str);

        Result result = decode(ret);
        assertEquals(str, result.getText());
    }

    @Test
    public void testSetInnerIcon() throws Exception {
        factory.setInnerIcon(R.mipmap.ic_launcher);

        String str = ranStr(ran.nextInt(40)+10);
        Bitmap ret = factory.encodeBarcode(str);

        Result result = decode(ret);
        assertEquals(str, result.getText());
    }

    @Test
    public void testSetFormat() throws Exception {
        int pick = new Random().nextInt(BarcodeFormat.values().length);
        BarcodeFormat format = BarcodeFormat.values()[pick];
        factory.setFormat(format);

        //TODO choose different str for different format
        String str = "";
        for(int i=0;i<8;i++){
            str+=ran.nextInt(10);
        }
        Bitmap ret = factory.encodeBarcode(str);

        Result result = decode(ret);
        assertEquals(str, result.getText());
    }

    @Test
    public void testSetBlocksColor() throws Exception {


        String str = ranStr(ran.nextInt(40)+10);
        Bitmap ret = factory.encodeBarcode(str);

        Result result = decode(ret);
        assertEquals(str, result.getText());
    }

    private static String ranStr(int length) {
        StringBuilder builder = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            builder.append((char) (ThreadLocalRandom.current().nextInt(33, 128)));
        }
        return builder.toString();
    }
    private Result decode(Bitmap barcode) throws NotFoundException {
        LuminanceSource source = new BitmapLuminanceSource(barcode);
        Binarizer binarizer = new HybridBinarizer(source);
        BinaryBitmap binaryBitmap = new BinaryBitmap(binarizer);
        return decoder.decode(binaryBitmap);
    }
}