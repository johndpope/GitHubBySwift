//
//  MainController.swift
//  GitHubBySwift
//
//  Created by cuiyue on 2017/9/5.
//  Copyright © 2017年 cy. All rights reserved.
//

import UIKit

class MainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(childController: HomeController(),title: "首页",imageName: "tabbar_home")
        addChildViewController(childController: MeController(),title: "我的",imageName: "tabbar_my")
    }
    
    private func addChildViewController(childController: UIViewController,title :String , imageName : String) {
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName+"_highlighted")
        let nav = BaseNavigationController(rootViewController: childController)
        addChildViewController(nav)
        
    }

}
