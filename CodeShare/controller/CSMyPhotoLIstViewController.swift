//
//  CSMyPhotoLIstViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/14.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

class CSMyPhotoLIstViewController: ViewController {

    var collectionView: UICollectionView!
    //流式布局
    var flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    var celModel = ["","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       collectionView = UICollectionView.init(frame: CGRectZero, collectionViewLayout: flowLayout)
        self.view.addSubview(collectionView)
        
        collectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        flowLayout.itemSize = CGSizeMake(60, 60)
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //试图指定的类(自定义的泛型)
        collectionView.registerClassOf(CSMyPhotoColCell)
        
        //self.view.backgroundColor = UIColor.whiteColor()
        collectionView.backgroundColor = UIColor.whiteColor()
        //collectionView四周扩展内容 上左下右
        collectionView.contentInset = UIEdgeInsetsMake(44, 0, 49, 0)
        //水平滚动
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 49, 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension CSMyPhotoLIstViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return celModel.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: CSMyPhotoColCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //反选
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
    }
}
