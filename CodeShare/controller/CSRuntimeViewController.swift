//
//  CSRuntimeViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/20.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

// runtime 就是运行时，在 ios 中，所有继承自 NSObject 的类，无论是调用方法，还是设置属性...所有的东西都会转换为 runtime 运行
// NSobject时一个基类，oc中，所有的类都直接或间接继承自 NSObject (NSProxy是另外一个基类)
class CSRuntimeViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //获取类名
        print(self.className())
        print(super.className())
        //崩溃
        //self.walk()
        //不崩溃
        //var name = "123"
        CSRuntimeViewController.talk()
        //崩溃
        //CSRuntimeViewController.speak()
        //self 和 super 就是一个编译器的特性 就是一个指针，self指向本对像所在的内存，super可以代表直接调用父类的方法
        //为什么要学习 runtime
        // 功能强大，使用简单，应用广泛，OC面由C的面向过程转向面相对象的基础 可以理解 iOS 底层的实现
        
        //开始使用
        // 简单的用法
        print(self.propertyList(CSRuntimeViewController.self))
        print(self.propertyList(UIViewController.self))
        //如果是纯swift代码，那么可能获取不到，需要在方法/变量前面添加 dynamic/@objc 关键字
        
        let modelsInfo = [
            "title":"123",
            "imageUrl": "123",
            "fileSize":"123",
            "from" : "123"
            
        ]
        let model = CSPlayInfoModel()
        model.csSetValuesForKeyWith(modelsInfo, aClass: CSPlayInfoModel.self)
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UIViewController {
    
    dynamic var name: String {
        get{
            return self.name
        }
        set{
            return self.name = newValue
        }
    }
}

extension NSObject {
    //封装一个方法，获取某个类的所有属性(私有，公有)
    func propertyList(aClass: AnyClass) -> [String] {
        //创建一个数组，保存属性名
        var propertyName = [String]()
        //用来保存 property 的个数方便我们遍历
        let count = UnsafeMutablePointer<UInt32>.alloc(0)
        //此方法可以获取某个类的所有的 property 列表，需要两个参数，类和一个个数
        //返回的是一个数组列表(指针)
        let propertyList = class_copyPropertyList(aClass, count)
        
        //遍历返回的列表
        for index in 0..<count.memory {
            //取出 property
            let property = propertyList[Int(index)]
            //获取 propertyName
            let name = property_getName(property)
            //保存到数组
            propertyName.append(String.init(UTF8String: name)!)
        }
        
        return propertyName
    }
    
    func csSetValuesForKeyWith(info: [String: AnyObject], aClass: AnyClass) -> AnyObject{
       
        let propertyList = self.propertyList(aClass)
        //遍历字典
        for (name, value) in info {
             //如果本类包含这个属性
            if propertyList.contains(name) {
                //设置属性值为字典的 value
                self.setValue(value, forKey: name)
            }else {
                print("name: \(name) 不存在")
            }
        }
        return self
    }
    

}
