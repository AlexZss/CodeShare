//
//  NSObject+Walk.h
//  CodeShare
//
//  Created by 曾诗 on 16/10/20.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSObject (Walk)

//声明了一个对象方法，所有的 NSObject 对象都能调用这个方法
- (void)walk;

//声明一个类方法
+ (void)talk;

@end

@interface  UIViewController(speak)

//声明一个方法
+ (void)speak;

@end
