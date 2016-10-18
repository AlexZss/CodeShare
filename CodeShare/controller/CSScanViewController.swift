//
//  CSScanViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/18.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit
import swiftScan

//扫描二维码的控制器
class CSScanViewController: LBXScanViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //扫描返回的信息
    override func handleCodeResult(arrayResult: [LBXScanResult]) {
        print(arrayResult)
        // 在这里根据不同的结果，做不同的处理
        
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
