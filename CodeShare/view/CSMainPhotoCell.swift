//
//  CSMainPhotoCell.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/17.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit
import WPAttributedMarkup
import SDCycleScrollView
//跳转大图界面的库
import IDMPhotoBrowser


class CSMainPhotoCell: UITableViewCell {
    
    var pageLabel = UILabel.init()
    let imageGroup = ["image01","image02","image03"]
    
    //必须会调用的init方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor ( red: 0.802, green: 0.802, blue: 0.802, alpha: 1.0 )
        
        //头部是图
        let topView = UIView.init()
        topView.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(topView)
        topView.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(56)
        }
        
        //头像
        let headerImage = UIImageView.init(image: UIImage.init(named: "首页头像"))
        topView.addSubview(headerImage)
        headerImage.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.centerY.equalTo(0)
            make.width.height.equalTo(36)
        }
        
        //名字
        let nameLabel = UILabel.init()
        nameLabel.font = UIFont.systemFontOfSize(15)
        nameLabel.textColor = UIColor.darkTextColor()
        nameLabel.text = "ALex"
        topView.addSubview(nameLabel)
        nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(headerImage.snp_right).offset(8)
            make.top.equalTo(headerImage)
        }
        
        //时间 第三方库
        let timeLabel = UILabel.init()
        topView.addSubview(timeLabel)
        timeLabel.snp_makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(headerImage)
        }
        
        let style: NSDictionary = [
            "clock": UIImage.init(named: "时间图标")!,
            "fontColor": UIColor.lightGrayColor(),
            "fontSize": UIFont.systemFontOfSize(13),
        ]
        let timeStr: NSString = "<clock> </clock> <fontColor><fontSize>一天</fontSize></fontColor>"
        timeLabel.attributedText = timeStr.attributedStringWithStyleBook(style as [NSObject : AnyObject])
        
        //添加好友
        let addFriend = UIButton.init(type: UIButtonType.Custom)
        addFriend.setImage(UIImage.init(named: "加好友图标"), forState: .Normal)
        topView.addSubview(addFriend)
        addFriend.snp_makeConstraints { (make) in
            make.right.equalTo(-8)
            make.centerY.equalTo(0)
            make.width.height.equalTo(18)
        }
        
        //滚动大图
        let photoBrowser = SDCycleScrollView.init()
        //如果是本地图片
        photoBrowser.localizationImageNamesGroup = ["image01","image02","image03"]
        //(本地占位图)下载网络图片时
        photoBrowser.placeholderImage = UIImage.init(named: "image01")
        //不显示 pageController
        photoBrowser.showPageControl = false
        //是否自动滚动
        photoBrowser.autoScroll = false
        //设置代理
        photoBrowser.delegate = self
        self.contentView.addSubview(photoBrowser)
        photoBrowser.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(headerImage.snp_bottom).offset(8)
            make.height.equalTo(160)
        }
        
        //右上角的页码
        //let pageLabel = UILabel.init()
        pageLabel.textColor = UIColor.whiteColor()
        pageLabel.backgroundColor = UIColor.lightGrayColor()
        pageLabel.font = UIFont.systemFontOfSize(14)
        pageLabel.text = "1/3"
        pageLabel.layer.cornerRadius = 12
        pageLabel.layer.masksToBounds = true
        pageLabel.textAlignment = .Center
        photoBrowser.addSubview(pageLabel)
        pageLabel.snp_makeConstraints { (make) in
            make.right.equalTo(-8)
            make.top.equalTo(8)
            make.width.height.equalTo(25)
        }

        //定位图片
        let locateLabel = UILabel.init()
        locateLabel.backgroundColor = UIColor ( red: 0.6373, green: 0.6373, blue: 0.6373, alpha: 0.6 )
        
        let locateStyle: [NSString: AnyObject] = [
            "locate": UIImage.init(named: "地理图标")!,
            "font": UIFont.systemFontOfSize(13),
            "color": UIColor.lightTextColor(),
        ]
        
        let locateStr: NSString = "<locate> </locate><font><color> 西安市雁塔区高新四路永安大厦</font></color>"
        locateLabel.attributedText = locateStr.attributedStringWithStyleBook(locateStyle)
        photoBrowser.addSubview(locateLabel)
        locateLabel.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(24)
        }
        
        //
        let tagButton = UIButton.init(type: .Custom)
        tagButton.setTitle("#我喜欢今天的拍摄", forState: .Normal)
        tagButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        tagButton.jk_setBackgroundColor(UIColor.clearColor(), forState: .Normal)
        tagButton.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: .Normal)
        tagButton.setTitleColor(UIColor ( red: 0.4012, green: 1.0, blue: 0.2544, alpha: 1.0 ), forState: .Normal)
        tagButton.titleEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4)
        tagButton.layer.cornerRadius = 4
        tagButton.layer.masksToBounds = true
        self.contentView.addSubview(tagButton)
        tagButton.snp_makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(photoBrowser.snp_bottom).offset(8)
            make.height.equalTo(24)
        }
        
        let titlesArr = ["分享","感兴趣","下载","评论"]
        var lastView: UIButton? = nil
        
        for title in titlesArr {
            
            let button = UIButton.init(type: .Custom)
            button.setImage(UIImage.init(named: "\(title)图标"), forState: .Normal)
            button.setTitle(title, forState: .Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(13)
           
            button.jk_setBackgroundColor(UIColor.whiteColor(), forState: .Normal)
            button.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
            button.imageEdgeInsets = UIEdgeInsetsMake(0, -4, 0, 4)
            self.contentView.addSubview(button)
            button.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(lastView == nil ? contentView.snp_left : (lastView?.snp_right)!)
                make.width.equalTo(self.contentView).dividedBy(4)
                make.height.equalTo(24)
                make.top.equalTo(tagButton.snp_bottom).offset(8)
            })
            
            lastView = button
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CSMainPhotoCell: SDCycleScrollViewDelegate {
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didScrollToIndex index: Int) {
        //改变页码
        pageLabel.text = "\(index+1)/\(imageGroup.count)"
    }
    
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        //跳转到大图浏览
        var photos = [IDMPhoto]()
        for imageName in imageGroup {
            let image = IDMPhoto.init(image: UIImage.init(named: imageName))
            photos.append(image)
        }
        let photoBrower = IDMPhotoBrowser.init(photos: photos, animatedFromView: cycleScrollView)//self 为 CSMainPhotoCell   //动画效果
        photoBrower.setInitialPageIndex(UInt(index))  //初始页码
        photoBrower.displayToolbar = true
        photoBrower.displayCounterLabel = true
        self.viewController?.presentViewController(photoBrower, animated: true, completion: nil)  //cell 取到controller
    }
}
