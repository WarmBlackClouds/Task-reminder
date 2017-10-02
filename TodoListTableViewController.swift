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

        //设置标题内容
        cell.textLabel?.text = item?.text

        return cell
    }
}
