//
//  TypeDetailTableViewController.swift
//  todo
//
//  Created by 许 振辉 on 2017/9/20.
//  Copyright © 2017年 许 振辉. All rights reserved.
//

import UIKit

//扩展NSRange,让swift的string能使用stringByReplacingCharactersInRange
extension NSRange{
    func toRange(string:String) -> Range<String.Index>{
        
        let startIndex = string.index(string.startIndex, offsetBy: self.location)
        let endIndex = string.index(startIndex, offsetBy: self.length)
        return startIndex..<endIndex
    }
}

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
        
        if isAdd{
            //将新的分类加紧分类数组
            todoModel.onAddType(type: typeItem)
            
        }else{
            //获取任务分类师徒的导航控制器
            let navigation = self.tabBarController?.viewControllers?[0] as! UINavigationController
            //获取任务分类视图
            let typeView = navigation.viewControllers.first as? TypeTableViewController
            //更新任务分类视图的数据
            typeView?.tableView.reloadData()
        }
        //界面跳转 ps:tabBar视图可以通过底部进行界面跳转，只需要改变
        //selfctedIndex的索引值就行了，0就是第一个的分类是视图，1则为添加视图
        self.tabBarController?.selectedIndex = 0
        
        //还原成添加状态
        onAddType()
        //排序
        todoModel.sortLists()
        //保存数据
        todoModel.saveData()
        
    }
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var iconImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置文本框代理
        textField.delegate = self
//        isLoad = true
//        onUpdate()
    }
    //定义一个TypeItem
    var typeItem:TypeItem = TypeItem(name: "")
    //设置状态，判断是添加分类还是编辑分类
    var isAdd:Bool = true
    
    func onAddType(){
        //将表示设为添加任务分类状态
        isAdd = true
        //将typeItem设为新的空数据
        typeItem = TypeItem(name:"")
        //设置视图标题
        self.title = "添加"
        //执行更新方法
  //      onUpdate()
    }
    
    //判断视图是否加载过
    var isLoad = true
    
    //编辑分类方法
    func onEditType(item:TypeItem){
        isAdd = false
        
        //设置标题
        self.title = "编辑分类"
        //接收传送过来的分类数据
        self.typeItem = item
        //如果视图没加载过则放入viewdidLoad进行
//        if isLoad{
//            onUpdate()
 //      }
    }
    
    func onUpdate(){
        self.textField?.text = typeItem.name
    }
    //实现protocolIconView协议中的iconPicker方法
    //设置图标
    func iconPicker(didPickIcon iconName: String) {
        typeItem.icon = iconName
        iconImageView.image = UIImage(named: iconName)
        //关闭选择图标界面
        self.navigationController?.popViewController(animated: true)
    }
    //检测界面切换
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //获取切换目标
        let controller = segue.destination as! IconTableViewController
        //设置代理
        controller.delegate = self
    }
    //界面加载结束后会执行的方法
    override func viewWillAppear(_ animated: Bool) {
        onUpdate()
        //文本框获取焦点
        textField.becomeFirstResponder()
        if isAdd{
            doneButton.isEnabled = false
        }else{
            doneButton.isEnabled = true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //获得文本框最新的文本
        let newText = textField.text?.replacingCharacters(in: range.toRange(string: textField.text!), with: string)
        //通过计算文本框的字符数来决定done按钮是否激活
        doneButton.isEnabled = (newText?.characters.count)! > 0
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
