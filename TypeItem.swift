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
    //从nsobject解析回来
    required init(coder aDecoder:NSCoder){
        self.name = aDecoder.decodeObject(forKey: "Name") as? String
        self.items = (aDecoder.decodeObject(forKey: "Items") as? [TodoItem])!
        self.icon = aDecoder.decodeObject(forKey: "Icon") as? String
    }
    
    //编码object
    func encode(with aCoder:NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(items, forKey: "Items")
        aCoder.encode(icon, forKey: "Icon")
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
