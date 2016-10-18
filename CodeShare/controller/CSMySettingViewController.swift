//
//  CSMySettingViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/18.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

class CSMySettingViewController: CSTableViewController {
    
    let cellModels = [ //section
        
        [  // cell
            [ //cell 具体的东西 可能是字典
                "title": "个人信息",
                "type": "0",
            ],
        ],
        
        [
            [
                "title": "允许查看我的分享",
                "type": "2",
            ],
            [
                "title": "允许查看我的下载",
                "type": "2",
            ],
            [
                "title": "任何人允许添加我为好友",
                "type": "2",
            ],
        ],
        
        [
            [
                "title": "保存到本地",
                "type": "0",
            ],
            [
                "title": "账号保存",
                "type": "0",
            ],
        ],
        
        [
        
            [
                "title": "清楚缓存",
                "type": "0",
            ],
            [
                "title": "用户反馈",
                "type": "1",
            ],
            [
                "title": "关于",
                "type": "1",
            ],
        ],
    
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.backgroundColor = UIColor ( red: 0.9224, green: 0.9224, blue: 0.9224, alpha: 1.0 )
        //系统的
        self.tableView.registerClassOf(UITableViewCell)
        self.tableView.rowHeight = 44
        self.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CSMySettingViewController {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.cellModels.count
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellModels[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell()
        
        // cell 的样式，注意复用问题
        cell.textLabel?.font = UIFont.systemFontOfSize(15)
        cell.textLabel?.textColor = UIColor.darkTextColor()
        cell.textLabel?.text = self.cellModels[indexPath.section][indexPath.row]["title"]
        
        // cell 右边不同的样式
        let type = self.cellModels[indexPath.section][indexPath.row]["type"]
        if type == "0" {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }else if type == "1" {
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }else if type == "2" {
            cell.accessoryView = UISwitch.init()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0 && indexPath.row == 0 {
            let detailCtrl = CSMyDetailViewController()
            detailCtrl.title = "信息详情"
            detailCtrl.contentInset = contentInset
            
            self.navigationController?.pushViewController(detailCtrl, animated: true)
        }
    }
}
