//
//  CSScrollViewController.swift
//  CodeShare
//
//  Created by 曾诗 on 16/10/14.
//  Copyright © 2016年 Alex. All rights reserved.
//

import UIKit

//自己封装的 ScrollView 基类
class CSScrollViewController: ViewController {

    //私有的只读
    private(set) lazy var scrollerView: UIScrollView = { //公共的子类都会需要实现直接写在父类
       let scrollView = UIScrollView.init()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor.whiteColor()
        
        return scrollView
    }()
    
    private(set) lazy var contenView: UIView = {
       let contenView = UIView.init()
        contenView.backgroundColor = UIColor.randomColor()
        
        return contenView
    }()
    
    
    var contentInset = UIEdgeInsetsMake(64, 0, 0, 0) {         didSet{
            scrollerView.contentInset = contentInset
            scrollerView.scrollIndicatorInsets = contentInset
            scrollerView.contentOffset = CGPointMake(0, -contentInset.top)
            
            //更新 contentView 的高度约束
            contenView.snp_updateConstraints { (make) in
                //内容的高度等于view减去两边的导航再减1 更新的新高度
                make.height.greaterThanOrEqualTo(view).offset(1-contentInset.top-contentInset.bottom)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(scrollerView)
        scrollerView.addSubview(contenView)
        
        contenView.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
            make.width.equalTo(scrollerView)
            //scrollView的高度比 view 高1  初始创建的高度
            make.height.greaterThanOrEqualTo(view).offset(1)
        }
        scrollerView.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
            make.bottom.equalTo(contenView.snp_bottom)
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
