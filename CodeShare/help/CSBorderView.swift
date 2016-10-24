////
////  CSBorderView.swift
////  CodeShare
////
////  Created by 曾诗 on 16/10/20.
////  Copyright © 2016年 Alex. All rights reserved.
////
//
//import Foundation
//import UIKit
//
////给所有的视图添加一个边框，不需要在项目中再写任何代码
//
//extension UIView {
//    //从写这个方法 
//    //初始化类的时候会调用，不需要我们调用
//    public override class func initialize() {
//        //print(#function)
//        
//        var token: dispatch_once_t = 0
//        dispatch_once(&token) {
//            if self.classForCoder() == NSClassFromString("UIView") {
//                self.exchangeInitFunc()
//            }
//        }
//    }
//    
//    class func exchangeInitFunc() {
//        
//        //将系统原来的方法取出
//        let originInitFunc = #selector(self.willMoveToSuperview(_:))
//        //取出自己写的方法
//        let myInitFunc = #selector(self.cs_willMoveToSuperview(_:))
//        //获取两个方法的实现
//        let method1 = class_getInstanceMethod(self, originInitFunc)
//        let method2 = class_getInstanceMethod(self, myInitFunc)
//        //交换两个方法的实现    Method Swizzling
//        method_exchangeImplementations(method1, method2)
//    }
//    //如果用自己的方法去替换了系统方法的，需要我们先去调用一下系统的方法
//    //调用原来的方法时，要小心
//    func cs_willMoveToSuperview(newSubperView: UIView?) {
//        //如果这里直接调用原来的方法，会发生死循环
//        //self.init(frame: frame)
//        //我们已经和原来的替换过了，所以需要调用当前的方法就行了
//        cs_willMoveToSuperview(newSubperView)  //这里并不会发生递归调用自身死循环
//        
//        //边框
//        //self.layer.borderColor = UIColor.redColor().CGColor
//        //self.layer.borderWidth = 2.0
//        
//        //如果此视图是 UIStatusBarItemView 的子类对象 就加上背景颜色
//        if self.isKindOfClass(NSClassFromString("UIStatusBarItemView")!) {
//            //self.backgroundColor = UIColor.blackColor()
//        }
//        
//        //用 runtime 替换方法的实现，可以做到一些意想不到的神奇功能，但是这种方法容易产生一些不易检查的 bug 慎重使用 比如init 和 生命周期
//    }
//}