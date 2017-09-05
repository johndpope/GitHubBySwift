//
//  AppDelegate.swift
//  GitHubBySwift
//
//  Created by cuiyue on 2017/9/5.
//  Copyright © 2017年 cy. All rights reserved.
//

import UIKit

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
        return true
    }




}

