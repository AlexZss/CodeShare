//
//  CSMyDetailViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/18.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit
import Alamofire
import swiftScan

class CSMyDetailViewController: CSTableViewController {
    
    let cellModels = [
        [
            "title": "昵称",
            "class": ""
        ],
        [
            "title": "性别",
            "class": ""
        ],
        [
            "title": "出生日期",
            "class": ""
        ],
        [
            "title": "所在地",
            "class": ""
        ],
        [
            "title": "扫一扫",
            "class": "",
        ],
        [
            "title": "我的二维码",
            "class": "",
        ]
    ]
    
    let headerButton = UIButton.init(type: .Custom)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //头视图
        let headerView = UIView.init(frame: CGRectMake(0, 0, self.view.width, 130))
        
        headerButton.setImage(UIImage.init(named: "用户头像"), forState: .Normal)
        headerView.addSubview(headerButton)
        headerButton.snp_makeConstraints { (make) in
            make.center.equalTo(0)
            make.width.height.equalTo(100)
        }
        
        //更该用户头像
        headerButton.jk_handleControlEvents(.TouchUpInside) { (sender) in
            UIActionSheet.init(title: "选择头像来源", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "从相册选择", "拍照").showInView(self.view)
            
        }
        
        self.tableView.tableHeaderView = headerView
        
        //底部视图
        let footView = UIView.init(frame: CGRectMake(0, 0, self.view.width, 100))
        let footButton = UIButton.init(type: .Custom)
        footButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        footButton.setTitle("退出登录", forState: .Normal)
        footButton.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        footButton.jk_setBackgroundColor(UIColor ( red: 1.0, green: 0.6604, blue: 0.3873, alpha: 1.0 ), forState: .Normal)
        footButton.jk_setBackgroundColor(UIColor.darkGrayColor(), forState: .Highlighted)
        footView.addSubview(footButton)
        footButton.snp_makeConstraints { (make) in
            make.center.equalTo(0)
            make.left.equalTo(0)
            make.height.equalTo(44)
        }
        
        self.tableView.tableFooterView = footView
        self.tableView.rowHeight = 44
        self.tableView.sectionHeaderHeight = 0
        self.tableView.backgroundColor = UIColor.whiteColor()
        tableView.registerClassOf(UITableViewCell)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CSMyDetailViewController {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.cellModels.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell()
        cell.textLabel?.font = UIFont.systemFontOfSize(15)
        cell.textLabel?.text = self.cellModels[indexPath.section]["title"]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //扫一扫或者我的二维码
        if indexPath.section == 4 {
            let scanCtrl = LBXScanViewController.init()
            //设置扫码界面的样式
            scanCtrl.title = "扫一扫"
            scanCtrl.scanStyle?.animationImage = UIImage.init(named: "button_background")
            scanCtrl.scanStyle?.colorAngle = UIColor.whiteColor()
            scanCtrl.scanStyle?.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.Inner
            
            self.navigationController?.pushViewController(scanCtrl, animated: true)
            //处理扫描结果
            
            
        }else if indexPath.section == 5 {
            let qrCtrl = CSMyQRCodeViewController()
            qrCtrl.title = "我的二维码"
            self.navigationController?.pushViewController(qrCtrl, animated: true)
        }
    }
}

extension CSMyDetailViewController: UIActionSheetDelegate {
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
        guard buttonIndex != 0 else { // 如果不怎么样 就去 做什么
            return
        }
        let imagePicker = UIImagePickerController.init()
        if buttonIndex == 1 {  //相册
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }else if buttonIndex == 2 {  //拍照
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        }
        
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
}

extension CSMyDetailViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //print(info)
        //取出编辑过后的图片
        let editeImage = info[UIImagePickerControllerEditedImage]
        //压缩图片转成NSData
        let imageData = UIImageJPEGRepresentation(editeImage! as! UIImage, 0.9)
        
        Alamofire.upload(.POST, QFAppBaseURl, multipartFormData: { (formData) in
            //拼接参数
            formData.appendBodyPart(data: "UserInfo.UpdateAvatar".dataUsingEncoding(NSUTF8StringEncoding)!, name: "service")
            formData.appendBodyPart(data: CSUserModel.SharedUser.id!.dataUsingEncoding(NSUTF8StringEncoding)!, name: "uid")
            formData.appendBodyPart(data: imageData!, name: "avatar", fileName: "\(NSDate.init().timeIntervalSince1970).png", mimeType: "image/jpeg")
            
            }) { (encodingResult) in
                switch (encodingResult) {
                case.Success(let upload, _, _):
                    upload.responseJSON({ (data, success) in //上传的数据
                        if success {
                            //print(data)
                            let dataInfo = data as! NSDictionary
                            self.headerButton.setImage(editeImage as? UIImage, forState: .Normal)
                            //更改用户模型的属性
                            CSUserModel.SharedUser.avatar = "http://10.12.155.20/PhalApi/Public/\(dataInfo["file_url"]!)"
                            
                        }else {
                            print(data)
                        }
                    })
                case.Failure(let error):
                    print(error)
                }
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
}