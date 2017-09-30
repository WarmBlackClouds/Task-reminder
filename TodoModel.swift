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
    
    //构造方法
    override init() {
        super.init()
        //初始化模拟数据
        onCreateData()
    }
    
    //创建模拟数据
    func onCreateData(){
        for i in 1...10{
            let name = "任务：\(i)"
            let type =  TypeItem(name:name)
            typeList.append(type)
        }
    }
    
}

//创建全局数据
var todoModel = TodoModel()


