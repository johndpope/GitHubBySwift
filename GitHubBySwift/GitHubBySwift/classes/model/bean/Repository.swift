//
//  Repository.swift
//  CYGithub
//
//  Created by cuiyue on 2017/8/31.
//  Copyright © 2017年 cuiyue. All rights reserved.
//

import Foundation
import ObjectMapper

class Repository: Mappable     {
    
    var  id : String?
    var  name : String?
    var  html_url : String?
    
    var owner : Owner?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        html_url <- map["html_url"]
        owner <- map["owner"]
    }
    
}
