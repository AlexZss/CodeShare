//
//  AppDelegate.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/11.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //封装设置window根控制器
        configureRootVc()
        
        //设置 MobSMSSDK
        setupMob()
        
        // 用代码设置3D Touch 快捷键
        setupShortCutItem()
        
        return true
    }
    
    func setupShortCutItem() {
        
       // UIApplication.sharedApplication().shortcutItems
        
        //type 可以用这个参数去区分某个快捷键
        //localizedTitle 大标题
        //localizedSubtitle 小标题，副标题
        //
        //userInfo 附加信息
        
        let scanIcon = UIApplicationShortcutIcon.init(type: UIApplicationShortcutIconType.CapturePhoto)
        let scanItem = UIApplicationShortcutItem.init(type: "scan", localizedTitle: "扫一扫", localizedSubtitle: "添加好友", icon: scanIcon, userInfo: nil)
        
        let shareIcon = UIApplicationShortcutIcon.init(type: UIApplicationShortcutIconType.Share)
        
        let shareItem = UIApplicationShortcutItem.init(type: "share", localizedTitle: "分享", localizedSubtitle: nil, icon: shareIcon, userInfo: nil)
        
        UIApplication.sharedApplication().shortcutItems = [scanItem, shareItem]
        
        //也可以使用静态方式创建快捷键
        // 在 plist 文件中添加 UIApplicationShortcutItem 字段，既可添加默认的快捷键，这样当用户刚下载我们的 app ，即使没有打开，也会有快捷键
    }
    
    //从 3D Touch 快捷键点入
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        //先判断 从哪个按钮点
        if shortcutItem.type == "scan" {
            // 跳转到扫一扫
            //先取出 tabBarController 在取出 navigationController
            ((window?.rootViewController as! CSTabBarController).selectedViewController as! UINavigationController).pushViewController(CSScanViewController(), animated: true)
        }
    }
    //设置 MobSMSSDK方法
    func setupMob() {
        SMSSDK.registerApp(MobApp, withSecret: MobSecret)
    }
    //自己封装设置window根控制器
    func configureRootVc() {
        
        window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = CSTabBarController.init()
        window?.makeKeyAndVisible()
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

