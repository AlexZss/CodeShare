//
//  CSCircleProgress.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/19.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

//圆形的进度条
// CALayer 表示层次 UIView展示的全部都是 CALayer
// UIView 只是 CALayre的代理 具体负责展示的只是 CALayer
// CALayer 是轻量级的，但是不能响应触摸事件
@IBDesignable
class CSCircleProgress: UIView {

    
    //圆形 path
    var circlePath: UIBezierPath! //贝赛尔path
    //展示进度的 layer
    var cireLeLayer = CAShapeLayer()
    
    override func drawRect(rect: CGRect) {
        circlePath = UIBezierPath.init(roundedRect: bounds, cornerRadius: frame.size.width/2)
        //设置线条的一些样式
        cireLeLayer.lineWidth = 5
        cireLeLayer.lineCap = kCALineJoinRound
        cireLeLayer.lineJoin = kCALineJoinRound
        cireLeLayer.strokeColor = UIColor.randomColor().CGColor
        cireLeLayer.fillColor = UIColor.clearColor().CGColor
        //设置 cireLeLayer 的 path
        cireLeLayer.path = circlePath.CGPath
        //将circleLayer加到本视图的layer
        self.layer.addSublayer(cireLeLayer)
        
        //设置进度
        //cireLeLayer.strokeEnd = 0.5
    }
    
    //进度
    @IBInspectable
    var progress = 0.5 {
        didSet{
            cireLeLayer.strokeEnd = CGFloat(progress)
            self.setNeedsDisplay()
        }
    }
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //1 创建贝赛尔曲线
        circlePath = UIBezierPath.init(roundedRect: bounds, cornerRadius: frame.size.width/2)
        //设置线条的一些样式
        cireLeLayer.lineWidth = 5
        cireLeLayer.lineCap = kCALineJoinRound
        cireLeLayer.lineJoin = kCALineJoinRound
        cireLeLayer.strokeColor = UIColor.randomColor().CGColor
        cireLeLayer.fillColor = UIColor.clearColor().CGColor
        //设置 cireLeLayer 的 path
        cireLeLayer.path = circlePath.CGPath
        //将circleLayer加到本视图的layer
        self.layer.addSublayer(cireLeLayer)
        
        //设置进度
        cireLeLayer.strokeEnd = 0.5
        
        //当我们改变layer的所有属性时，会有一个默认的动画效果(隐式动画)
        //改变NSTimer的优先级(scrollView优先级比它高)
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.5, block: {
            (timer) in
            self.progress = Double(arc4random())%100/100.0
            self.cireLeLayer.strokeColor = UIColor.randomColor().CGColor
            }, repeats: true)
        //将定时器添加到 runloop 的 commonModes 里
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        //每一个分线程也有一个 runloop，但是分线程 runloop默认不会启动
        //Runloop(死循环)
        //我们的应用程序一打开，主线程就会启动，然后主线程会有一个 runloop 在不停的运行
//        while true {
//            
//        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        
    }

}
