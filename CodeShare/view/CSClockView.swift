//
//  CSClockView.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/19.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

class CSClockView: UIView {

    let clockPanel = CAShapeLayer.init()
    let hourNeedle = CAShapeLayer.init()
    let minuteNeedle = CAShapeLayer.init()
    let secondNeedle = CAShapeLayer.init()
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        self.drawClock(rect)
    }
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawClock(bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    //绘制一个复古钟表
    func drawClock(frame: CGRect) {
        //绘制表盘
        let clockPath = UIBezierPath.init(roundedRect: frame, cornerRadius: frame.width/2)
        //设置表盘属性
        clockPanel.fillColor = UIColor.whiteColor().CGColor
        clockPanel.strokeColor = UIColor.randomColor().CGColor
        clockPanel.lineWidth = 5
        clockPanel.path = clockPath.CGPath
        
        //时针
        let hourPath = UIBezierPath.init(rect: CGRectMake(0, 0, 4, frame.size.height/2-32)) //???
        hourNeedle.fillColor = UIColor.clearColor().CGColor
        hourNeedle.lineWidth = 4
        hourNeedle.strokeColor = UIColor.randomColor().CGColor
        hourNeedle.path = hourPath.CGPath
        //辅助定位
        hourNeedle.position = CGPointMake(frame.width/2, frame.height/2)
        
        
        //分针
        let minutePath = UIBezierPath.init(rect: CGRectMake(0, 0, 3, frame.size.height/2-20))
        minuteNeedle.fillColor = UIColor.clearColor().CGColor
        minuteNeedle.lineWidth = 3
        minuteNeedle.strokeColor = UIColor.randomColor().CGColor
        minuteNeedle.path = minutePath.CGPath
        minuteNeedle.position = CGPointMake(frame.width/2, frame.height/2)
        
        
        //秒针
        let secoundPath = UIBezierPath.init(rect: CGRectMake(0, 0, 3, frame.size.height/2-8))
        secondNeedle.fillColor = UIColor.clearColor().CGColor
        secondNeedle.lineWidth = 2
        secondNeedle.strokeColor = UIColor.randomColor().CGColor
        secondNeedle.path = secoundPath.CGPath
        secondNeedle.position = CGPointMake(frame.width/2, frame.height/2)
        
        //将 layer 添加到界面
        self.layer.addSublayer(clockPanel)
        self.layer.addSublayer(hourNeedle)
        self.layer.addSublayer(minuteNeedle)
        self.layer.addSublayer(secondNeedle)
        
        //添加一个毫秒级的定时器，根屏幕的刷新率一样
        let dispalyLink = CADisplayLink.init(target: self, selector: #selector(configureClock))
        // 需要添加到 runloop 中
        dispalyLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        
    }
    
    func configureClock() {
        //获取当前的时间
        let currentDate = NSDate.init()
        //用 NSCalendar 来方面的管理时间
        let calender = NSCalendar.currentCalendar()
        let dateComponents = calender.components([NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: currentDate)
        //将现在的时分秒转化为一个弧度值，改变钟表指针的旋转角度
        self.hourNeedle.setAffineTransform(CGAffineTransformMakeRotation(CGFloat(Double(dateComponents.hour)/12)*CGFloat(M_PI*2)-CGFloat(M_PI_2)))
        
        //分针
        self.minuteNeedle.setAffineTransform(CGAffineTransformMakeRotation(CGFloat(Double(dateComponents.minute)/60.0)*CGFloat(M_PI*2)-CGFloat(M_PI_2)))
        
        //秒针
        self.secondNeedle.setAffineTransform(CGAffineTransformMakeRotation(CGFloat(Double(dateComponents.second)/60.0)*CGFloat(M_PI*2)-CGFloat(M_PI_2)))
        
        self.clockPanel.strokeColor = UIColor.randomColor().CGColor
        self.hourNeedle.strokeColor = UIColor.randomColor().CGColor
        self.minuteNeedle.strokeColor = UIColor.randomColor().CGColor
        self.secondNeedle.strokeColor = UIColor.randomColor().CGColor
    }

}
