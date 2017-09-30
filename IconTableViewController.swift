//
//  IconTableViewController.swift
//  todo
//
//  Created by 许 振辉 on 2017/9/24.
//  Copyright © 2017年 许 振辉. All rights reserved.
//

import UIKit

//用于回调选择了图标的方法
protocol ProtocolIconView{
    //用来传递选择哪个图标
    func iconPicker(didPickIcon iconName:String)
}
class IconTableViewController: UITableViewController {

    //定义一个数组存放图标文件名
    var icons = [String]()
    //协议代理
    var delegate:ProtocolIconView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //将图标的文件名加入到icon
        icons.append("little_animal_01")
        icons.append("little_animal_02")
        icons.append("little_animal_03")
        icons.append("little_animal_04")
        icons.append("little_animal_05")
        icons.append("little_animal_06")
        icons.append("little_animal_07")
        icons.append("little_animal_08")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return icons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iconCell", for: indexPath)

        //获取图标名称
        let icon = icons[indexPath.row]
        //设置标题为图标名称
        cell.textLabel?.text = icon
        //设置缩略图
        cell.imageView?.image = UIImage(named:icon)

        return cell
    }
 

    //选择图标后
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //获取图标name
        let iconName = icons[indexPath.row]
        self.delegate?.iconPicker(didPickIcon: iconName)
        
    }
    

}
