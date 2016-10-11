//
//  CSTabBarController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/11.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

class CSTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cinfigureViewControllers()
        
    }
    
    func cinfigureViewControllers() {
        
        let vcInfos = [
            [
                "title": "主页",
                "image": "tabbar_1",
                "class": "UIViewController",
            ],
            [
                "title": "消息",
                "image": "tabbar_1",
                "class": "UIViewController",
            ],
            [
                "title": "分享",
                "image": "tabbar_1",
                "class": "UIViewController",
            ],
            [
                "title": "我的",
                "image": "tabbar_1",
                "class": "UIViewController",
            ],
        ]
        
        var vcArr:[UINavigationController] = []
        for vcInfo in vcInfos {
            
            let vc = (NSClassFromString(vcInfo["class"]!) as! UIViewController.Type).init()

            vc.title = vcInfo["title"]
            vc.view.backgroundColor = UIColor.whiteColor()
            let navVC = UINavigationController.init(rootViewController: vc)
            vcArr.append(navVC)
        }
        self.viewControllers = vcArr
    }
    
    override func viewDidAppear(animated: Bool) {
        // 重写控制器的生命周期方法时，最好调用父类实现
        super.viewDidAppear(animated)
        
        let loginVC = UINavigationController.init(rootViewController: CSLoginViewController.init())
        self.presentViewController(loginVC, animated: true, completion: nil)
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
