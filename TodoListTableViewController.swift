//
//  TodoListTableViewController.swift
//  todo
//
//  Created by 许 振辉 on 2017/9/24.
//  Copyright © 2017年 许 振辉. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController ,ProtocolTodoDetail{
    
    //tableView的数据
    var todolist:TypeItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置标题
        self.title = self.todolist?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (todolist!.items.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //获取cell对应的数据
        let item = todolist?.items[indexPath.row]
        //获取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        //获取label
        let label = cell.viewWithTag(1000) as! UILabel
        //设置label内容
        label.text = (item?.text)!
            + "  ：\(LevelItem.onGetTitle(level: (item?.level)!))"
        //设置cell的勾选状态
        onCheckmark(cell: cell,item:item!)
        //设置标题内容
//        cell.textLabel?.text = item?.text

        return cell
    }
    
    //设置check勾选
    func onCheckmark(cell:UITableViewCell,item:TodoItem){
        //根据Tag获取cell中的checkbox
        let check = cell.viewWithTag(1002) as! UIImageView
        //通过item中的checked属性来控制勾号是否显示
        if item.checked!{
            check.image = UIImage(named:"little_animal_07")
            
        }else{
            check.image = UIImage(named:"little_animal_08")

        }
        
        todoModel.saveData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //获取row数据
        let item = todolist?.items[indexPath.row]
        //check属性取反
        item?.onChangeChecked()
        //设置cell勾选框
        let cell = tableView.cellForRow(at: indexPath)
        onCheckmark(cell: cell!, item: item!)
        //取消选中状态
        tableView.deselectRow(at: indexPath, animated: true)
        
        }

}
