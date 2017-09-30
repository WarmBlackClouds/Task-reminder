//
//  TypeTableViewController.swift
//  todo
//
//  Created by 许 振辉 on 2017/9/20.
//  Copyright © 2017年 许 振辉. All rights reserved.
//

import UIKit

class TypeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 返回10条数据
        return 10
    }
    
    //设置cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //为cell设置Identifier
        let cellIdentifier = "typerCell"
        //依据Identifier创建cell
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellIdentifier)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        //为cell设置标题
        cell.textLabel!.text = "typeCell"
        //设置cell的缩略图
        cell.imageView!.image = UIImage(named: "xxx")


        return cell
    }
}
