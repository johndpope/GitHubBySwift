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
    }
    
}

extension BaseNavigationController{
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool){
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
}
