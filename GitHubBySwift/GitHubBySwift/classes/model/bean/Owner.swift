//
//  owner.swift
//  CYGithub
//
//  Created by cuiyue on 2017/9/1.
//  Copyright © 2017年 cuiyue. All rights reserved.
//

import Foundation
import ObjectMapper

class Owner: Mappable {
    var  id : String?
    var  avatar_url : String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        avatar_url <- map["avatar_url"]
    }
}

