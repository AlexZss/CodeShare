//
//  CSMyMainPageViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/17.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

class CSMainPageViewController: YZDisplayViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureViewController()
    }
    func configureViewController() {
        let mainPhoto = CSMainPhotoViewController()
        mainPhoto.style = .Plain
        mainPhoto.title = "图片"
        mainPhoto.contentInset = UIEdgeInsetsMake(64, 0, 49, 0)
        self.addChildViewController(mainPhoto)
        
        let mainVideo = CSMainVideoViewController()
        mainVideo.style = .Plain
        mainVideo.title = "视频"
        mainVideo.contentInset = UIEdgeInsetsMake(64, 0, 49, 0)
        self.addChildViewController(mainVideo)
        
        let mainFile = CSMainFileViewController()
        mainFile.style = .Plain
        mainFile.title = "压缩包"
        mainVideo.contentInset = UIEdgeInsetsMake(64, 0, 49, 0)
        self.addChildViewController(mainFile)
        
        self.navigationItem.titleView = self.titleScrollView
    }
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
