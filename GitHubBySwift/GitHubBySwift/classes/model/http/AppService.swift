//
//  Api.swift
//  GitHubBySwift
//
//  Created by cuiyue on 2017/9/5.
//  Copyright © 2017年 cy. All rights reserved.
//

import Foundation
import Moya

let API_PRO = "https://api.github.com"

let headerFields: [String: String] = ["system": "iOS","sys_ver": String(UIDevice.version())]
let publicParameters: [String: String] = ["language": "_zh_CN"]

enum AppService: TargetType {
    case showRepositories(type: String, per_page: String, page: String)
}

extension AppService {
    
    var baseURL: URL {
        return URL(string: API_PRO)!
    }
    
    var path: String {
        switch self {
        case .showRepositories(type: _, per_page: _, page: _):
            return "/orgs/kotlin/repos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .showRepositories(type: _, per_page: _, page: _):
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .showRepositories(type: let type, per_page:  let per_page, page: let page):
            return ["type": type, "per_page": per_page, "page": page]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        return .request
    }
    
}

private let endPointClosure = { (target: AppService) -> Endpoint<AppService> in
    let defaultEndpoint = MoyaProvider<AppService>.defaultEndpointMapping(for: target)
    return defaultEndpoint.adding(parameters: publicParameters as [String : AnyObject]?, httpHeaderFields: headerFields, parameterEncoding: JSONEncoding.default)
}

let appServiceProvider = RxMoyaProvider<AppService>.init()




