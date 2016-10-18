//
//  CSModel.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/13.
//  Copyright © 2016年 Alex. All rights reserved.
//

import Foundation

class CSMyVideoModel: NSObject {
    
    var title: String?
    var imageUrl: String?
    var videoUrl: String?
    var videoSize: String?
    
}



class CSMyFileModel: NSObject {
    
    var title = ""
    var imageUrl = ""
    var fileSize = ""
    var from = ""
    
}



class CSVideoListModel: NSObject {
    var videoList : [CSVideoModel]!
    var count : NSNumber = 0
    var total : NSNumber = 0
    var nextPageUrl = ""
    //将字典模型转换为数据模型保存  也可以在解数据的时候一层层的解
    class func modelContainerPropertyGenericClass() -> [String : AnyObject]? {
        return [
            "videoList": CSVideoModel.self
        ]
    }
}

class CSVideoModel: NSObject {
    var id : NSNumber = 0
    var date : NSNumber = 0
    var idx : NSNumber = 0
    var title = ""
    var category = ""
    var duration = 0
    var playUrl = ""
    var playInfo : [CSPlayInfoModel]?
    var consumption : CSConsumptionModel?
    var promotion = ""
    var waterMarks = ""
    class func modelContainerPropertyGenericClass() -> [String : AnyObject]? {
        return [
            "playInfo": CSPlayInfoModel.self
        ]
    }
}

class CSPlayInfoModel: NSObject {
    var height: NSNumber = 0
    var width: NSNumber = 0
    var name = ""
    var type = ""
    var url = ""
}

class CSConsumptionModel: NSObject {
    var collectionCount: NSNumber = 0
    var shareCount: NSNumber = 0
    var playCount: NSNumber = 0
    var replyCount: NSNumber = 0
}
