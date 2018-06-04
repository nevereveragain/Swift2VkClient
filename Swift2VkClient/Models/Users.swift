//
//  User.swift
//  Swift2VkClient
//
//  Created by yosh on 31.05.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import Foundation
import SwiftyJSON

class Users {
    
    var first_name: String = ""
    var id: String = ""
    var last_name: String = ""
    var photo_100: String = ""
    
    init(json: JSON) {
        self.first_name = json["first_name"].stringValue
        self.id = json["id"].stringValue
        self.last_name = json["last_name"].stringValue
        self.photo_100 = json["photo_100"].stringValue
    }
}

