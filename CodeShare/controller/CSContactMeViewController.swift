//
//  CSContactMeViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/24.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

//系统的库  核心通话
 import CoreTelephony
//
import MessageUI

class CSContactMeViewController: ViewController {

    
    //直接打电话  不经过提示
    @IBAction func cellOne(sender: AnyObject) {

        UIApplication.sharedApplication().openURL(NSURL.init(string: "tel://15714432023")!)
    }
    
    //打电话时有弹出提示，是否打电话
    @IBAction func cellTwo(sender: AnyObject) {
        
        UIApplication.sharedApplication().openURL(NSURL.init(string: "telprompt://15714432023")!)
    }
    //前两种方式不推荐，因为在打完电话之后无法回到我们的 app , 直接打电话不提示 会给用户带来困扰 或者被 appStore 拒掉
    
    // 实际项目中，用的是 webView
    @IBAction func callThree(sender: AnyObject) {
        
        let webView = UIWebView.init()
        //将 weView 添加到界面上
        self.view.addSubview(webView)
        //加载打电话的 request
        webView.loadRequest(NSURLRequest.init(URL: NSURL.init(string: "tel://15714432023")!))
    }
    
    //直接跳转到短信app 发送短信
    @IBAction func smsOne(sender: AnyObject) {
        
        UIApplication.sharedApplication().openURL(NSURL.init(string: "sms://15714432023")!)
    }
    
    // 用 MFMessageComposeViewController 发送短信，可以自定义发送的内容，群发
    @IBAction func smsTwo(sender: AnyObject) {
        
        let messageCtrl = MFMessageComposeViewController.init()
        messageCtrl.body = "今天是程序员节"
        messageCtrl.recipients = ["","","","",""]  //群发
        //设置代理
        //和 全屏侧滑的库有点冲突 
        messageCtrl.messageComposeDelegate = self //代理方法里面返回一些信息
        self.presentViewController(messageCtrl, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //监听打电话的状态  
        //因为我们现在是 (ARC) 自动引用机制，如果没有被强引用， 这个对象立即被释放 所以要 去声明他自己的属性去引用他 不能直接 CTCallCenter.init()
        callCenter.callEventHandler = { (call) in
            if call.callState == CTCallStateConnected {
                //判断是否接通了
            }
            print(call)
        }
    }

    var callCenter = CTCallCenter.init()
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

extension CSContactMeViewController: MFMessageComposeViewControllerDelegate {
   
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        
        print(result)  //无论成功或者失败 将控制器弹下去
        
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
}
