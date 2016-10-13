//
//  CSHelp.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/13.
//  Copyright © 2016年 Alex. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    //可以生成随机颜色的方法
    class func randomColor() -> UIColor {
        let r = CGFloat(arc4random_uniform(128)) / 255.0 + 0.5
        let g = CGFloat(arc4random_uniform(128)) / 255.0 + 0.5
        let b = CGFloat(arc4random_uniform(128)) / 255.0 + 0.5
        
        return UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
