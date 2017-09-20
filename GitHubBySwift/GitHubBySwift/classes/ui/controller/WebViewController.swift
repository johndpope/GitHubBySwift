//
//  WebViewController.swift
//  GitHubBySwift
//
//  Created by cuiyue on 2017/9/7.
//  Copyright © 2017年 cy. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var loadingView : LoadingView!
    
    var repository : Repository?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTitle()
        initLoadingView()
        setupWebView()
    }
    
}

extension WebViewController {
    
    func initTitle() {
        self.title = repository?.name
    }
    
    func initLoadingView() {
        loadingView =  LoadingView.initLoadingView()
        self.view.addSubview(loadingView)
        
        loadingView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(150)
            make.height.equalTo(180)
            make.center.equalTo(self.view)
        }
        
        loadingView.startAnim()
    }
    
}

extension WebViewController : UIWebViewDelegate {
    
    //设置WebView
    func setupWebView (){
        let html_url = repository?.html_url
        let url = URL(string: html_url ?? "https://www.baidu.com")!
        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        loadingView.startAnim()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loadingView.stopAnim()
        loadingView.removeFromSuperview()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        loadingView.stopAnim()
        loadingView.removeFromSuperview()
    }
    
    //打开新的页面时候，会调用。返回true继续加载该网页，返回false则不加载
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        //        let url = request.url!.absoluteString
        return true
    }
    
}
