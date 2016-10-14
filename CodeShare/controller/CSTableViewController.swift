//
//  CSTableViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/13.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

//自己封装的 TableView 基类
class CSTableViewController: ViewController {
    
    var style: UITableViewStyle = UITableViewStyle.Plain
    //在TabBar页面创建style调用此构造器
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
        // cell Of height
        tableView.rowHeight = 100
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()  //懒加载的写法

    var contentInset = UIEdgeInsetsZero {
        didSet {
            //防止导航控制器遮挡住tabBar和tableView的内容，当我们在修改的时候
            //与 contentOffset 配合使用
            tableView.contentInset = contentInset
            tableView.scrollIndicatorInsets = contentInset
            
            //设置偏移量放置在进入页面时，tableVIew被挡住
            tableView.contentOffset = CGPointMake(0, -contentInset.top) //会自动回弹
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) in
           make.edges.equalTo(0) //边
        }
        //因为这句话会覆盖掉他的子类的属性赋值
        //contentInset = UIEdgeInsetsMake(topBarHeihgt, 0, tabBarheight, 0)
        
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
    
    var tabBarHeight: CGFloat {
        if self.tabBarController != nil && self.navigationController?.viewControllers.first == self  {
            return (self.tabBarController?.tabBar.frame.size.height)!
        }else {
            return 0
        }
    }
    
    var topBarHeight: CGFloat {
        if self.navigationController != nil {
             return statusBarHeight + naviBarHeight
        }else {
            return 0
        }
    }
}
