//
//  CSMyShareViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/18.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

//
import FDFullscreenPopGesture

// 分享界面
class CSShareViewController: CSScrollViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fd_prefersNavigationBarHidden = true
        
        // Do any additional setup after loading the view.
       
        let backImage = UIImage.init(named: "image02")?.imageByBlurLight()
        self.view.backgroundColor = UIColor.init(patternImage: backImage!)
        
        let toolBar = UIToolbar.init()
        //self.view.addSubview(toolBar)
        //因为在最上层 加到下面
        self.view.insertSubview(toolBar, atIndex: 0)
        toolBar.barStyle = UIBarStyle.Black
        toolBar.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        let topButton = UIButton.init(type: .Custom)
        topButton.setImage(UIImage.init(named: "按钮-图片"), forState: .Normal)
        self.contenView.addSubview(topButton)
        topButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(-140)
            make.centerX.equalTo(0)
            make.width.height.equalTo(56)
        }
        
        let centerButton = UIButton.init(type: .Custom)
        centerButton.setImage(UIImage.init(named: "按钮-视频"), forState: .Normal)
        self.contenView.addSubview(centerButton)
        centerButton.snp_makeConstraints { (make) in
            make.center.equalTo(0)
            make.width.height.equalTo(topButton)
        }
        
        let bottomButton = UIButton.init(type: .Custom)
        bottomButton.setImage(UIImage.init(named: "按钮-压缩包"), forState: .Normal)
        self.contenView.addSubview(bottomButton)
        bottomButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(0)
            make.centerY.equalTo(140)
            make.width.height.equalTo(topButton)
        }
        
        self.scrollerView.backgroundColor = UIColor.clearColor()
        self.contenView.backgroundColor = UIColor.clearColor()
        
        //跳转到分享图片的控制器
        topButton.jk_handleControlEvents(.TouchUpInside) { (sender) in
            let sharePhotoCtrl = CSSharePhotoViewController()
            sharePhotoCtrl.title = "图片分享"
            sharePhotoCtrl.hidesBottomBarWhenPushed = true
            sharePhotoCtrl.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
            
            self.navigationController?.pushViewController(sharePhotoCtrl, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
