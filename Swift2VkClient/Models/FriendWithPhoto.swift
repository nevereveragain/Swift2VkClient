//
//  Photo.swift
//  Swift2VkClient
//
//  Created by yosh on 31.05.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import Foundation
import SwiftyJSON

class FriendWithPhoto {
    var friendID: Int = 0
    var firstName: String = ""
    var lastName: String = ""
    var imageURL: String = ""
    
    init(json: JSON) {
        self.friendID = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.imageURL = json["photo_100"].stringValue
    }
}
