//
//  AppDelegate.swift
//  GitHubBySwift
//
//  Created by cuiyue on 2017/9/5.
//  Copyright © 2017年 cy. All rights reserved.
//

import UIKit

let MainNavBarColor = UIColor.init(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: 1)
let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height
let kTabBarHeight = 49
let kNavBarHeight = 44

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let launcherController = LauncherController()
        window?.rootViewController = launcherController
        window?.makeKeyAndVisible()
        
        
        //延迟1.5秒跳转到主页面
        let time: TimeInterval = 1.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            let mainController = MainController()
            self.window?.rootViewController = mainController
        }
        
        setNavBarAppearence()
        
        return true
    }
    
    func setNavBarAppearence(){
        // 设置导航栏默认的背景颜色
        UIColor.defaultNavBarBarTintColor = UIColor.init(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: 1)
        // 设置导航栏所有按钮的默认颜色
        UIColor.defaultNavBarTintColor = .white
        // 设置导航栏标题默认颜色
        UIColor.defaultNavBarTitleColor = .white
        // 统一设置状态栏样式
        UIColor.defaultStatusBarStyle = .lightContent
        // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
        //         UIColor.defaultShadowImageHidden = true
    }
    
    
}

