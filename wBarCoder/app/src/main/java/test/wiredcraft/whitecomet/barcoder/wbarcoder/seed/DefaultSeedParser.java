package test.wiredcraft.whitecomet.barcoder.wbarcoder.seed;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;

import test.wiredcraft.whitecomet.barcoder.wbarcoder.utils.WcLog;

/**
 * A default parser to parse the text response from a random seed sever.
 * <br/> The syntax of the text of the response server should be text of a json object with two property of seed and expiredTime, such as:
 * <p> {"seed":"b2188cd4df15073b9720eb3cf2237cde","expiredTime":1469629511091} </p>
 * @author shiyinayuriko
 * @version 1.0
 */
public class DefaultSeedParser implements SeedManager.SeedParser {
    private static final String TAG = DefaultSeedParser.class.getSimpleName();

    /**
     * Parse the json text to Seed object.
     * @param json the json text string need to decode.
     * @return the Seed object parse from the json string. null if parse fail occurs.
     * @see Seed
     * @see SeedManager
     */
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
