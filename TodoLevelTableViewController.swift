//
//  TodoLevelTableViewController.swift
//  todo
//
//  Created by 许 振辉 on 2017/9/25.
//  Copyright © 2017年 许 振辉. All rights reserved.
//

import UIKit
protocol ProtocolLevel{
    func onGetLevel(levelItem:LevelItem)
}
class TodoLevelTableViewController: UITableViewController {

    //数据源
    var arrLevel:[LevelItem] = [LevelItem]()
    var delegate:ProtocolLevel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "选择任务的重要级别"
    }

    //创建数据并设置选择的项
    func onSetCheckMark(level:Int){
        for i in 0...3{
            let item = LevelItem(level: i)
            if i == level{
                item.checkMark = true
            }
            arrLevel.append(item)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrLevel.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //获取cell对应的数据
        let item = arrLevel[indexPath.row]
        //获取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "levelCell", for: indexPath)
        cell.textLabel?.text = item.title
        
        if item.checkMark!{
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }else{
            cell.accessoryType = UITableViewCellAccessoryType.none
        }

        return cell
    }
    

    //选择单元格
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = arrLevel[indexPath.row]
        delegate?.onGetLevel(levelItem: item)
    }

}
