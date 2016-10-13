//
//  CSNetHelp.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/13.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit
import  Alamofire
public class CSNetHelp: NSObject {
    
    public class func request(method:Alamofire.Method = .POST,
                 URLString: String = QFAppBaseURl,
                 parmaters: [String: AnyObject],
                 headers: [String: String]?=nil) -> Alamofire.Request {
        return Alamofire.request(method, URLString, parameters: parmaters, encoding: .URL, headers: headers)
    }

}

extension Request {
    //返回自身
    func responseJSON( comletionHandler: (data: AnyObject, success: Bool )-> Void) -> Request {
        return responseJSON(completionHandler: { (response) in
            let result = response.result
            
            //声明需要返回的两个参数
            var success: Bool = false
            var data: AnyObject = "网络有问题,请重试"
            
            //判断http请求是否成功
            if result.isSuccess {
                let serverData = result.value as! NSDictionary//Dictionary<String, AnyObject>
                
                //取出服务器的返回码
                let serverRect = serverData["ret"] as! Int
                if serverRect != 200 {
                    data = serverData["msg"]!
                }else {
                    let retValue = serverData["data"] as! NSDictionary
                    //取出操返回码作码
                    let retCode = retValue["code"] as! Int
                    if retCode == 0 {
                        //操作成功
                        success = true
                        data = retValue["data"]!
                    }else {
                        data = retValue["msg"]!
                    }
                }
            }else {
                data = (result.error?.localizedDescription)!
            }
            comletionHandler(data: data, success: success)
        })
    }
}
