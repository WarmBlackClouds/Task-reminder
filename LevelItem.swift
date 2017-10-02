//
//  LevelItem.swift
//  todo
//
//  Created by 许 振辉 on 2017/9/25.
//  Copyright © 2017年 许 振辉. All rights reserved.
//

import UIKit

class LevelItem {

    //重视程度
    var level:Int? = 0
    //重视程度的标题
    var title:String? = ""
    //cell是否勾选情况
    var checkMark:Bool? = false
    init(level:Int) {
        self.level = level
        self.title = LevelItem.onGetTitle(level: level)
    }
    
    class func onGetTitle(level:Int) -> String{
        var title:String = ""
        switch level{
        case 0:
            title = "非常重要"
        case 1:
            title = "很重要"
        case 2:
            title = "重要"
        case 3:
            title = "一般"
        default:
            title = "非常重要"
        }
        return title
    }
}
