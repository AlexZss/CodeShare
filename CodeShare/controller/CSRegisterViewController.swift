//
//  CSRegisterViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/11.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit
//约束
import SnapKit
//jk_addTarget
import JKCategories
import Alamofire
//订阅并注册的方法
import ReactiveCocoa

class CSRegisterViewController: ViewController {

    dynamic var time = -1
    var timer: NSTimer!
    
    var text1 = false
    var text2 = false
    var text3 = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "注册"
        // Do any additional setup after loading the view.
        
        //注册名字
        let registerName = UITextField.init()
        //registerName.delegate = self
        registerName.tag = 100
        registerName.placeholder = "请输入邮箱或者手机号"
        registerName.font = UIFont.systemFontOfSize(15)
        registerName.backgroundColor = UIColor.whiteColor()
        registerName.layer.backgroundColor = UIColor.whiteColor().CGColor
        registerName.layer.borderWidth = 1.0
        self.view.addSubview(registerName)
        registerName.snp_makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(48)
        }
        //注册密码
        let registerPassword = UITextField.init()
        registerPassword.placeholder = "请输入密码"
        registerPassword.secureTextEntry = true
        //registerPassword.delegate = self
        registerPassword.tag = 101
        registerPassword.font = UIFont.systemFontOfSize(15)
        registerPassword.backgroundColor = UIColor.whiteColor()
        registerPassword.layer.backgroundColor = UIColor.whiteColor().CGColor
        registerPassword.layer.borderWidth = 1.0
        self.view.addSubview(registerPassword)
        registerPassword.snp_makeConstraints { (make) in
            make.top.equalTo(registerName.snp_bottom)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(48)
        }
        //注册用户图片
        let nameLeft = UIView()
        let nameImage = UIImageView(image: UIImage(named: "手机邮箱图标"))
        nameLeft.addSubview(nameImage)
        registerName.leftViewMode = .Always
        registerName.leftView = nameLeft
        nameLeft.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(56, 48))
        }
        nameImage.snp_makeConstraints { (make) in
            make.center.equalTo(0)
        }
        //注册密码图片
        let passwordLeft = UIView()
        let passwordImage = UIImageView(image: UIImage(named: "新密码图标"))
        passwordLeft.addSubview(passwordImage)
        registerPassword.leftViewMode = .Always
        registerPassword.leftView = passwordLeft
        passwordLeft.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(56, 48))
        }
        passwordImage.snp_makeConstraints { (make) in
            make.center.equalTo(0)
        }
        //短信
        let testMessage = UITextField()
        testMessage.placeholder = "请输入验证码"
        //testMessage.delegate = self
        testMessage.tag = 102
        testMessage.font = UIFont.systemFontOfSize(15)
        testMessage.backgroundColor = UIColor.whiteColor()
        testMessage.layer.backgroundColor = UIColor.whiteColor().CGColor
        testMessage.layer.borderWidth = 1.0
        self.view.addSubview(testMessage)
        testMessage.snp_makeConstraints { (make) in
            make.top.equalTo(registerPassword.snp_bottom).offset(12)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(48)
        }
        //短信图片
        let messageLeft = UIView()
        let messageImage = UIImageView(image: UIImage(named: "验证信息图标"))
        messageLeft.addSubview(messageImage)
        testMessage.leftViewMode = .Always
        testMessage.leftView = messageLeft
        messageLeft.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(56, 48))
        }
        messageImage.snp_makeConstraints { (make) in
            make.center.equalTo(0)
        }
        
        let messageRight = UIView()
        let messageBtn = UIButton(type: .Custom)
        messageBtn.setTitle("获取验证码", forState: .Normal)
        messageBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        messageBtn.setTitleColor(UIColor.greenColor(), forState: .Normal)
        messageBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
        messageBtn.layer.borderWidth = 1.0
        //设置视图的圆角
        messageBtn.layer.cornerRadius = 3.0
        //设置让背景颜色在视图的范围内
        messageBtn.layer.masksToBounds = true
        messageBtn.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: .Disabled)
        messageBtn.jk_setBackgroundColor(UIColor.whiteColor(), forState: .Normal)
        messageBtn.jk_setBackgroundColor(UIColor.darkGrayColor(), forState: .Highlighted)
        testMessage.rightView = messageRight
        testMessage.rightViewMode = .Always
        messageRight.snp_makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(110)
        }
        messageRight.addSubview(messageBtn)
        messageBtn.snp_makeConstraints { (make) in
            make.center.equalTo(0)
            make.left.equalTo(8)
            make.top.equalTo(4)
        }
        messageBtn.jk_handleControlEvents(.TouchUpInside) { (sender)
            in
            //点击完不可用
            //messageBtn.enabled = false
            self.time = 60
            self.timer = NSTimer.jk_scheduledTimerWithTimeInterval(1.0, block: {
                self.time = self.time - 1
                }, repeats: true) as! NSTimer
            //获取验证码
            SMSSDK.getVerificationCodeByMethod(SMSGetCodeMethod.init(1), phoneNumber: registerName.text, zone: "86", customIdentifier: nil) { (error) in
                print(error)
                //因为只是测试，没有打开真实的返回
//                if (error != nil) {
                    //print(error)
                    //messageBtn.enabled = true
//                    将time重新设置为-1
//                    self.time = -1
                //}else {
                    //读秒
                    //var time = 60
                
//                }
            }
        }
       
        //注册按钮
        let register = UIButton()
        register.tag = 1000
        register.titleLabel?.font = UIFont.systemFontOfSize(15)
        register.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        register.setTitle("注册", forState: UIControlState.Normal)
        
        //设置登录按钮的三种不同状态下的背景颜色
        register.jk_setBackgroundColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        self.view.addSubview(register)
        register.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: UIControlState.Disabled)
        register.jk_setBackgroundColor(UIColor.darkGrayColor(), forState: UIControlState.Highlighted)
                register.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(testMessage.snp_bottom).offset(200)
            make.height.equalTo(48)
        }
        //注册按钮的响应事件
        //service=User.Register&phone=18289568927&password=123456&verificationCode=1234
        register.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            
