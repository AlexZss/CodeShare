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
        
        
        //让应用可以使用摇一摇手势
        UIApplication.sharedApplication().applicationSupportsShakeToEdit = true
        //将本控制器作为第一响应者
        self.becomeFirstResponder()
        
    }
    
    //处理摇一摇回掉的方法 
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        // 开始摇一摇
        print("使劲摇")
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        // 摇完了
        print("摇完了")
        //将界面截图存到相册
        let imageShoot = UIApplication.sharedApplication().keyWindow?.jk_screenshot()
        
        UIImageWriteToSavedPhotosAlbum(imageShoot!, nil, nil, nil)
    }
    
    // 添加预览界面的快捷键  3D touch最初创建 CSSEttingCtrl
    override func previewActionItems() -> [UIPreviewActionItem] {
        
        let item1 = UIPreviewAction.init(title: "截图", style: UIPreviewActionStyle.Selected) { (action, viewController) in
            
            let imageShoot = UIApplication.sharedApplication().keyWindow?.jk_screenshot()
           
            UIImageWriteToSavedPhotosAlbum(imageShoot!, nil, nil, nil)
        }
        
        return [item1]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
