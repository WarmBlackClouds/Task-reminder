//
//  TodoItem.swift
//  todo
//
//  Created by 许 振辉 on 2017/9/24.
//  Copyright © 2017年 许 振辉. All rights reserved.
//

import UIKit

class TodoItem: NSObject, NSCoding {

    //任务名称
    var text:String?
    //是否完成
    var checked:Bool?
    //提醒时间
    var dueDate:NSDate?
    //是否提醒
    var shouldRemind:Bool?
    //任务id
    var itemID:Int?
    //级别
    var level:Int? = 0
    //构造方法
    init(text:String = "",checked:Bool = false,dueDate:NSDate = NSDate(),shouldRemind:Bool = false,level:Int = 0) {
        self.text = text
        self.checked = checked
        self.dueDate = dueDate
        self.shouldRemind = shouldRemind
        self.itemID = TodoModel.nextTodoItemId()
        self.level = level
        super.init()
    }
    //设置是否完成属性
    func onChangeChecked(){
        self.checked = !self.checked!
    }
    
    //从nsobject解析回来
    required init(coder aDecoder:NSCoder){
        self.text = aDecoder.decodeObject(forKey: "Text") as? String
        self.checked = aDecoder.decodeObject(forKey: "Checked") as? Bool
        self.dueDate = aDecoder.decodeObject(forKey: "DueDate") as? NSDate
        self.shouldRemind = aDecoder.decodeObject(forKey: "ShouldRemind") as? Bool
        self.itemID = aDecoder.decodeObject(forKey: "ItemID") as? Int
        self.level = aDecoder.decodeObject(forKey: "level") as? Int
        
    }
    
    //编码object
    func encode(with aCoder:NSCoder){
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
        aCoder.encode(dueDate,forKey:"DueDate")
        aCoder.encode(shouldRemind,forKey:"ShouldRemind")
        aCoder.encode(itemID,forKey:"ItemID")
        aCoder.encode(level,forKey:"level")
    }
}
