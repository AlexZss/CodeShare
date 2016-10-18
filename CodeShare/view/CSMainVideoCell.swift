//
//  CSMainVideoCell.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/17.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

class CSMainVideoCell: UITableViewCell {
    
    var startPlay : (() -> ())?

    @IBOutlet weak var playBtn: UIButton!
    var isPlaying = false
    
    @IBAction func play(sender: AnyObject) {
        self.startPlay!()
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
