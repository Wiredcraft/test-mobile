package www.wiredcraft.testmobile.base

import androidx.recyclerview.widget.RecyclerView
import androidx.viewbinding.ViewBinding

/**
 *@Description:
 * # binding holder 封装
 * @param viewBinding
 * #0000      @Author: tianxiao     2022/3/31      onCreate
 */
class BindingViewHolder<T : ViewBinding>(val viewBinding: T) : RecyclerView.ViewHolder(viewBinding.root)