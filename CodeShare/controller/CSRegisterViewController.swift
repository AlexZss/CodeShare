//
//  CSRegisterViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/11.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit
import SnapKit
import JKCategories
import Alamofire

class CSRegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "注册"
        // Do any additional setup after loading the view.
        
        //注册名字
        let registerName = UITextField.init()
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
        testMessage.font = UIFont.systemFontOfSize(15)
        testMessage.backgroundColor = UIColor.whiteColor()
        testMessage.layer.backgroundColor = UIColor.whiteColor().CGColor
        testMessage.layer.borderWidth = 1.0
        self.view.addSubview(testMessage)
        testMessage.snp_makeConstraints { (make) in
            make.top.equalTo(registerPassword.snp_bottom).offset(10)
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
        messageBtn.setTitleColor(UIColor.orangeColor(), forState: .Normal)
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
        messageBtn.jk_addActionHandler { (message) in
            
        }
        //注册按钮
        let register = UIButton()
        
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
            make.top.equalTo(testMessage.snp_bottom).offset(120)
            make.height.equalTo(48)
        }
        //注册按钮的响应事件
        //service=User.Register&phone=18289568927&password=123456&verificationCode=1234
        register.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            
            Alamofire.request(.POST, "https://www.1000phone.tk", parameters: [
                "service": "User.Register",
                "phone": registerName.text!,
                "password": registerPassword.text!,
                "verificationCode": testMessage.text!
                ], encoding: ParameterEncoding.URLEncodedInURL, headers: nil).responseJSON(completionHandler: { (response) in
                    //请求成功
                    if response.result.isSuccess {
                        print(response.result.value!)
                        //注册成功，返回登陆界面
                        self.navigationController?.popViewControllerAnimated(true)
                    }else {
                        print("网络不通畅，请稍后再试")
                    }
                })
            
        }


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
