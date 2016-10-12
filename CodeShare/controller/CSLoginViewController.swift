//
//  CSLoginViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/11.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit
import SnapKit
import JKCategories
import Alamofire

class CSLoginViewController: UIViewController {

    let userName = UITextField.init()
    let password = UITextField.init()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "登录"
        self.view.backgroundColor = UIColor.whiteColor()
        
        //
        userName.placeholder = "请输入邮箱或者手机号码"
        userName.font = UIFont.systemFontOfSize(15)
        userName.backgroundColor = UIColor.whiteColor()
        
        //使用snapKit或者masonry怎么样给视图添加约束
        self.view.addSubview(userName)
        //设置约束
        userName.snp_makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(48)
        }
        //设置边框
        userName.layer.borderColor = UIColor.grayColor().CGColor
        userName.layer.borderWidth = 1.0
        
        //设置密码
        password.placeholder = "请输入密码"
        password.font = UIFont.systemFontOfSize(15)
        password.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(password)
        //设置约束
        password.snp_makeConstraints { (make) in
            make.top.equalTo(userName.snp_bottom)
            make.left.right.equalTo(0)
            make.height.equalTo(48)
        }
        //设置边框
        password.layer.borderColor = UIColor.grayColor().CGColor
        password.layer.borderWidth = 1.0
        
        //photo
        let nameLeft = UIView.init()
        let passLeft = UIView.init()
        
        let nameImage = UIImageView.init(image: UIImage.init(named: "用户图标"))
        nameLeft.addSubview(nameImage)
        
        userName.leftViewMode = .Always
        userName.leftView = nameLeft
        nameLeft.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(56, 48))
        }
        nameImage.snp_makeConstraints { (make) in
            make.center.equalTo(0)
        }
        
        let passImage = UIImageView.init(image: UIImage.init(named: "密码图标"))
        passLeft.addSubview(passImage)
        
        password.leftViewMode = .Always
        password.leftView = passLeft
        passLeft.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(56, 48))
        }
        passImage.snp_makeConstraints { (make) in
            make.center.equalTo(0)
        }
        password.secureTextEntry = true
        
        //忘记密码
        let forgetPass = UIButton.init(type: UIButtonType.Custom)
        forgetPass.titleLabel?.font = UIFont.systemFontOfSize(15)
        forgetPass.setTitle("忘记密码?", forState: .Normal)
        forgetPass.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        
        self.view.addSubview(forgetPass)
        forgetPass.snp_makeConstraints { (make) in
            make.right.equalTo(0)
            make.top.equalTo(password.snp_bottom)
            make.width.equalTo(72)
            make.height.equalTo(56)
        }
        
        //登录按钮
        let login = UIButton.init(type: UIButtonType.Custom)
        login.titleLabel?.font = UIFont.systemFontOfSize(15)
        login.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        login.setTitle("登录", forState: UIControlState.Normal)
        
        //login.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.1, alpha: 1)
        //设置登录按钮的三种不同状态下的背景颜色
        login.jk_setBackgroundColor(UIColor.greenColor(), forState: UIControlState.Normal)
        self.view.addSubview(login)
        login.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: UIControlState.Disabled)
        login.jk_setBackgroundColor(UIColor.darkGrayColor(), forState: UIControlState.Highlighted)
        //按钮的响应事件
        login.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            //18289568927 123456
            Alamofire.request(.POST, "https://www.1000phone.tk", parameters: [
                "service": "User.Login",
                "phone": self.userName.text!,
                "password": self.password.text!,
                ], encoding: ParameterEncoding.URLEncodedInURL, headers: nil).responseJSON(completionHandler: { (response) in
                    //请求成功
                    if response.result.isSuccess {
                        print(response.result.value!)
                        //登录成功，返回登陆界面
                        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
                    }else {
                        print("网络不通畅，请稍后再试")
                    }
                })
        }
        login.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(forgetPass.snp_bottom).offset(100) //底下偏移100
            make.height.equalTo(48)
        }
        
        //导航条
        let backButton = UIButton.init(type: UIButtonType.Custom)
        backButton.setImage(UIImage(named: "返回按钮"), forState: UIControlState.Normal)
        backButton.addTarget(self, action: #selector(CSLoginViewController.back), forControlEvents: .TouchUpInside)
        
        let backBarButton = UIBarButtonItem.init(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButton
        backButton.frame = CGRectMake(0, 0, 24, 32)
        
        let registerButton = UIButton.init(type: UIButtonType.Custom)
        registerButton.setTitle("注册", forState: .Normal)
        registerButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        registerButton.addTarget(self, action: #selector(CSLoginViewController.register), forControlEvents: .TouchUpInside)
        
        let registerBarButton = UIBarButtonItem.init(customView: registerButton)
        self.navigationItem.rightBarButtonItem = registerBarButton
        registerButton.frame = CGRectMake(0, 0, 45, 45)
    }
    
    //backButtonAction
    func back() {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    //registerButtonAction
    func register() {
        
        self.navigationController?.pushViewController(CSRegisterViewController.init(), animated: true)
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
