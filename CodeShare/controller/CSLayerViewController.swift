//
//  CSLayerViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/19.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

class CSLayerViewController: CSScrollViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //封装一个圆形的进度条
        let cirecleProgress = CSCircleProgress.init(frame: CGRectMake(20, 20, 100, 100))
        self.contenView.addSubview(cirecleProgress)
        cirecleProgress.backgroundColor = UIColor.clearColor()
        
        //添加一个钟表
        let clockView = CSClockView.init(frame: CGRectMake(20, 160, 300, 300))
        self.contenView.addSubview(clockView)
        clockView.backgroundColor = UIColor.clearColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
