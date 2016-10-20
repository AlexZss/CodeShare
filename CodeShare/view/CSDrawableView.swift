//
//  CSDrawableView.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/19.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

//可以画画的Viwe
class CSDrawableView: UIView {

    //手指所在的上一个点
    var prePoint = CGPointZero
    //保存划过的所有路径
    var drawPath = CGPathCreateMutable()
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        //1
        let context = UIGraphicsGetCurrentContext()
        //2
        CGContextSetLineWidth(context, 2)
        CGContextSetStrokeColorWithColor(context, UIColor.randomColor().CGColor)
        //设置两条线之间的连接方法和起笔的方式
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetLineJoin(context, CGLineJoin.Round)
        //3
        CGContextAddPath(context, drawPath)
        //4
        CGContextDrawPath(context, CGPathDrawingMode.Stroke)
    }
    
    //我们的 UIResponder 对像可以接受触摸事件, 我们可以通过重写这些方法来做一些响应事件
    //一般都要先调用父类方法
    //响应者链 触摸屏幕时 最开始是window先感受到，然后一层一层往下传...
    //
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        //因为我门的View只能接受单点触控
        prePoint = (touches.first?.locationInView(self))!
    }
    
    //如果手指在屏幕滑动，触发这个方法
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
        let currentPoint = (touches.first?.locationInView(self))!
        //从上一个触摸点到这一个点，添加一条路径
        let subPath = CGPathCreateMutable()
        CGPathMoveToPoint(subPath, nil, prePoint.x, prePoint.y)
        //CGPathAddLineToPoint(subPath, nil, (currentPoint?.x)!, (currentPoint?.y)!)
        
        let reduis = sqrt(Double((currentPoint.x-prePoint.x)*(currentPoint.x-prePoint.x)+(currentPoint.y-prePoint.y)*(currentPoint.y-prePoint.y)))
        
        CGPathAddArcToPoint(subPath, nil, (currentPoint.x+prePoint.x)/2, (currentPoint.y+prePoint.y)/2, currentPoint.x, currentPoint.y, CGFloat(reduis))
        //将这条路径合并到 drawPath 
        CGPathAddPath(drawPath, nil, subPath)
        
        //将上一个点更新为现在的点
        prePoint = currentPoint
        
        //告诉系统我们的视图需要刷新，可以在适当的时机调用 drawRect 来刷新屏幕
        self.setNeedsDisplay()
    }

}
