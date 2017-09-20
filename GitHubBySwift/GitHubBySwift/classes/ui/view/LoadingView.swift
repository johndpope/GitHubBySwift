//
//  LoadingView2.swift
//  CYGithub
//
//  Created by cuiyue on 2017/9/1.
//  Copyright © 2017年 cuiyue. All rights reserved.
//

import UIKit
import SwiftyGif
import SnapKit

class LoadingView: UIView {
 
    @IBOutlet weak var loadingLayout: UIView!
    
    var imageview : UIImageView!
    
    class func initLoadingView () -> LoadingView{
        let view = Bundle.main.loadNibNamed("LoadingView", owner: nil, options: nil)!.first as! LoadingView
        return view
    }
    
    override func awakeFromNib() {
        
        let gifManager = SwiftyGifManager(memoryLimit:20)
        let gif = UIImage(gifName: "loading.gif")
        imageview = UIImageView(gifImage: gif, manager: gifManager)
        self.loadingLayout.addSubview(imageview)
        
        imageview.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(150)
            make.height.equalTo(150)
            make.center.equalTo(self.loadingLayout)
        }
        
        
    }
    
    func startAnim() {
        if !imageview.isAnimating {
            imageview.startAnimatingGif()
        }
    }
    
    func stopAnim() {
        if imageview.isAnimating {
            imageview.stopAnimatingGif()
        }
    }
    
}
