//
//  CSMyInfoViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/14.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

//我的信息界面的基类，三个滚动的view封装在第三方库
class CSMyInfoViewController: CSScrollViewController {

    var dispalyController = YZDisplayViewController.init()
    let headImage = UIImageView.init(image: UIImage.init(named: "头像"))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.contentInset = UIEdgeInsetsMake(64, 0, 49, 0)
        //封装展示多个控制器
        configureViewCOntrollers()
        //ScrollViewtitle 的样式
        self.configureTitleScroll()
        //上半部分的界面
        self.congureTopInfo()
    }
    func congureTopInfo(){
        let backImage = UIImageView.init(image: UIImage.init(named: "背景图片"))
        self.contenView.addSubview(backImage)
        backImage.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.equalTo(0)
            make.height.equalTo(178)
        }
        
        //let headImage = UIImageView.init(image: UIImage.init(named: "头像"))
        backImage.addSubview(headImage)
        headImage.snp_makeConstraints { (make) in
            make.left.top.equalTo(16)
            make.size.equalTo(56)
        }
        
        let nameLabel = UILabel.init()
        nameLabel.font = UIFont.systemFontOfSize(16)
        nameLabel.textColor = UIColor.whiteColor()
        backImage.addSubview(nameLabel)
        nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(headImage.snp_right).offset(8)
            make.top.equalTo(headImage)
        }
        nameLabel.text = "Alex"
        
        
        let emailLabel = UILabel.init()
        emailLabel.font = UIFont.systemFontOfSize(15)
        emailLabel.textColor = UIColor.whiteColor()
        backImage.addSubview(emailLabel)
        emailLabel.snp_makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(headImage)
        }
        emailLabel.text = "123454321@162.com"
        
        
        let setButton = UIButton.init(type: UIButtonType.Custom)
        setButton.setTitle("设置", forState: .Normal)
        setButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        setButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        backImage.addSubview(setButton)
        backImage.userInteractionEnabled = true
        setButton.snp_makeConstraints { (make) in
            make.right.equalTo(-16)
            make.centerY.equalTo(0)
        }
        setButton.jk_handleControlEvents(.TouchUpInside) { (sender) in
            let settingCtrl = CSMySettingViewController()
            settingCtrl.title = "我的设置"
            settingCtrl.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(settingCtrl, animated: true)
        }
        
        let buttonArray = ["12\n我的分享","2\n我的下载","9\n我的好友"]
       
        var lastView: UIButton? = nil
        
        for btmTitle in buttonArray {
            let button = UIButton.init(type: .Custom)
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(14)
            button.jk_setBackgroundColor(UIColor(red: 0.0,green: 0.0,blue: 0.0,alpha: 0.1), forState: .Normal)
            button.titleLabel?.textAlignment = .Center
            button.titleLabel?.numberOfLines = 0
            button.setTitle(btmTitle, forState: .Normal)
            backImage.addSubview(button)
            
            button.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(lastView == nil ? backImage.snp_left : (lastView?.snp_right)!).offset(lastView == nil ? 0 : 1)
                make.width.equalTo(backImage).dividedBy(3)
                make.height.equalTo(44)
                make.bottom.equalTo(0)
            })
            
            lastView = button
        }
    }
    
    func configureTitleScroll(){
        //下划线 还有直接. 属性值
        dispalyController.setUpUnderLineEffect { (isShowUnderLine,  isDelayScroll,  lineHeight,  lineColor) in
            isShowUnderLine.memory = true
            lineColor.memory = UIColor.redColor()
        }
        
        //标题颜色效果
        dispalyController.setUpTitleGradient { (isShowTitleGradient,  titleGradientstyle, startR, startG, startB, endR, engG, endB) in
            isShowTitleGradient.memory = true
            titleGradientstyle.memory = YZTitleColorGradientStyleFill
            startR.memory = 0.5
            startG.memory = 0.5
            startB.memory = 0.5
            endR.memory = 0.75
            engG.memory = 0.75
            endB.memory = 0.75
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        headImage.setImageWithURL(NSURL.init(string: CSUserModel.SharedUser.avatar))
        
    }
    
    func configureViewCOntrollers() {
        
        //let dispalyController = YZDisplayViewController.init()
        
        let picList = CSMyPhotoLIstViewController.init(nibName: nil, bundle: nil)
        picList.title = "图片"
        dispalyController.addChildViewController(picList)
        
        let videoList = CSMyViodeListViewController.init(nibName: nil, bundle: nil)
        videoList.title = "视频"
        videoList.style = .Plain
        videoList.contentInset = UIEdgeInsetsMake(44, 0, 0, 0)
        dispalyController.addChildViewController(videoList)
        
        let fileList = CSMyFileListViewController.init(nibName: nil, bundle: nil)
        fileList.title = "压缩包"
        fileList.contentInset = UIEdgeInsetsMake(44, 0, 0, 0)
        //属性 直接改就好了
        fileList.style = .Plain
        dispalyController.addChildViewController(fileList)
        
        
        //将displayViewCOntroller 加入到本控制器并展示
        self.addChildViewController(dispalyController)
        self.contenView.addSubview(dispalyController.view)
        
        //配置控制器的大小,让子控制器的大小可以根据本控制器的 view 的改变而改变
//        dispalyController.view.frame = self.view.bounds
        //将两个枚举类型写在一起
//        dispalyController.view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        dispalyController.view.backgroundColor = UIColor.whiteColor()
        
        dispalyController.view.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(180)
        }
        //控制器的生命周期    ???
        dispalyController.didMoveToParentViewController(self)
        dispalyController.titleScrollView.backgroundColor = UIColor ( red: 0.7708, green: 0.7671, blue: 0.7745, alpha: 0.75)
        //
        //self.navigationItem.titleView = dispalyController.titleScrollView
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
