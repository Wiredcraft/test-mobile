/*
 * Copyright (C) 2008 ZXing authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package test.wiredcraft.whitecomet.barcoder.wbarcoder.capture;

import test.wiredcraft.whitecomet.barcoder.wbarcoder.capture.camera.FrontLightMode;

/**
 * The main settings activity.
 *
 * @author dswitkin@google.com (Daniel Switkin)
 * @author Sean Owen
 */
public final class PreferencesConstants {

  public static final boolean KEY_DECODE_1D_PRODUCT = true;
  public static final boolean KEY_DECODE_1D_INDUSTRIAL = true;
  public static final boolean KEY_DECODE_QR = true;
  public static final boolean KEY_DECODE_DATA_MATRIX = true;
  public static final boolean KEY_DECODE_AZTEC = false;
  public static final boolean KEY_DECODE_PDF417 = false;

  public static final String KEY_CUSTOM_PRODUCT_SEARCH = "preferences_custom_product_search";

  public static final boolean KEY_PLAY_BEEP = true;
  public static final boolean KEY_VIBRATE = false;
  public static final boolean KEY_COPY_TO_CLIPBOARD = true;
  public static final FrontLightMode KEY_FRONT_LIGHT_MODE = FrontLightMode.OFF;
  public static final String KEY_BULK_MODE = "preferences_bulk_mode";
  public static final String KEY_REMEMBER_DUPLICATES = "preferences_remember_duplicates";
  public static final String KEY_ENABLE_HISTORY = "preferences_history";
  public static final String KEY_SUPPLEMENTAL = "preferences_supplemental";
  public static final boolean KEY_AUTO_FOCUS = true;
  public static final boolean KEY_INVERT_SCAN = false;
  public static final String KEY_SEARCH_COUNTRY = "preferences_search_country";
  public static final boolean KEY_DISABLE_AUTO_ORIENTATION = true;

  public static final boolean KEY_DISABLE_CONTINUOUS_FOCUS = true;
  public static final boolean KEY_DISABLE_EXPOSURE = true;
  public static final boolean KEY_DISABLE_METERING = true;
  public static final boolean KEY_DISABLE_BARCODE_SCENE_MODE = true;
  public static final String KEY_AUTO_OPEN_WEB = "preferences_auto_open_web";

}
