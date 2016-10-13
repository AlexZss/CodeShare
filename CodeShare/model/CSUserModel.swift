//
//  CSUserModel.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/13.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

class CSUserModel: NSObject {
    //用户单例
    //一句话写单例
    static var SharedUser = CSUserModel()
    //县调用是否登录，再来调用 init 方法
    private  override init() {
        super.init()
        //取出沙盒数据
        if let userInfo = NSUserDefaults.standardUserDefaults().objectForKey(String(CSUserModel)) {
            self.modelSetWithJSON(userInfo)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var address = ""
    var avatar = ""
    var birthday = ""
    var email = ""
    var gender = ""
    var id: String? = nil
    var name = ""
    var nickname = ""
    var phone = ""
   
    //判断用户是否登陆了
    class func isLogin() -> Bool {
        return SharedUser.id != nil
    }
    
    //根据登陆后获取到的用户信息，配置用户数据
    class func loggin(with USerInfo: [String: AnyObject]) {
        //用YYKit里的YYModel做字典转模型
        SharedUser.modelSetWithDictionary(USerInfo)
        //SharedUser.setValuesForKeysWithDictionary(USerInfo)
        
        //将用户数据存到沙盒路径
        NSUserDefaults.standardUserDefaults().setObject(SharedUser.modelToJSONObject(), forKey: String(CSUserModel))  //SharedUser.modelToJSONObject() 不用 userInfo 没有东西会爆炸
        //马上更新
        NSUserDefaults.standardUserDefaults().synchronize()
        //将类当做字符串来使用
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
