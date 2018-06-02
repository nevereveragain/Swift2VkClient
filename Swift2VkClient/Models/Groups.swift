//
//  Group.swift
//  Swift2VkClient
//
//  Created by yosh on 31.05.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import Foundation
import SwiftyJSON

class Groups {
    
    var groupName: String = ""
    var groupId: String = ""
    var groupPhoto_100: String = ""
    
    init(json: JSON) {
        self.groupName = json["name"].stringValue
        self.groupId = json["id"].stringValue
        self.groupPhoto_100 = json["photo_100"].stringValue
    }
}