//            Alamofire.request(parameters: [
//                "service": "User.Register",
//                "phone": registerName.text!,
//                "password": (registerPassword.text! as NSString).jk_md5String,
//                "verificationCode": testMessage.text!
//                ], encoding: ParameterEncoding.URLEncodedInURL, headers: nil).responseJSON(completionHandler: { (response) in
//                    //请求成功
//                    if response.result.isSuccess {
//                        print(response.result.value!)
//                        //注册成功，返回登陆界面
//                        self.navigationController?.popViewControllerAnimated(true)
//                    }else {
//                        print("网络不通畅，请稍后再试")
//                    }
//                })
            CSNetHelp.request( parmaters: [
                "service": "User.Register",
                "phone": registerName.text!,
                "password": (registerPassword.text! as NSString).jk_md5String,
                "verificationCode": testMessage.text!
                ]).responseJSON { (data, success) in
                    if success {
                        print(data)
                        self.navigationController?.popViewControllerAnimated(true)
                    }else {
                        UIAlertView(title: "错误", message: data as? String, delegate: nil, cancelButtonTitle: "确定").show()
                    }
            }
        }
        
        //
        messageBtn.enabled = false
        register.enabled = false
        //UITextField继承于UIControl有addtraget方法 ，或者UITextField的代理啊方法
        //类似于 addTarget 使用第三方库的写发
        //  registerName.jk_handleControlEvents(UIControlEvents.EditingChanged) { (sender)
        //        in
        //  messageBtn.enabled = registerName.text?.lengthOfBytesUsingEncoding(NSStringEncoding.init(NSUTF8StringEncoding)) == 11
        //  }
        
        registerName.rac_textSignal().subscribeNext { (sender) in
            let name = sender as! NSString
            //两个条件决定获取验证码按钮的状态
            messageBtn.enabled = name.length == 11 &&  self.time == -1
            if name.length >= 11 {
                //registerPassword.becomeFirstResponder()               //???
            }
        }

        //将几个信号合并为一个信号,订阅并改变注册按钮的状态
        //冷信号 
        //combine(使结合) subscribe(订购，订阅)



        
        registerName.rac_textSignal()
        .combineLatestWith(registerPassword.rac_textSignal())
        .combineLatestWith(testMessage.rac_textSignal())
        .subscribeNext { (sender) in
            register.enabled =
                ((registerName.text! as NSString).length == 11 &&
                (registerPassword.text! as NSString).length >= 6 &&
                (testMessage.text! as NSString).length == 4)
        }
 
 
 
 
        //热信号
    //        registerName.rac_textSignal().toSignalProducer()
    //        .combineLatestWith(registerPassword.rac_textSignal().toSignalProducer())
    //        .combineLatestWith(testMessage.rac_textSignal().toSignalProducer())
    //        .startWithNext { (singnal1, singnal2)
    //            in
    //            print("singnal1:\(singnal1)  singnal2:\(singnal2)")
    //        }
        
        //按钮的点击事件当作信号来订阅(代替addTarget)
        register.rac_signalForControlEvents(UIControlEvents.TouchUpInside)
        .subscribeNext { (sender) in
            //print(sender as! UIButton)
        }
        //register.jk_handleControlEvents(.TouchUpInside) { (sender) in  }
        
        //将变量的改变当作信号亮来订阅(代替 kvo)
        //使用MVC思想，如果数据变了，界面也需要改变
        self.rac_valuesForKeyPath("time", observer: self).subscribeNext { (time) in
            //print(time)
            //关闭定时器且重置button
            messageBtn.enabled = self.time == -1
            if self.time == -1 {
                if self.timer != nil {
                    self.timer.invalidate()
                }
                messageBtn.setTitle("获取验证码", forState: .Normal)
            }else {
                messageBtn.setTitle("还剩\(self.time)秒", forState: .Normal)
            }
            
        }
        //处理键盘遮挡试图的问题 (代替通知)
        //NSNotificationCenter.defaultCenter().addObserver(UIKeyboardWillChangeFrameNotification, selector: "jianpan", name: "time", object: nil)
        NSNotificationCenter.defaultCenter().rac_addObserverForName(UIKeyboardWillChangeFrameNotification, object: nil)
        .subscribeNext { (notif) in
            //print(notif) nitif 包含了所有的通知信息
            //取出通知携带的键盘信息
            //let userInfo = (notif as! NSNotification).userInfo!
            //
            //let rect = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
            //print(rect.CGRectValue())
            
            //用 SnapKit 给注册按钮做一个动画
            register.snp_updateConstraints(closure: { (make) in
                make.top.equalTo(testMessage.snp_bottom).offset(50)
            })
            //添加动画
            UIView.animateWithDuration(0.25, animations: { 
                register.layoutIfNeeded() //如果需要，重新布局
            })
        }
        
        NSNotificationCenter.defaultCenter().rac_addObserverForName(UIKeyboardWillHideNotification, object: nil)
        .subscribeNext { (notif) in
            //当键盘消失
            register.snp_updateConstraints(closure: { (make) in
                make.top.equalTo(testMessage.snp_bottom).offset(200)
            })
            //添加动画
            UIView.animateWithDuration(0.25, animations: {
                register.layoutIfNeeded() //如果需要，重新布局
            })
        }
    }
    //全屏按钮成为响应者  回收键盘
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CSRegisterViewController: UITextFieldDelegate {
    
    /*
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        print(range.location)
        print(range.length)
        print(textField.text?.characters.count)
        print("")
        
        let registerBtn =  self.view.viewWithTag(1000) as! UIButton
        if textField.tag == 100{
            if range.location == 10{
                text1 = true
            }else {
                text1 = false
            }
        }else if textField.tag == 101 {
            if range.location >= 5{
                text2 = true
            }else {
                text2 = false
            }
        }else if textField.tag == 102 {
            if range.length == 0{
                if range.location == 3{
                    text3 = true
                }else {
                    text3 = false
                }
            }else{
                if range.location == 4{
                    text3 = true
                }else {
                    text3 = false
                }
            }
        
        }
        
        
        if text1 == true && text2 == true && text3 == true {
            print("true")
            registerBtn.enabled = true
        }else {
            print("false")
            registerBtn.enabled = false
        }
        
        
        /*
        let textField1 = (self.view.viewWithTag(100) as! UITextField).text! as NSString
        let textField2 = (self.view.viewWithTag(101) as! UITextField).text! as NSString
        let textField3 = (self.view.viewWithTag(102) as! UITextField).text! as NSString
        
        print(textField3)
        
        let registerBtn =  self.view.viewWithTag(1000) as! UIButton
        
        print("\(textField1.length)   \(textField2.length)   \(textField3.length)")
        
        if (textField1.length >= 10) && (textField2.length >= 5) && (textField3.length >= 3) {
            print("yesyesyes")
            registerBtn.enabled = true
        }else{
            print("nonononono")
            registerBtn.enabled = false
        }
        */
        
        /*
        let str = textField.text! as NSString
        
        print(range.length) //改变字符串的长度 如果删除n个字符，则返回n
        print(range.location) //被改变字符的所在位置

        if range.length == 1{
            return true
        }
    
        if str.length == 11{
            textField
            print("chage")
            return false
        }
        */
     
        return true
        
    }
 */

}