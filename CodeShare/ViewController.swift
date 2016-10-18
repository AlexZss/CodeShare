//
//  ViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/11.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit
import JKCategories
//基控制器
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //设置不让系统自动控制 scrollView 的 contenInsets
        self.automaticallyAdjustsScrollViewInsets = false
        
        //封装返回按钮
        self.congfigureBackItem()
        
        //设置控制器的背景颜色
        self.view.backgroundColor = UIColor.randomColor()
    }

    func congfigureBackItem(){
        // push的控制器 返回的是 pop 否则dismiss
        if  (self.navigationController?.presentingViewController != nil && self.navigationController?.viewControllers.first != self) || self.navigationController?.presentingViewController != nil {
                let  backButton = UIButton.init(type: .Custom)
                backButton.setImage(UIImage(named: "返回按钮"), forState: .Normal)
                backButton.jk_handleControlEvents(.TouchUpInside, withBlock: { (sender) in
                    if self.navigationController?.popViewControllerAnimated(true) == nil {
                        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
                    }
                })
                
                backButton.frame = CGRectMake(0, 0, 16, 32)
                let backItemBtm = UIBarButtonItem(customView: backButton)
                self.navigationItem.leftBarButtonItem = backItemBtm
        }
        
        //只有在不是present出的导航控制器的第二个控制器，需要添加这个属性
        if self.navigationController?.presentationController == nil && self.navigationController?.viewControllers.count >= 2 && self.navigationController?.viewControllers[1] == self {
            self.hidesBottomBarWhenPushed = true
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //在跟控制器上写公共的功能代码
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.view.endEditing(true)
    }

}

//方便获取tabBar navigationBar statueBar 等的高度
extension UIViewController {
    var statusBarHeight: CGFloat {
        return UIApplication.sharedApplication().statusBarFrame.size.height
    }
    
    var naviBarHeight: CGFloat {
        return (self.navigationController?.navigationBar.frame.size.height)!
    }
    
    var tabBarheight: CGFloat {
        if self.hidesBottomBarWhenPushed == true {
            return (self.tabBarController?.tabBar.frame.size.height)!
        }else {
            return 0
        }
    }
    
    var topBarHeihgt: CGFloat {
        return statusBarHeight + naviBarHeight
    }
}

