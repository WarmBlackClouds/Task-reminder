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
    
    //发送通知消息
    func scheduleNotification(){
        //通过itemID获取已有的消息推送，然后删掉，以便重新判断
        let existingNotification = self.notificationForThisItem() as! UILocalNotification?
        //如果existingNotification不为nil就取消推送
        if existingNotification != nil{
            UIApplication.shared.cancelLocalNotification(existingNotification!)
        }
        //拿dueDate和NSDAte.date比较，结果是OrderedAscending，表示
        //dueDate的时间比当前的早，已经过期，不需要提醒
        //NSOrderedDescending保存的dueDate比当前时间晚
        //NSOrdereSame 跟当前时间相同
        if self.shouldRemind! && (self.dueDate?.compare(Date()) != ComparisonResult.orderedAscending){
            print("通知通知！！！")
            //创建UILocalNotification 来进行本地消息通知
            var localNotification = UILocalNotification()
            //推送时间
            localNotification.fireDate = self.dueDate as! Date
            //时区
            localNotification.timeZone = NSTimeZone.default
            //推送内容
            localNotification.alertBody = self.text
            //声音
            localNotification.soundName = UILocalNotificationDefaultSoundName
            //额外信息
            localNotification.userInfo = ["ItemID":self.itemID]
            
            UIApplication.shared.scheduleLocalNotification(localNotification)
        }
    }
    
    //通过遍历所有消息推送，通过itemid的对比返回UILocalNotification
    func notificationForThisItem() -> UILocalNotification?{
        let allNotifications = UIApplication.shared.scheduledLocalNotifications
        for notification in allNotifications!{
            var info:Dictionary<String,Int>? = notification.userInfo as? Dictionary
            var number = info?["ItemID"]
            if number != nil && number == self.itemID{
                return notification as? UILocalNotification
            }
        }
        return nil
    }
    
    //析构
    deinit {
        //删除任务消息推送
        let existingNotification = self.notificationForThisItem() as! UILocalNotification?
        if existingNotification != nil{
            UIApplication.shared.cancelLocalNotification(existingNotification!)
        }
    }
}
