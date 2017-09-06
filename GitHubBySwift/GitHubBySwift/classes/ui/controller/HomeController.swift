//
//  HomeController.swift
//  GitHubBySwift
//
//  Created by cuiyue on 2017/9/5.
//  Copyright © 2017年 cy. All rights reserved.
//

import UIKit
import MJRefresh
import SDWebImage

class HomeController: UIViewController {
    @IBOutlet weak var mHomeTableView: UITableView!

    var loadingView : LoadingView!
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    
    fileprivate let homePresenter = HomePresenter()
    fileprivate var mRepositorys = [Repository]()
    
    
    let cellId = "homeCell" //CellId
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLoadingView()
        homePresenter.attachView(view: self)
        homePresenter.loadRepositories()
    }


}

extension HomeController {
    
    func initLoadingView() {
        loadingView =  LoadingView.initLoadingView()
        self.view.addSubview(loadingView)
        
        loadingView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(150)
            make.height.equalTo(180)
            make.center.equalTo(self.view)
        }
    }
    
}

extension HomeController : UITableViewDataSource ,UITableViewDelegate{
    
    func initTableView()  {
        self.mHomeTableView.showsVerticalScrollIndicator = false
        self.mHomeTableView.register(UINib(nibName: "HomeCell",bundle: nil), forCellReuseIdentifier: cellId)
        self.mHomeTableView.rowHeight = UITableViewAutomaticDimension
        self.mHomeTableView.estimatedRowHeight = 200
        
        // 下拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(HomeController.headerRefresh))
        self.mHomeTableView.mj_header = header
        
        // 上拉加载更多
        footer.setRefreshingTarget(self, refreshingAction: #selector(HomeController.footerRefresh))
        self.mHomeTableView.mj_footer = footer
        
    }
    
    // 顶部刷新
    func headerRefresh(){
        homePresenter.loadRefreshRepositories()
    }
    
    // 底部刷新
    func footerRefresh(){
        homePresenter.loadMoreRepositories()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mRepositorys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! HomeCell
        
        let repository = mRepositorys[indexPath.row]
        let  owner = repository.owner
        
        cell.nameLabel.text = repository.name
        cell.desLabel.text = repository.html_url
        
        let iconURLString = owner?.avatar_url
        let iconURL = URL(string: iconURLString ?? "")
        cell.iconView.sd_setImage(with: iconURL, placeholderImage: UIImage(named: "avatar_default"), options: [], completed: nil)
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let webViewController = WebViewController()
//        webViewController.repository = mRepositorys[indexPath.row]
//        if let navigationController = navigationController {
//            navigationController.pushViewController(webViewController, animated: true)
//            
//        }
    }
    
    
}


extension HomeController : HomeView {
    
    func showProgress() {
        loadingView.startAnim()
    }
    
    func hideProgress() {
        loadingView.stopAnim()
        loadingView.removeFromSuperview()
    }
    
    func showEmpty() {
    }
    
    func showError() {
    }
    
    func showErrorMsg(msg: String) {
    }
    
    func showHomeList(repositorys: [Repository]) {
        initTableView()
        mRepositorys = repositorys
        mHomeTableView.reloadData()
    }
    
    func showRefreshRepositories(repositorys: [Repository]) {
        mRepositorys = repositorys
        header.endRefreshing()
    }
    
    func showMoreRepositories(repositorys: [Repository]) {
        if repositorys.count == 0  {
            footer.endRefreshingWithNoMoreData()
            return
        }
        mRepositorys += repositorys
        mHomeTableView?.reloadData()
        footer.endRefreshing()
    }
    
}
