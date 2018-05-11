package me.jludden.qrcodegenerator

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.widget.Toast
import kotlinx.android.synthetic.main.activity_home.*
import com.wangjie.rapidfloatingactionbutton.RapidFloatingActionHelper
import com.wangjie.rapidfloatingactionbutton.contentimpl.labellist.RFACLabelItem
import com.wangjie.rapidfloatingactionbutton.contentimpl.labellist.RapidFloatingActionContentLabelList
import com.wangjie.rapidfloatingactionbutton.contentimpl.labellist.RapidFloatingActionContentLabelList.*

class HomeActivity : AppCompatActivity() {

    private lateinit var fabHelper: RapidFloatingActionHelper

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_home)
        setSupportActionBar(toolbar)
        setupFABmenu(applicationContext)
    }

    //Called when an item on the Floating Action Button menu is clicked
    private fun onFABmenuItemClick(position: Int) {
        when (position) {
            0 -> Toast.makeText(applicationContext, "Scanning not supported", Toast.LENGTH_SHORT).show()
            1 -> launchQRCodeGenerator()
        }
        fabHelper.collapseContent()
    }

    //Launch QRGenerator Activity
    private fun launchQRCodeGenerator() {
        val qrGenerator = Intent(this, QRGeneratorActivity::class.java)
        startActivity(qrGenerator)
    }

    //Set up the Floating Action Button menu
    //  when the Primary Floating Action button is pressed, display a menu of two buttons:
    //      Scan Code - not yet supported
    //      Generate Code - launch QRGeneratorActivity
    private fun setupFABmenu(context: Context) {
        val items = listOf<RFACLabelItem<Int>>(
                RFACLabelItem<Int>()
                        .setLabel("Scan Code")
                        .setResId(R.drawable.ic_camera)
                        .setIconNormalColor(-0x27bceb)
                        .setIconPressedColor(-0x40c9f4)
                        .setWrapper(0),
                RFACLabelItem<Int>()
                        .setLabel("Generate Code")
                        .setResId(R.drawable.ic_qr_code)
                        .setIconNormalColor(-0xb1cbd2)
                        .setIconPressedColor(-0xc1d8dd)
        )

        val rfaContent = RapidFloatingActionContentLabelList(context)
        rfaContent.setOnRapidFloatingActionContentLabelListListener(object : OnRapidFloatingActionContentLabelListListener<Int> {
            override fun onRFACItemIconClick(position: Int, item: RFACLabelItem<Int>?) = onFABmenuItemClick(position)
            override fun onRFACItemLabelClick(position: Int, item: RFACLabelItem<Int>?) = onFABmenuItemClick(position)
        })

        rfaContent
                .setItems(items)
                .setIconShadowColor(-0x777778)
        fabHelper = RapidFloatingActionHelper(context, fab_menu, fab_primary, rfaContent).build()
    }
}
