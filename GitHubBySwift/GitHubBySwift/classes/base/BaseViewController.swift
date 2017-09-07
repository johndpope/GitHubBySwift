//
//  BaseViewController.swift
//  GitHubBySwift
//
//  Created by cuiyue on 2017/9/7.
//  Copyright © 2017年 cy. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 64))
    lazy var navItem = UINavigationItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        automaticallyAdjustsScrollViewInsets = false
        setupNavBar()
    }
    
    fileprivate func setupNavBar(){
        // 自定义导航栏必须设置这个属性!!!!!!
        customNavBar = navBar
        
        view.addSubview(navBar)
        navBar.items = [navItem]
        
        // 设置自定义导航栏背景图片
//        navBarBackgroundImage = UIImage(named: "millcolorGrad")
        
        // 设置自定义导航栏默认背景颜色
        // navBarBarTintColor = MainNavBarColor
        
        // 设置自定义导航栏标题颜色
        navBarTitleColor = UIColor.white
        
        // 设置自定义导航栏左右按钮字体颜色
        navBarTintColor = UIColor.white
        
        if self.navigationController?.childViewControllers.count != 1 {
            
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
            button.addTarget(self, action: #selector(BaseViewController.back), for: .touchUpInside)
            //替换系统的顶部导航栏返回按钮
            navItem.leftBarButtonItem =  UIBarButtonItem(customView: button)
        }
    }
    
    @objc fileprivate func back(){
        _ = navigationController?.popViewController(animated: true)
    }
}
