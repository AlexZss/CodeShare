//
//  CSMyViodeListViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/13.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

class CSMyViodeListViewController: CSTableViewController {
    //构造假数据
    var cellInfos: [[String: AnyObject]] = []
    //模拟数据模型
    //
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(withStyle: .Plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var cellModels: [AnyObject] = []
    //
    var index = 100
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib.init(nibName: String(CSMayVideoCell), bundle: nil), forCellReuseIdentifier: String(CSMayVideoCell))
        // Do any additional setup after loading the view.
        
        tableView.snp_makeConstraints { (make) in
            
            //make.edges.equalTo(0) //边
        }
        //配置数据
        getData()
    }
    
    func getData() {
        
            cellInfos = [
                [
                    "title":"河南政府吃饭打白条欠120万",
                    "imageUrl":"视频",
                    "viodeoUrl":"http://www.baidu.com"
                ],
                [
                    "title":"河南政府吃饭打白条欠120万",
                    "imageUrl":"视频",
                    "viodeoUrl":"http://www.baidu.com"
                ],
                [
                    "title":"河南政府吃饭打白条欠120万",
                    "imageUrl":"视频",
                    "viodeoUrl":"http://www.baidu.com"
                ],
                [
                    "title":"河南政府吃饭打白条欠120万",
                    "imageUrl":"视频",
                    "viodeoUrl":"http://www.baidu.com"
                ],
                [
                    "title":"河南政府吃饭打白条欠120万",
                    "imageUrl":"视频",
                    "viodeoUrl":"http://www.baidu.com"
                ],
                [
                    "title":"河南政府吃饭打白条欠120万",
                    "imageUrl":"视频",
                    "viodeoUrl":"http://www.baidu.com"
                ],
                [
                    "title":"河南政府吃饭打白条欠120万",
                    "imageUrl":"视频",
                    "viodeoUrl":"http://www.baidu.com"
                ],
                [
                    "title":"河南政府吃饭打白条欠120万",
                    "imageUrl":"视频",
                    "viodeoUrl":"http://www.baidu.com"
                ],[
                    "title":"河南政府吃饭打白条欠120万",
                    "imageUrl":"视频",
                    "viodeoUrl":"http://www.baidu.com"
                ],
                [
                    "title":"河南政府吃饭打白条欠120万",
                    "imageUrl":"视频",
                    "viodeoUrl":"http://www.baidu.com"
                ],
            ]
        // OC JSON转化为模型数组
        cellModels = NSArray.modelArrayWithClass(CSMyVideoModel.self, json: cellInfos)!
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CSMyViodeListViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(String(CSMayVideoCell)) as! CSMayVideoCell
        cell.configure(withModel: cellModels[indexPath.row] as! CSMyVideoModel)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //反选的效果
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
