//
//  NSObject+Walk.m
//  CodeShare
//
//  Created by 曾诗 on 16/10/20.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "NSObject+Walk.h"

@implementation NSObject (Walk)

//实现的时候
+ (void)walk {
    NSLog(@"i'm walking");
    
}

//实现
- (void)talk {
    NSLog(@"i'm talking");
}

@end

@implementation UIViewController (speak)

- (void)speak{
    NSLog(@"i'm speaking");
}

@end
