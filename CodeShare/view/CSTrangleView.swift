//
//  CSTrangleView.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/19.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

//CG自定义三角形
//重写 drawRect方法: 在屏幕上面有一张相同大小的空白的纸，拿笔在上画
@IBDesignable
class CSTrangleView: UIView {

    override func drawRect(rect: CGRect) {
        //1 获取画布
        let context = UIGraphicsGetCurrentContext()
        //2 设置笔触样式
        //笔触的宽度
        CGContextSetLineWidth(context, 2)
        //
        CGContextSetStrokeColorWithColor(context, UIColor.randomColor().CGColor)
        
        //3 开始作画
        //选取落笔点
        let tranglePath = CGPathCreateMutable() // 没有继承NSObject 不能直接.init()
        CGPathMoveToPoint(tranglePath, nil, rect.width/2, 0)
        //向目标点添加一条直线
        CGPathAddLineToPoint(tranglePath, nil, 0, rect.size.height-1)
        CGPathAddLineToPoint(tranglePath, nil, rect.size.width, rect.size.height-1)
        CGPathAddLineToPoint(tranglePath, nil, rect.size.width/2, 0)  //回到落笔点
        
        //4 将路径添加到画布上
        CGContextAddPath(context, tranglePath)
        
        //5 按照设定的模式绘制(展示）
        //CGContextSetBlendMode(context, CGBlendMode.ColorDodge)
        CGContextDrawPath(context, CGPathDrawingMode.Stroke)
    }

}
