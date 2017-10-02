//
//  TodoDetailTableViewController.swift
//  todo
//
//  Created by 许 振辉 on 2017/9/24.
//  Copyright © 2017年 许 振辉. All rights reserved.
//

import UIKit

//写这个代理协议，用于回调
protocol ProtocolTodoDetail{
    func addItem(item:TodoItem)
    func editItem()
}
class TodoDetailTableViewController: UITableViewController,ProtocolLevel,UITextFieldDelegate {

    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var labLevel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var switchControl: UISwitch!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBAction func done(_ sender: Any) {
        todoItem.text = self.textField.text!
        todoItem.shouldRemind = self.switchControl.isOn
        if isAdd{
            //新增数据
            delegate?.addItem(item: todoItem)
        }else{
            //同时修改数据中的text为文本框编辑后的内容
            delegate?.editItem()
        }
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func cancel(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    //添加还是编辑状态
    var isAdd:Bool = true
    
    //存储任务数据的变量
    var todoItem = TodoItem()
    
    //定义一个协议
    var delegate : ProtocolTodoDetail?

    override func viewDidLoad() {
        super.viewDidLoad()

        if isAdd{
            todoItem.dueDate = NSDate()
        }
        upDateDueDateLabel()
    }

    
    //更新显示时间
    func upDateDueDateLabel(){
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        self.dueDateLabel.text = formatter.string(from: todoItem.dueDate! as Date)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //显示视图的时候重新加载数据
    override func viewWillAppear(_ animated: Bool) {
        //重新加载数据
        self.tableView.reloadData()
    }
    
}
