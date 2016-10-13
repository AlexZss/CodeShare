//
//  CSTableViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/13.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

class CSTableViewController: ViewController {
    
    var style: UITableViewStyle = UITableViewStyle.Grouped
    
    init(withStyle style: UITableViewStyle) {
        super.init(nibName: nil, bundle: nil)
        self.style = style
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    //xib创建时会调用
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    private(set) lazy var tableView: UITableView = {
        
        let style = self.style
        let tableView = UITableView.init(frame: CGRectMake(0, 249, 414, 500), style: style)
        
        //水平指示器
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = UIColor ( red: 0.801, green: 0.801, blue: 0.801, alpha: 1.0 )
        tableView.rowHeight = 100
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()  //懒加载的写法

    var contentInset = UIEdgeInsetsZero {
        didSet {
            tableView.contentInset = contentInset
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) in
           make.edges.equalTo(0) //边
        }
        
        //
        //createButton()
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CSTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
