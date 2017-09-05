//
//  BaseNavigationController.swift
//  CYGithub
//
//  Created by cuiyue on 2017/8/30.
//  Copyright © 2017年 cuiyue. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let  navigationBar =  UINavigationBar.appearance()
        navigationBar.setBackgroundImage(UIImage(named: "navigationbarBackgroundWhite"), for: .default)
        
        navigationBar.titleTextAttributes = {[
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont(name: "Heiti SC", size: 20.0)!
            ]}()
        
        
        let item =  UIBarButtonItem.appearance()
        item.setTitleTextAttributes({[
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont(name: "Heiti SC", size: 17.0)!
            ]}(), for: .normal)
        item.setTitleTextAttributes({[
            NSForegroundColorAttributeName: UIColor.lightGray,
            NSFontAttributeName: UIFont(name: "Heiti SC", size: 17.0)!
            ]}(), for: .disabled)
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 {
           let button =  UIButton(type: .custom)
            button.setTitle("返回", for: .normal)
            //设置返回按钮的图片
            button.setImage(UIImage(named: "navigationButtonReturn"), for: .normal)
            button.setImage(UIImage(named: "navigationButtonReturnClick"), for: .highlighted)
            //设置返回按钮文字的颜色
            button.setTitleColor(UIColor.black, for: .normal)
            button.setTitleColor(UIColor.red, for: .highlighted)
            //设置返回按钮大小包裹内容
            button.sizeToFit()
            //左对齐
            button.contentHorizontalAlignment = .left
            //设置按钮里面的内容往左边跑，偏出按钮的范围
            button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
            //导航按钮点击事件
            button.addTarget(self, action: #selector(BaseNavigationController.back), for: .touchUpInside)
            //替换系统的顶部导航栏返回按钮
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
            //隐藏底部tabbar
            viewController.hidesBottomBarWhenPushed = true
        }
        //这句super的push要放在后面,让viewController可以覆盖上面设置的leftBarButtonItem
        super.pushViewController(viewController, animated: animated)
    }
    
    func back(){
        //push进来的控制器要用这个方法返回
        self.popViewController(animated: true)
    }
    
    
    
    
}
