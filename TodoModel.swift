//
//  TodoModel.swift
//  todo
//
//  Created by 许 振辉 on 2017/9/20.
//  Copyright © 2017年 许 振辉. All rights reserved.
//

import UIKit
//全局数据
class TodoModel: NSObject{

    //生成一个变量用来存储任务分类的数据、模拟数据
    var typeList = [TypeItem]()
    
    override init() {
        super.init()
        //初始化模拟数据
//        onCreateData()
        loadData() 
        print("沙盒文件夹路径：\(documentsDirectory())")
        print("数据文件路径：\(dataFilePath())")
    }
    
    //创建模拟数据
    func onCreateData(){
        for i in 1...10{
            let name = "任务分类：\(i)"
            let type = TypeItem(name:name)
            for j in 0...4{
                let todo = TodoItem(text: "任务清单：\(j)", checked: false, dueDate: NSDate(), shouldRemind: true, level: 0)
                type.items.append(todo)
                
            }
            typeList.append(type)
        }
    }
    
    //获得itemid
    //数据本地化之NSUserDefaults
    class func nextTodoItemId() -> Int{
        let userDefaults = UserDefaults.standard
        //获得ChecklistItemId
        let itemID = userDefaults.integer(forKey: "todoItemId")
        //+1后保存
        userDefaults.set(itemID+1, forKey: "todoItemId")
        //强制要求userDefaults立即保存
        userDefaults.synchronize()
        return itemID
    }
    
    
    //方法1：documentsDirectory获取沙盒路径
    func documentsDirectory() -> String{
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentationDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory:String = paths.first!
        return documentsDirectory
    }
    
    //方法2：dataFilePath获取数据文件地址
    func dataFilePath() -> String{
        return self.documentsDirectory().appending("todo.plist")
    }
    
    //保存数据
    func saveData(){
        let data = NSMutableData()
        //申明一个归档处理对象
        let archiver = NSKeyedArchiver(forWritingWith: data)
        //将lists以对应Checklist关键字进行编码
        archiver.encode(typeList, forKey: "todolist")
        //编码结束
        archiver.finishEncoding()
        //数据写入
        data.write(toFile: dataFilePath(), atomically: true)
        
    }
    
    //读取数据
    func loadData() {
        //获取本地数据文件地址
        let path = self.dataFilePath()
        //声明文件管理器
        let defaultManager = FileManager()
        //通过文件地址判断数据文件是否存在
        if defaultManager.fileExists(atPath: path) {
            let url = URL(fileURLWithPath: path)
            let data = try! Data(contentsOf: url)
            //解码器
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            //通过归档时设置的关键字Checklist还原lists
            typeList = unarchiver.decodeObject(forKey: "todolist") as! Array
            //结束解码
            unarchiver.finishDecoding()
        }
    }
    
    //对lists进行排序
    func sortLists(){
        typeList.sort(by: onSort)
    }
    
    func onSort(s1:TypeItem,s2:TypeItem) -> Bool{
        return s1.name! > s2.name!
    }
}

//创建全局数据
var todoModel = TodoModel()


