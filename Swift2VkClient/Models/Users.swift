//
//  User.swift
//  Swift2VkClient
//
//  Created by yosh on 31.05.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Users: Object {
    
    @objc dynamic var first_name: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var last_name: String = ""
    @objc dynamic var photo_100: String = ""
    
    convenience init(json: JSON) {
        self.init()
        self.first_name = json["first_name"].stringValue
        self.id = json["id"].stringValue
        self.last_name = json["last_name"].stringValue
        self.photo_100 = json["photo_100"].stringValue
    }
}

