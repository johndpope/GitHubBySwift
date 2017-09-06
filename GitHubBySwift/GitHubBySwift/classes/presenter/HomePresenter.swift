//
//  HomePresenter.swift
//  CYGithub
//
//  Created by cuiyue on 2017/8/31.
//  Copyright © 2017年 cuiyue. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeView: NSObjectProtocol {
    
    func showProgress()
    func hideProgress()
    func showError()
    func showErrorMsg(msg: String)
    func showEmpty()
    func showHomeList(repositorys: [Repository])
    func showRefreshRepositories(repositorys: [Repository])
    func showMoreRepositories(repositorys: [Repository])
}

class  HomePresenter {
    
    weak fileprivate var homeView : HomeView?
    
    let disposeBag = DisposeBag()
    
    let type = "public" //一页显示多少条
    let per_page = 10 //一页显示多少条
    var page = 1 // 当前的页数
    
    func attachView(view: HomeView){
        homeView = view
    }
    
    func detachView(){
        homeView = nil
    }
    
    
    func loadRepositories (){
        
        self.homeView?.showProgress()
        
        appServiceProvider.request(.showRepositories(type: type, per_page: String(per_page), page: String(page)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .showAPIErrorToast()
            .mapArray(type: Repository.self)
            .subscribe(onNext: { (repositorys : [Repository]) in
                self.homeView?.hideProgress()
                self.homeView?.showHomeList(repositorys: repositorys)
            }, onError: { (Error) in
                 self.homeView?.showError()
            })
            .addDisposableTo(disposeBag)
        
    }
    
    func loadRefreshRepositories (){
        
        page = 1
        
        appServiceProvider.request(.showRepositories(type: type, per_page: String(per_page), page: String(page)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .showAPIErrorToast()
            .mapArray(type: Repository.self)
            .subscribe(onNext: { (repositorys : [Repository]) in
                self.homeView?.showRefreshRepositories(repositorys: repositorys)
            }, onError: { (Error) in
            })
            .addDisposableTo(disposeBag)
    }
    
    func loadMoreRepositories (){
        page = page + 1
        
        appServiceProvider.request(.showRepositories(type: type, per_page: String(per_page), page: String(page)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .showAPIErrorToast()
            .mapArray(type: Repository.self)
            .subscribe(onNext: { (repositorys : [Repository]) in
                self.homeView?.showMoreRepositories(repositorys: repositorys)
            }, onError: { (Error) in
            })
            .addDisposableTo(disposeBag)
    }
    
}
