//
//  CSMyQRCodeViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/18.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit
import swiftScan

// 我的二维码
class CSMyQRCodeViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let qrCodeView = UIImageView.init()
        self.view.addSubview(qrCodeView)
        qrCodeView.snp_makeConstraints { (make) in
            make.centerX.equalTo(0)
            make.top.equalTo(100)
            make.width.height.equalTo(300)
        }
        
        //生成二维码
        let qrImage = LBXScanWrapper.createCode("CIQRCodeGenerator", codeString: "http://www.baidu.com", size: CGSizeMake(300, 300), qrColor: UIColor ( red: 0.2779, green: 0.5477, blue: 0.9464, alpha: 1.0 ), bkColor: UIColor.whiteColor())
        qrCodeView.image = qrImage
        
        //保存按钮
        let leftSave = UIButton.init(type: .Custom)
        leftSave.setTitle("截图保存", forState: .Normal)
        self.view.addSubview(leftSave)
        leftSave.jk_setBackgroundColor(UIColor.brownColor(), forState: .Normal)
        leftSave.snp_makeConstraints { (make) in
            make.left.equalTo(60)
            make.top.equalTo(qrCodeView.snp_bottom).offset(24)
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
        leftSave.jk_handleControlEvents(.TouchUpInside) { (sender) in
            //截图
            let screenImage = self.view.jk_screenshot()
            //保存到相册
            UIImageWriteToSavedPhotosAlbum(screenImage, self, #selector(CSMyQRCodeViewController.image(_:didFinishSavingWithError:contexInfo:)), nil)
        }
        
        let rihghtSave = UIButton.init(type: .Custom)
        rihghtSave.setTitle("直接保存", forState: .Normal)
        self.view.addSubview(rihghtSave)
        rihghtSave.jk_setBackgroundColor(UIColor.grayColor(), forState: .Normal)
        rihghtSave.snp_makeConstraints { (make) in
            make.right.equalTo(-60)
            make.top.equalTo(leftSave)
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
    }

    func image(image: UIImage,didFinishSavingWithError error :NSError?,contexInfo: UnsafePointer<Void>) {
        if error != nil {
            
        }else {
            
        }
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
