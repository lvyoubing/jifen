//
//  ViewController.swift
//  jifen
//
//  Created by 吕欢达 on 16/5/6.
//  Copyright © 2016年 吕欢达. All rights reserved.
//

import UIKit

class c: UIViewController {
    var db:SQLiteDB!
    var a=0
    var b=0
    var c=0
    var d=0
    var e=0
    var f=0
    var time :NSTimer!
    var timer :Int = 0
    @IBOutlet var txtUname: UITextField!
    @IBOutlet var txtMobile: UITextField!
    @IBOutlet var score1: UITextField!
    @IBOutlet var score2: UITextField!
    @IBOutlet var fangui1: UITextField!
    @IBOutlet var fangui2: UITextField!
    @IBOutlet var weili1: UITextField!
    @IBOutlet var weili2: UITextField!
    @IBOutlet var huanren1: UITextField!
    @IBOutlet var huanren2: UITextField!
    @IBOutlet var time1: UILabel!
    @IBOutlet var time2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        db = SQLiteDB.sharedInstance()
        //如果表还不存在则创建表（其中uid为自增主键）
        db.execute("create table if not exists t_user(uid integer primary key,uname varchar(20),mobile varchar(20))")
        //如果有数据则加载
        initUser()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func saveClicked(sender: AnyObject) {
        saveUser()
    }

    @IBAction func start(sender: UIButton) {
        time = NSTimer.scheduledTimerWithTimeInterval(1,target:self,selector:Selector("tickDown"),userInfo:nil,repeats:true)
    }
    func tickDown()
    {
        timer++
        let sec = timer%60
        let min = timer/60
        time1.text = String(min)
        time2.text = String(sec)
        saveUser()
    }
    @IBAction func stop(sender: UIButton) {
        time.invalidate()
        saveUser()
    }
    @IBAction func one(sender: UIButton) {
        if(!score1.text!.isEmpty){
        b=(score1.text!as NSString).integerValue
        b=b+1
            score1.text=("\(b)")
        }
        else{
        b=b+1
            score1.text=("\(b)")
        }
        saveUser()
    }
    
    @IBAction func two(sender: UIButton) {
        if(!score1.text!.isEmpty){
        b=(score1.text!as NSString).integerValue
        b=b+2
            score1.text=("\(b)")
        }
        else{
            b=b+2
            score1.text=("\(b)")
        }
        saveUser()
    }
    
    @IBAction func three(sender: UIButton) {
        if(!score1.text!.isEmpty){
            b=(score1.text!as NSString).integerValue
            b=b+3
            score1.text=("\(b)")
        }
        else{
            b=b+3
            score1.text=("\(b)")
        }
        saveUser()
    }
    @IBAction func one2(sender: UIButton) {        if(!score2.text!.isEmpty){
        a=(score2.text!as NSString).integerValue
        a=a+1
        score2.text=("\(a)")
    }
    else{
        a=a+1
        score2.text=("\(a)")
        }
        saveUser()
        
    }
    
    @IBAction func two2(sender: UIButton) {
        if(!score2.text!.isEmpty){
            a=(score2.text!as NSString).integerValue
            a=a+2
            score2.text=("\(a)")
        }
        else{
            a=a+2
            score2.text=("\(a)")
        }
        saveUser()
        
    }
    @IBAction func three2(sender: UIButton) {
        if(!score2.text!.isEmpty){
            a=(score2.text!as NSString).integerValue
            a=a+3
            score2.text=("\(a)")
        }
        else{
            a=a+3
            score2.text=("\(a)")
        }
            saveUser()
    }
    
    @IBAction func fangui1(sender: UIButton) {
        if(!fangui1.text!.isEmpty){
            a=(fangui1.text!as NSString).integerValue
            a=a+1
            fangui1.text=("\(a)")
        }
        else{
            a=a+1
            fangui1.text=("\(a)")
        }
        saveUser()

    }
    @IBAction func fangui2(sender: UIButton) {
        if(!fangui2.text!.isEmpty){
            b=(fangui2.text!as NSString).integerValue
            b=b+1
            fangui2.text=("\(b)")
        }
        else{
            b=b+1
            fangui2.text=("\(b)")
        }
        saveUser()

    }
    @IBAction func weili(sender: UIButton) {
        if(!weili1.text!.isEmpty){
            c=(weili1.text!as NSString).integerValue
            c=c+1
            weili1.text=("\(c)")
        }
        else{
            c=c+1
            weili1.text=("\(c)")
        }
        saveUser()
    }
    @IBAction func weili2(sender: UIButton) {
        if(!weili2.text!.isEmpty){
            d=(weili2.text!as NSString).integerValue
            d=d+1
            weili2.text=("\(d)")
        }
        else{
            d=d+1
            weili2.text=("\(d)")
        }
        saveUser()

    }
    @IBAction func huanren1(sender: UIButton) {
        if(!huanren1.text!.isEmpty){
            e=(huanren1.text!as NSString).integerValue
            e=e+1
            huanren1.text=("\(e)")
        }
        else{
            e=e+1
           huanren1.text=("\(e)")
        }
        saveUser()
    }
    @IBAction func huanren2(sender: UIButton) {
        if(!huanren2.text!.isEmpty){
            f=(huanren2.text!as NSString).integerValue
            f=f+1
            huanren2.text=("\(f)")
        }
        else{
            f=f+1
            huanren2.text=("\(f)")
        }
        saveUser()

    }
    
      func initUser() {
        let data = db.query("select * from t_user")
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            txtUname.text = user["uname"] as? String
            txtMobile.text = user["mobile"] as? String
        }
    }
    
    //保存数据到SQLite
    func saveUser() {
        let uname = self.txtUname.text!
        let mobile = self.txtMobile.text!
        //插入数据库，这里用到了esc字符编码函数，其实是调用bridge.m实现的
        let sql = "insert into t_user(uname,mobile) values('\(uname)','\(mobile)')"
        print("sql: \(sql)")
        //通过封装的方法执行sql
        let result = db.execute(sql)
        print(result)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}