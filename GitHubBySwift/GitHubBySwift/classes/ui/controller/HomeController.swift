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
import FSPagerView

private let NAVBAR_COLORCHANGE_POINT:CGFloat = -80
private let IMAGE_HEIGHT:CGFloat = 240
private let SCROLL_DOWN_LIMIT:CGFloat = 100
private let LIMIT_OFFSET_Y:CGFloat = -(IMAGE_HEIGHT + SCROLL_DOWN_LIMIT)

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
    
    fileprivate let imageNames = ["ic_banner","ic_banner","ic_banner"]
    fileprivate var numberOfItems = 3
    
    var pagerView : FSPagerView!
    var pageControl: FSPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initLoadingView()
        homePresenter.attachView(view: self)
        homePresenter.loadRepositories()
    }
    
}

extension HomeController {
    
    func initNavigationBar() {
        self.title = "主页"
        
    }
    
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
        let webViewController = WebViewController()
        webViewController.repository = mRepositorys[indexPath.row]
        if let navigationController = navigationController {
            navigationController.pushViewController(webViewController, animated: true)
        }
    }
    
}


extension HomeController : FSPagerViewDataSource, FSPagerViewDelegate {
    
    func initTableViewHeader()  {
        
        let pagerViewH : CGFloat = 200
        let pageControlH : CGFloat = 25
        
        pagerView  = FSPagerView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: pagerViewH))
        pageControl = FSPageControl(frame: CGRect(x: 0, y: pagerViewH - pageControlH, width: kScreenWidth, height: pageControlH))
        pagerView.addSubview(pageControl)
        
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.itemSize = .zero
            
        pageControl.numberOfPages = imageNames.count
        pageControl.contentHorizontalAlignment = .right
        pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        //自动翻页到下一张
        pagerView.isInfinite = true
        //每一页停留的时间
        pagerView.automaticSlidingInterval = 3.0 - self.pagerView.automaticSlidingInterval
    
        mHomeTableView.tableHeaderView = pagerView
        
        pagerView.dataSource  = self
        pagerView.delegate = self
    }
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.numberOfItems
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.textLabel?.text = index.description
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        self.pageControl.currentPage = index
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pageControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.pageControl.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
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
        initTableViewHeader()
        mRepositorys = repositorys
        mHomeTableView.reloadData()
    }
    
    func showRefreshRepositories(repositorys: [Repository]) {
        mRepositorys = repositorys
        header.endRefreshing()
        pagerView.scrollToItem(at: 0, animated: true)
        mHomeTableView.reloadData()
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
