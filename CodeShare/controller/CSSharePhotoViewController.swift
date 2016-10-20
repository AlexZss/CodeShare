//
//  CSSharePhotoViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/18.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit
import UzysAssetsPickerController
import IDMPhotoBrowser

class CSSharePhotoViewController: CSScrollViewController {

    var cellModel = [UIImage.init(named: "加好友图标")]
    var photoList: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.contenView.backgroundColor = UIColor ( red: 0.8838, green: 0.8838, blue: 0.8838, alpha: 1.0 )
        
        let shareButton = UIButton.init(type: .Custom)
        shareButton.setTitle("分享", forState: .Normal)
        shareButton.titleLabel?.font = UIFont.systemFontOfSize(13)
        shareButton.jk_setBackgroundColor(UIColor ( red: 0.8321, green: 1.0, blue: 0.718, alpha: 1.0 ), forState: .Normal)
        shareButton.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: .Highlighted)
        shareButton.layer.cornerRadius = 4.0
        shareButton.layer.masksToBounds = true
//        shareButton.snp_makeConstraints { (make) in
//            make.width.equalTo(60)
//            make.height.equalTo(30)
//        }
        shareButton.frame = CGRectMake(0, 0, 60, 30)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: shareButton)
        
        //文本框
        let textView = UITextView.init()
        textView.font = UIFont.systemFontOfSize(15)
        self.contenView.addSubview(textView)
        textView.snp_makeConstraints { (make) in
            make.left.top.equalTo(8)
            make.centerX.equalTo(0)
            make.height.equalTo(100)
        }
        
        
        //图片列表
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSizeMake((self.view.width-30)/4, (self.view.width-30)/4)
        flowLayout.minimumLineSpacing = 6
        flowLayout.minimumInteritemSpacing = 6
        flowLayout.sectionInset = UIEdgeInsetsMake(6, 6, 6, 6)
        
        photoList = UICollectionView.init(frame: CGRectZero, collectionViewLayout: flowLayout)
        photoList.backgroundColor = UIColor ( red: 0.8838, green: 0.8838, blue: 0.8838, alpha: 1.0 )
        self.contenView.addSubview(photoList)
        photoList.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(textView.snp_bottom).offset(2)
        }
        
        photoList.registerClassOf(CSMyPhotoColCell)
        photoList.delegate = self
        photoList.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CSSharePhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellModel.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: CSMyPhotoColCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.imageView.image = self.cellModel[indexPath.row]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item == self.cellModel.count - 1 {
            //点击的是加号
            let pickerCtrl = UzysAssetsPickerController.init()
            
            //最多可以选择几个图片
            pickerCtrl.maximumNumberOfSelectionPhoto = 3
            //设置视频的个数
            pickerCtrl.maximumNumberOfSelectionVideo = 0
            //样式和代理
            UzysAppearanceConfig.sharedConfig().finishSelectionButtonColor = UIColor ( red: 0.7577, green: 0.5866, blue: 0.3119, alpha: 1.0 )
            pickerCtrl.delegate = self
            self.presentViewController(pickerCtrl, animated: true, completion: nil)
        }else {
            //点击的是图片
           
            
            //设置图片数组
            //展示所要分享的图片
            var photoGroup: [IDMPhoto] = []
            for image in self.cellModel {
                if image == self.cellModel.last! {
                    break
                }
                let photo = IDMPhoto.init(image: image!)
                photoGroup.append(photo)
            }
             let photoBrowser = IDMPhotoBrowser.init(photos: photoGroup,animatedFromView: collectionView.cellForItemAtIndexPath(indexPath))
            self.presentViewController(photoBrowser, animated: true, completion: nil)
            
            photoBrowser.setInitialPageIndex(UInt(indexPath.item))
        }
    }
}

extension CSSharePhotoViewController: UzysAssetsPickerControllerDelegate {
    //取消
    func uzysAssetsPickerControllerDidCancel(picker: UzysAssetsPickerController!) {
        
    }
    //成功选中图片   记下来就行了
    func uzysAssetsPickerController(picker: UzysAssetsPickerController!, didFinishPickingAssets assets: [AnyObject]!) {
        print(assets)
        for asset in assets {
            let representation = asset as! ALAsset
            //取出图片的类型
            if representation.valueForProperty(ALAssetPropertyType) != nil{
                
                let fullImage =  representation.defaultRepresentation().fullResolutionImage().takeUnretainedValue()
                
                let selectImage = UIImage.init(CGImage:fullImage)
                self.cellModel.insert(selectImage, atIndex: 0)
            }
        }
        
        //刷新 collctionView 
        self.photoList.reloadData()
    }
    //超出了选择的个数
    func uzysAssetsPickerControllerDidExceedMaximumNumberOfSelection(picker: UzysAssetsPickerController!) {
        
    }
}
