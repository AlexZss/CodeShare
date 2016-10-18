//
//  CSMainPhotoViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/17.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

class CSMainPhotoViewController: CSTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.registerClassOf(CSMainPhotoCell)
        self.tableView.rowHeight = 285
        self.tableView.allowsSelection = false
        
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

extension CSMainPhotoViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: CSMainPhotoCell = tableView.dequeueReusableCell()
        
        return cell
    }
}
