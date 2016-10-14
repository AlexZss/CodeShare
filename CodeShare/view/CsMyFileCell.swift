//
//  CsMyFileCell.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/14.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

class CsMyFileCell: UITableViewCell {

    @IBOutlet weak var fileImage: UIImageView!
  
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var fileSize: UILabel!
    
    @IBOutlet weak var from: UILabel!
    
    
    func configureWithModel(model: CSMyFileModel) {
        
        title.text = model.title
        fileSize.text = model.fileSize
        from.text = model.from
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
