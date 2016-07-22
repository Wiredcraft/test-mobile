package test.wiredcraft.whitecomet.barcoder.wbarcoder.seed;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;

import test.wiredcraft.whitecomet.barcoder.wbarcoder.utils.WcLog;

public class DefaultSeedParser implements SeedManager.SeedParser {
    private static final String TAG = DefaultSeedParser.class.getSimpleName();

    @Override
    public Seed parse(String json) {
        Seed newSeed = null;
        try {
            newSeed = new Gson().fromJson(json, Seed.class);
            if( newSeed == null ) throw new JsonSyntaxException("json string is null");

        }catch (JsonSyntaxException e){
            WcLog.e(TAG,"json string error:" + json, e);
        }
        return newSeed;
    }
}
