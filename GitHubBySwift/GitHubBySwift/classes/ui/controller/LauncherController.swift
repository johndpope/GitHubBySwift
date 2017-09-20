//
//  LauncherControllerViewController.swift
//  GitHubBySwift
//
//  Created by cuiyue on 2017/9/5.
//  Copyright © 2017年 cy. All rights reserved.
//

import UIKit

class LauncherController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        biBao  { (str) in
            print(str)
        }
        
    }


    
    func biBao(finished : (String) ->())  {
        
        let re = "数据咯"
        finished(re)
        
    }


}
