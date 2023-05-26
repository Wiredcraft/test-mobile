package com.aric.finalweather.extentions

import android.os.Build
import android.text.Html
import android.widget.TextView

fun TextView.setTextHTML(html: String) {
    text = Html.fromHtml(html, Html.FROM_HTML_MODE_LEGACY)
}