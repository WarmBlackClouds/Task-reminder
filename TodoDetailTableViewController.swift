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
    
    //声明一个变量来记录日期选择器的显示状态
    var datePickerVisible:Bool = false
    
    //ProtocolLevel协议所要实现的方法
    func onGetLevel(levelItem: LevelItem) {
        //更新重要级别的文本标签
        labLevel.text = levelItem.title
        //更新todoItem中的级别
        todoItem.level = levelItem.level
        //关闭选择级别界面
        self.navigationController?.popViewController(animated: true)
    }
    //连线跳转
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //获取跳转目标
        let controller = segue.destination as! TodoLevelTableViewController
        //设置代理
        controller.delegate = self
        //传参并生成数据源
        controller.onSetCheckMark(level: self.todoItem.level!)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if isAdd{
            todoItem.dueDate = NSDate()
        }else{
            self.title = "编辑任务"
            textField.text = todoItem.text
            switchControl.isOn = todoItem.shouldRemind!
        }
        
        //显示级别
        labLevel.text = LevelItem.onGetTitle(level: todoItem.level!)
        //任务名称文本框获得焦点
        textField.becomeFirstResponder()
        //设置textField的代理
        textField.delegate = self
        //当状态是添加任务时，确认按钮默认不激活
        doneButton.isEnabled = false
        upDateDueDateLabel()
    }

    //文本框内容残生变化的响应方法
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //获得文本框最新的文本
        let newText = textField.text?.replacingCharacters(in: range.toRange(string: textField.text!), with: string)
        //通过计算文本框的字符数来决定done按钮是否激活
        doneButton.isEnabled = (newText?.characters.count)! > 0
        return true
    }
    
    //更新显示时间
    func upDateDueDateLabel(){
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        self.dueDateLabel.text = formatter.string(from: todoItem.dueDate! as Date)
    }
    
    //显示日期选择器
    func showDatePicker(){
        //状态打开
        datePickerVisible = true
        let indexPathDatePicker = NSIndexPath(row: 3, section: 1)
        self.tableView.insertRows(at: [indexPathDatePicker as IndexPath], with: .automatic)
    }
    
    
    //隐藏日期选择器
    func hideDatePicker(){
        if datePickerVisible{
            //状态设为关闭
            datePickerVisible = false
            let indexPathDatePicker = NSIndexPath(row: 3, section: 1)
            self.tableView.deleteRows(at: [indexPathDatePicker as IndexPath], with: .fade)
        }
    }
    
    //选择cell的row后
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        textField.resignFirstResponder()
        //当执行到日期选择器上一行的时候，可以判断是否要显示日期选择器了
        if indexPath.section == 1 && indexPath.row == 2{
            if !datePickerVisible{
                self.showDatePicker()
            }else{
                self.hideDatePicker()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //因为日期选择器的位置在日期显示下面。它的位置就是第二个section和第三个row
        if indexPath.section == 1 && indexPath.row == 3 {
            //用重用的方式获取表示为DatePickerCell的cell
            var cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell") 
            //如果没有就创建一个
            if cell == nil{
                //创建一个表示为DatePickerCell的cell
                cell = UITableViewCell(style: .default, reuseIdentifier: "DatePickerCell")
                //设置cell样式
                cell?.selectionStyle = UITableViewCellSelectionStyle.none
                //创建日期选择器
                let datePicker = UIDatePicker(frame: CGRect(x: 0.0, y: 0.0, width: 320.0, height: 216.0))
                //给日期选择器的tag
                datePicker.tag = 100
                //将日期选择器加入cell
                cell?.contentView.addSubview(datePicker)
                //注意：action里面的方法名后面需要加个冒号"："
                datePicker.addTarget(self, action: #selector(self.dateChanged), for: UIControlEvents.valueChanged)
            }
            return cell!
        }else{
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
        
    }
    //日期选择器响应方法
    func dateChanged(datePicker:UIDatePicker){
        //改变dueDate
        todoItem.dueDate = datePicker.date as NSDate
        //更新提醒时间文本框
        upDateDueDateLabel()
    }
    //因为日期选择器插入后会引起cell高度的变化，所以要重新设置
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //当渲染到日期选择器所在的cell的时候
        if indexPath.section == 1 && indexPath.row == 3 {
            return 217.0
        }else{
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }

    //当覆盖了静态的cell数据源方法时需要提供一个代理方法。因为数据源对新加进来的日期选择器的cell一无所知，所以要使用这个代理方法
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        if indexPath.section == 1 && indexPath.row == 3 {
            //当执行到日期选择器所在的indexpath就创建一个indexPath然后强插
            let newIndexPath = NSIndexPath(row: 0, section: indexPath.section)
            return super.tableView(tableView, indentationLevelForRowAt: newIndexPath as IndexPath)
        }else{
            return super.tableView(tableView, indentationLevelForRowAt: indexPath)
        }
    }
    
    //根据日期选择器日期的隐藏与否决定返回的row数量
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 && datePickerVisible{
            return 4
        }else{
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
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
