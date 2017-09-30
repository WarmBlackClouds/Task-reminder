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
        onCreateData()
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
}
