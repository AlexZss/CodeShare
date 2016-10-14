//
//  CSMyPhotoColCell.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/14.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

class CSMyPhotoColCell: UICollectionViewCell {
    
    //collection反选的效果，自己封装
    var mask = UIView.init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageView = UIImageView.init(image: UIImage.init(named: "图片"))
        self.contentView.addSubview(imageView)
        imageView.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        self.contentView.addSubview(mask)
        mask.backgroundColor = UIColor ( red: 0.3362, green: 0.3362, blue: 0.3362, alpha: 0.25 )
        mask.alpha = 0
        mask.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    //重写选中的属性 还有 selected 状态
    override var highlighted: Bool {
        didSet{
            UIView.animateWithDuration(0.25) {
                // alpha 选中  上面的alpha为 透明度
                self.mask.alpha = CGFloat(self.highlighted)
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
