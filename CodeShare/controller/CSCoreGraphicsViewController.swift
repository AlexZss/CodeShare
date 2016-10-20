//
//  CSCoreGraphicsViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/19.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture

//核心绘图
class CSCoreGraphicsViewController: CSScrollViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //自定义三角形的视图，添加到控制器
        let trangleView = CSTrangleView.init()
        self.contenView.addSubview(trangleView)
        trangleView.snp_makeConstraints { (make) in
            make.left.top.equalTo(20)
            make.width.height.equalTo(100)
        }
        
        let trangleView2 = CSTrangleView.init()
        self.contenView.addSubview(trangleView2)
        trangleView2.snp_makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(trangleView.snp_right).offset(20)
            make.width.height.equalTo(150)
        }
        trangleView2.backgroundColor = UIColor.clearColor()
        
        let drawableView = CSDrawableView.init()
        self.contenView.addSubview(drawableView)
        drawableView.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.centerX.equalTo(0)
            make.top.equalTo(trangleView2.snp_bottom).offset(30)
            make.height.equalTo(300)
        }
        drawableView.backgroundColor = UIColor.whiteColor()
        
        //手势冲突(关掉侧滑和scrollView效果)
        self.fd_interactivePopDisabled = true
        self.scrollerView.scrollEnabled = false
        
        //
        trangleView.dragable = true
        trangleView2.dragable = true
        
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
