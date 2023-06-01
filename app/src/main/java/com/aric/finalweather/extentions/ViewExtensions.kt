package com.aric.finalweather.extentions

import android.content.Intent
import android.os.Bundle
import android.text.Html
import android.view.inputmethod.InputMethodManager
import android.widget.TextView
import androidx.annotation.IdRes
import androidx.annotation.NavigationRes
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentActivity
import androidx.navigation.NavController
import androidx.navigation.NavGraph
import androidx.navigation.Navigation
import com.aric.finalweather.base.FixFragmentNavigator
import com.aric.finalweather.base.KEY_NAVIGATION_START_LABEL

fun TextView.setTextHTML(html: String) {
    text = Html.fromHtml(html, Html.FROM_HTML_MODE_LEGACY)
}

fun FragmentActivity.setupNavigationController(
    @IdRes viewId: Int,
    @NavigationRes graphResId: Int,
    navControllerCallBack: (NavController) -> Unit
): NavController {
    val fragment = supportFragmentManager.findFragmentById(viewId)
    val fragmentNavigator = FixFragmentNavigator(this, supportFragmentManager, fragment!!.id)
    val navController = Navigation.findNavController(this, viewId)
    navController.navigatorProvider.addNavigator(fragmentNavigator)
    val navGraph: NavGraph = navController.navInflater.inflate(graphResId)
    navGraph.find { it.label == intent.getString(KEY_NAVIGATION_START_LABEL) }.notNull {
        navGraph.startDestination = it.id
    }
    navController.graph = navGraph
    navControllerCallBack(navController)
    return navController
}


fun Intent.getString(key: String, defaultValue: String = ""): String = if (hasExtra(key)) {
    getStringExtra(key).notNull {
        it.isBlank().isTrue {
            defaultValue
        }.otherwise {
            it
        }
    }.otherwise {
        defaultValue
    }
} else {
    defaultValue
}

fun Fragment.navigateTo(navId: Int, navHostName: Int, navArgs: Bundle? = null) =
    with(Navigation.findNavController(requireActivity(), navHostName)) {
        currentDestination?.getAction(navId)?.let {
            navigate(navId, navArgs)
        }
    }


fun AppCompatActivity.hideKeyboard() {
    val imm = this.getSystemService(AppCompatActivity.INPUT_METHOD_SERVICE) as InputMethodManager
    val v = this.window.peekDecorView()
    if (null != v) {
        imm.hideSoftInputFromWindow(v.windowToken, 0)
    }
}

fun Fragment.hideKeyboard() {
    val imm = requireActivity().getSystemService(AppCompatActivity.INPUT_METHOD_SERVICE) as InputMethodManager
    val v = requireActivity().window.peekDecorView()
    if (null != v) {
        imm.hideSoftInputFromWindow(v.windowToken, 0)
    }
}