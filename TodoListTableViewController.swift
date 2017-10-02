//
//  TodoListTableViewController.swift
//  todo
//
//  Created by 许 振辉 on 2017/9/24.
//  Copyright © 2017年 许 振辉. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController ,ProtocolTodoDetail{

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置标题
        self.title = self.todolist?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
