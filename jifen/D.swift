//
//  ViewController.swift
//  jifen
//
//  Created by 吕欢达 on 16/5/6.
//  Copyright © 2016年 吕欢达. All rights reserved.
//

import UIKit

class D: UIViewController {
    var db:SQLiteDB!
    
    @IBOutlet var txtUname: UITextField!
    @IBOutlet var txtMobile: UITextField!
    @IBOutlet var fscore1: UITextField!
    @IBOutlet var fscore2: UITextField!
    var b = 0
    var c = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        db = SQLiteDB.sharedInstance()
        //如果有数据则加载
        initUser()
    }
    @IBAction func saveClicked(sender: AnyObject) {
        saveUser()
    }
    @IBAction func jin1(sender: UIButton) {
        if(!fscore1.text!.isEmpty){
            b=(fscore1.text!as NSString).integerValue
            b=b+1
            fscore1.text=("\(b)")
        }
        else{
            b=b+1
           fscore1.text=("\(b)")
        }
        saveUser()
        
    }

    @IBAction func jin2(sender: UIButton) {
        if(!fscore2.text!.isEmpty){
            c=(fscore2.text!as NSString).integerValue
            c=c+1
            fscore2.text=("\(c)")
        }
        else{
            c=c+1
            fscore2.text=("\(c)")
        }
        saveUser()
        
    }
       func initUser() {
        let data = db.query("select * from t_user")
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            fscore1.text = user["uname"] as? String
            fscore2.text = user["mobile"] as? String
        }
    }
    
    //保存数据到SQLite
    func saveUser() {
        let uname = self . fscore1.text!
        let mobile = self.fscore2.text!
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