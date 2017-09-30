//
//  TypeDetailTableViewController.swift
//  todo
//
//  Created by 许 振辉 on 2017/9/20.
//  Copyright © 2017年 许 振辉. All rights reserved.
//

import UIKit


class TypeDetailTableViewController: UITableViewController ,ProtocolIconView,UITextFieldDelegate{

    @IBAction func cancel(_ sender: Any) {
        //界面跳转
        self.tabBarController?.selectedIndex = 0
        //还原成添加状态
        onAddType()
    }
    @IBAction func done(_ sender: Any) {
        //获取分类的名称
        typeItem.name = textField.text!
        
        todoModel.onAddType(type: typeItem)
         
        //界面跳转 ps:tabBar视图可以通过底部进行界面跳转，只需要改变
        //selfctedIndex的索引值就行了，0就是第一个的分类是视图，1则为添加视图
        self.tabBarController?.selectedIndex = 0
        
        
    }
    
    func onAddType(){
        //将表示设为添加任务分类状态
        isAdd = true
    }
    //编辑分类方法
    func onEditType(item:TypeItem){
        isAdd = false
       
    }
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var iconImageView: UIImageView!
    
    //设置状态，判断是添加分类还是编辑分类
    var isAdd:Bool = true
}
