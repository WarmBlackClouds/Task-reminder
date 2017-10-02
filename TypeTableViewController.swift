//
//  TypeTableViewController.swift
//  todo
//
//  Created by 许 振辉 on 2017/9/20.
//  Copyright © 2017年 许 振辉. All rights reserved.
//

import UIKit

class TypeTableViewController: UITableViewController {
    
//    //生成一个变量用来存储任务分类的数据、模拟数据
//    var typeList = [TypeItem]()
//    
//    //创建模拟数据
//    func onCreateData(){
//        for i in 1...10{
//            let name = "任务：\(i)"
//            let type =  TypeItem(name:name)
//            typeList.append(type)
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 返回10条数据
//        return 10
        return todoModel.typeList.count
    }
    
    //设置cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //获取对应的数据
        let typeItem = todoModel.typeList[indexPath.row]
        
        //为cell设置Identifier
        let cellIdentifier = "typerCell"
        //依据Identifier创建cell
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellIdentifier)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        //为cell设置标题
        cell.textLabel!.text = typeItem.name
        //设置cell的缩略图
        cell.imageView!.image = UIImage(named: typeItem.icon!)


        return cell
    }
    
        //点击cell方法
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //获取选中行的数据
        let type = todoModel.typeList[indexPath.row]
        //可以将任何东西放入sender，对应prepareforsegue中的sender
        self.performSegue(withIdentifier: "showTodoList", sender: type)

        //获取选中行的数据
//        var typeItem = todoModel.typeList[indexPath.row]
//        //视图跳转
//        self.tabBarController?.selectedIndex = 1
//        //获取添加视图的导航控制器
//        let navigation = self.tabBarController?.viewControllers?[1] as! UINavigationController
//        
//        //获取添加视图
//        let typeDetail = navigation.viewControllers.first as? TypeDetailTableViewController
//        typeDetail?.onEditType(item: typeItem)

    }
    
    
    //segue切换，传参
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //获取导航控制器
        let navigationController = segue.destination as! UINavigationController
        //获取切换目标
        let controller = navigationController.topViewController as! TodoListTableViewController
        //给目标传参数
        controller.todolist = (sender as? TypeItem)!
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
        //删除数据
        todoModel.typeList.remove(at: indexPath.row)
        //删除数据的位置标识组
        let indexPaths = [indexPath]
        //通知视图删除的数据，同时显示动画
        tableView.deleteRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
    }
    
    //滑动删除与编辑
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .default, title: "编辑") { (UITableViewRowAction, IndexPath) in
            //获取选中行的数据
            let typeItem = todoModel.typeList[indexPath.row]
            //获取添加视图的导航控制器
            let navigation = self.tabBarController?.viewControllers?[1] as! UINavigationController
            //获取添加视图
            let typeDetail = navigation.viewControllers.first as? TypeDetailTableViewController
            typeDetail?.onEditType(item: typeItem)
            
            //视图跳转
            self.tabBarController?.selectedIndex = 1
            
            
        }
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "删除") { (UITableViewRowAction, IndexPath) in
            //删除数据
            todoModel.typeList.remove(at: indexPath.row)
            //删除数据的位置标识数组
            let indexPaths = [indexPath]
            //通知视图删除的数据，同时显示删除动画
            tableView.deleteRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
        }
        //设置背景颜色
        editAction.backgroundColor = UIColor.lightGray//亮灰
        deleteAction.backgroundColor = UIColor.red//红
        return [deleteAction,editAction]
    }
}
