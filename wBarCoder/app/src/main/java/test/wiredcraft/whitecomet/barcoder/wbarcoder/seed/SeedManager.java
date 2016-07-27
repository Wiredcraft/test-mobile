package test.wiredcraft.whitecomet.barcoder.wbarcoder.seed;

import android.content.Context;
import android.content.SharedPreferences;
import android.widget.Toast;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import test.wiredcraft.whitecomet.barcoder.wbarcoder.utils.Constant;
import test.wiredcraft.whitecomet.barcoder.wbarcoder.utils.Network;
import test.wiredcraft.whitecomet.barcoder.wbarcoder.utils.WcLog;

/**
 * The manager for managing the Seeds, include getting seed from server, saving and load it through the preference.
 * @see Seed
 * @author shiyinayuriko
 */
public class SeedManager {
    private static final String TAG = SeedManager.class.getSimpleName();
    private static final String DEFAULT_SEED_URL = Constant.SERVER_HOST;
    private static final String SEED_PREFERENCE_NAME = "pref_seed";
    private static final String SEED_PREFERENCE_KEY_SEED = "seed";
    private static final String SEED_PREFERENCE_KEY_EXPIREDTIME = "expired_time";



    private static SeedManager instance = null;

    /**
     * Get the singleton instance of the SeedManager.
     * @param context The text of the application
     * @return the only global instance of SeedManager
     */
    public static SeedManager getInstance(Context context){
        if (instance == null) instance = new SeedManager(context);
        return instance;
    }

    private Context context;
    private final Network network;
    private SeedParser parser;
    private String seedUrl;
    private SeedManager(Context context){
        this.context = context;
        network = new Network();
        preferences = context.getSharedPreferences(SEED_PREFERENCE_NAME, Context.MODE_PRIVATE);
        seedRefreshedCallbacks = new HashSet<>();
        parser = new DefaultSeedParser();
        seedUrl = DEFAULT_SEED_URL;
    }

    /**
     * Callback on when the seed refresh finished.
     * @see #refreshSeed()
     */
    public interface SeedRefreshedCallback{
        /**
         * called when the seed refresh finished.
         * @param seed The Seed responsed from the sever.
         * @see #refreshSeed()
         * @see #registerRefreshCallback(SeedRefreshedCallback)
         * @see #unregisterRefreshCallback(SeedRefreshedCallback)
         * @see SeedParser
         */
        void onRefresh(Seed seed);
    }
    private Set<SeedRefreshedCallback> seedRefreshedCallbacks;

    /**
     * Set refresh callbacks.
     * If multiple callback set, all of them will be called when fresh finished.
     * @param callback
     */
    public void registerRefreshCallback(SeedRefreshedCallback callback){
        seedRefreshedCallbacks.add(callback);
    }

    /**
     * Remove the callback from the SeedManger.
     * All of the callbacks which managerCallback.equals(inputCallback) is true will be removed.
     * @param callback
     */
    public void unregisterRefreshCallback(SeedRefreshedCallback callback){
        seedRefreshedCallbacks.remove(callback);
    }

    /**
     * This interface defined the parsers for convert the response content to Seed objects.
     * For suitable different syntax response from different server, parser may have different way to parse it.
     * The basic condition is just that: the response from the server should be a text.
     */
    public interface SeedParser{
        /**
         * Parse the text string to seed object.
         * @param json The response string from the server,usually be a json string.
         * @return the Seed object.
         * @see Seed
         * @see #setSeedParser(SeedParser)
         */
        Seed parse(String json);
    }

    /**
     * Set the seed parser.
     * @see SeedParser
     * @param parser
     */
    public void setSeedParser(SeedParser parser){
        this.parser = parser;
    }

    /**
     * The server url which to get a response to generate the random seed.
     * The url should match the SeedParser.
     * The request will be a http get request without any other parameters(such as cookies, get parameter or others).
     * @param url the target url.
     * @see SeedParser
     */
    public void setSeedUrl(String url){
        seedUrl = url;
    }

    /**
     * Start refreshing the seed asynchronously.
     * When finishing, the onRefresh() of registered callbacks will be called.
     * @see SeedRefreshedCallback#onRefresh(Seed)
     */
    public void refreshSeed(){
        try {
            network.getAsync(seedUrl, networkCallback);
        } catch (Exception e) {
            WcLog.e(TAG,"refreshSeed request failed", e);
            Toast.makeText(context,"Refresh seed failed",Toast.LENGTH_LONG).show();
        }
    }

    private Network.GetAsyncCallback networkCallback = new Network.GetAsyncCallback() {
        @Override
        public void onResponse(String string, IOException e) {
            Seed newSeed = null;
            if(e != null){
                WcLog.e(TAG,"refreshSeed request error", e);
            }
            try {
                newSeed = parser.parse(string);
                if( newSeed == null ) throw new Exception("newSeed is null");
                saveSeed(newSeed);

            }catch (Exception e1){
                WcLog.e(TAG,"newSeed error:" + string, e1);
            }

            for (SeedRefreshedCallback callback:seedRefreshedCallbacks){
                callback.onRefresh(newSeed);
            }
        }
    };

    private SharedPreferences preferences;
    /**
     * Get the Seed object from the SharedPreference.
     * @return the Seed object load from SharedPreference, null if it not exist.
     */
    public synchronized Seed loadSeed(){
        String seedStr = preferences.getString(SEED_PREFERENCE_KEY_SEED, null);
        long expiredTime = preferences.getLong(SEED_PREFERENCE_KEY_EXPIREDTIME, 0);
        if(seedStr == null) return null;
        else return new Seed(seedStr,expiredTime);
    }

    /**
     * Save the Seed object into the SharedPreference.
     * Only one Seed could be save in SharedPreference.
     * @param seed the target Seed to be store.
     */
    public synchronized void saveSeed(Seed seed){
        SharedPreferences.Editor editor = preferences.edit();
        editor.putString(SEED_PREFERENCE_KEY_SEED,seed.getSeed());
        editor.putLong(SEED_PREFERENCE_KEY_EXPIREDTIME,seed.getExpiredTime());
        editor.commit();
    }
}
