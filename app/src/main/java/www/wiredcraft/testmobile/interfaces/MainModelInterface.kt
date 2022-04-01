package www.wiredcraft.testmobile.interfaces

import www.wiredcraft.testmobile.api.model.Item


/**
 *@Description:
 * # 主页接口
 * #0000      @Author: tianxiao     2022/3/31      onCreate
 */
interface MainModelInterface {

    /**
     * @param item 数据
     * @param position 索引
     */
    fun StartActivityUserDetailsForResult(item: Item, position: Int)

}