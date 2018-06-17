//
//  Group.swift
//  Swift2VkClient
//
//  Created by yosh on 31.05.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Groups: Object {
    
    @objc dynamic var groupName: String = ""
    @objc dynamic var groupID: String = ""
    @objc dynamic var groupPhoto_100: String = ""
    
    convenience init(json: JSON) {
        self.init()
        self.groupName = json["name"].stringValue
        self.groupID = json["id"].stringValue
        self.groupPhoto_100 = json["photo_100"].stringValue
    }
    
    override static func primaryKey() -> String? {
        return "groupID"
    }
}
