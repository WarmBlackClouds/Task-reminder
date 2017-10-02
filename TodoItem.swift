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
    
}
