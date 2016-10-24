
//
//  CSDragableView.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/20.
//  Copyright © 2016年 Alex. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    //给 UIView 添加一个属性  Yes 能响应拖拽手势
    // 默认是不可以在 extension 添加存储属性的 我们可以通过 runtime 的对象绑定达到添加属性的效果
    var dragable: Bool {
        get{
            //return self.panGesture.enabled
            return false
        }
        set{
            //self.panGesture.enabled = newValue
        }
    }
    //当作我们绑定对象地址的指针
    private struct PanGestureKey {
        static var key = "PanGestureKey"
    }
    //添加一个拖拽手势
    var panGesture: UIPanGestureRecognizer {
        get{
            //将某个对象绑定的某个属性取出
            var pan = objc_getAssociatedObject(self, &PanGestureKey.key) //指针需要取地址符
            //如果以前没有绑定过，新建一个手势并绑定
            if pan == nil {
                pan = UIPanGestureRecognizer.init(target: self, action: #selector(handlePanGesture(_:)))
                //添加手势到视图
                self.addGestureRecognizer(pan as! UIPanGestureRecognizer)
                //默认不可拖拽
                (pan as! UIPanGestureRecognizer).enabled = false
                
                //设置手势代理
                (pan as! UIPanGestureRecognizer).delegate = self
            }
            
            return pan as! UIPanGestureRecognizer
        }
        set{
            //将某个对象绑定到当前对象上，作为一个属性存在，需要有一个指针去存储
            objc_setAssociatedObject(self, &PanGestureKey.key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC/**/)
        }
    }
    
    func handlePanGesture(pan: UIPanGestureRecognizer) {
        //取得手势的偏移量
        let offset = pan.translationInView(self)
        //
        self.center = CGPointMake(self.center.x+offset.x, self.center.y+offset.y)
        //重置复位 不然会累加
        pan.setTranslation(CGPointZero, inView: self)
        
    }
    
}

extension UIView: UIGestureRecognizerDelegate {
    //当两个相似的手势冲突时，让他们都响应
//    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOfGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
}