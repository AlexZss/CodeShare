//
//  CSMayVideoCell.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/13.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

class CSMayVideoCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var sizeLabel: UILabel!
    
    @IBOutlet weak var videoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(withModel model: CSMyVideoModel) {
        
        title.text = model.title
        sizeLabel.text = model.videoSize
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
