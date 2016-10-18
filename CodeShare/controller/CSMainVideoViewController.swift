//
//  CSMainVideoViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/17.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit
import ZFPlayer

class CSMainVideoViewController: CSTableViewController {

    var cellModel: CSVideoListModel!
    
    // 播放视频的视图
    var player = ZFPlayerView.sharedPlayerView()
    // 存储正在播放的 cell 的 indexPath
    var playIndex : NSIndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getVideoList()
        
        // Do any additional setup after loading the view.
        self.tableView.registerNibOf(CSMainVideoCell)
        self.tableView.rowHeight = 300
        // cell 分割线
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    func getVideoList() {
        
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            // 先取出json 文件内容
            let cellData = NSData.init(contentsOfFile: NSBundle.mainBundle().pathForResource("videoData.json", ofType: nil)!)
            
            let cellInfo = try! NSJSONSerialization.JSONObjectWithData(cellData!, options: NSJSONReadingOptions.MutableContainers)
            // 第三方库的kvc
            self.cellModel = CSVideoListModel.modelWithJSON(cellInfo)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 }

extension CSMainVideoViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellModel == nil {
            return 0
        }
        return cellModel.videoList.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : CSMainVideoCell = tableView.dequeueReusableCell()
        
        // 如果当前的 cell 正在播放
        if indexPath == playIndex {
            // 隐藏播放按钮
            cell.playBtn.hidden = true
        }else {
            cell.playBtn.hidden = false
        }
        
        cell.startPlay = {() -> () in
            
            // 转为 tableViewCell 里面播放进行设计的一个方法，设置 url、taableView。。
            self.player.setVideoURL(NSURL.init(string: self.cellModel.videoList[indexPath.row].playUrl), withTableView: tableView, atIndexPath: indexPath, withImageViewTag: 100)
            
            // 是否自动播放
            self.player.autoPlayTheVideo()
            // 是否有下载功能
            self.player.hasDownload = true
            //当前有视频播放时，切换 playIndex
            if let tempIndex = self.playIndex {
                // 存储一下正在播放视频的 cell 的 indexPath
                self.playIndex = indexPath
                
                // 如果需要，刷新上一个 cell 的状态
                tableView.reloadRowAtIndexPath(tempIndex, withRowAnimation: .None)
            }
            
            // 存储一下正在播放视频的 cell 的 indexPath
            self.playIndex = indexPath
            
            // 隐藏当前 cell 的 playBtn
            cell.playBtn.hidden = true
            
        }
        
        return cell
    }
}
