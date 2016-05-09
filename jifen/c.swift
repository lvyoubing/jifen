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

  
    @IBOutlet var txtUname: UITextField!
    @IBOutlet var txtMobile: UITextField!
    @IBOutlet var score1: UITextField!
    @IBOutlet var score2: UITextField!
    var a=0
    var b=0
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

    @IBAction func onesub(sender: UIButton) {
        if(!score1.text!.isEmpty){
            b=(score1.text!as NSString).integerValue
            if b>0{
                b=b-1
                score1.text=("\(b)")
            }
            score1.text=("\(b)")
        }else
        {
            if b>0{
                b=b-1
                score1.text=("\(b)")
            }
            score1.text=("\(b)")
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