//
//  TypeItem.swift
//  todo
//
//  Created by 许 振辉 on 2017/9/20.
//  Copyright © 2017年 许 振辉. All rights reserved.
//

import UIKit

class TypeItem: NSObject, NSCoding{
    //任务分类的名称
    var name :String? = ""
    //分类图标
    var icon: String? = "little_animal_06"
    //任务清单数据，数组变量用来存储数据
    var items = [TodoItem]()
    
    //构造方法
    init(name:String) {
        super.init()
        self.name = name
    }
    
    //计算该类任务 还有多少item没有勾选，也就是还没办需要提醒
    func countUncheckedItems() -> Int{
        var count = 0
        for item in items{
            if item.checked != true{
                count += 1
            }
        }
        return count
    }
}
