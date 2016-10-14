//
//  CSMyFileListViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/14.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

class CSMyFileListViewController: CSTableViewController {
    
    var cellModels: [AnyObject] = []
    
    var cellInfos = [
        [
            "title": "关于 JavaScript.doc",
            "imagrUrl": "",
            "fileSize": "34.5k",
            "from": "来自Alex的分享",
        ],
        [
            "title": "关于 JavaScript.doc",
            "imagrUrl": "",
            "fileSize": "34.5k",
            "from": "来自Alex的分享",
        ],
        [
            "title": "关于 JavaScript.doc",
            "imagrUrl": "",
            "fileSize": "34.5k",
            "from": "来自Alex的分享",
        ],
        [
            "title": "关于 JavaScript.doc",
            "imagrUrl": "",
            "fileSize": "34.5k",
            "from": "来自Alex的分享",
        ],
        [
            "title": "关于 JavaScript.doc",
            "imagrUrl": "",
            "fileSize": "34.5k",
            "from": "来自Alex的分享",
        ],
        [
            "title": "关于 JavaScript.doc",
            "imagrUrl": "",
            "fileSize": "34.5k",
            "from": "来自Alex的分享",
        ],
        [
            "title": "关于 JavaScript.doc",
            "imagrUrl": "",
            "fileSize": "34.5k",
            "from": "来自Alex的分享",
        ],
        [
            "title": "关于 JavaScript.doc",
            "imagrUrl": "",
            "fileSize": "34.5k",
            "from": "来自Alex的分享",
        ],
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //将 model 转换为对象 kvc方式类似
        self.cellModels = NSArray.modelArrayWithClass(CSMyFileModel.self, json: cellInfos)!
        
        //注册cell 使用封装的
        self.tableView.registerNibOf(CsMyFileCell)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
//MARK: TableViewDelegate
extension CSMyFileListViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: CsMyFileCell = tableView.dequeueReusableCell()
        
        cell.configureWithModel(cellModels[indexPath.row] as! CSMyFileModel)
        return cell
    }
}
