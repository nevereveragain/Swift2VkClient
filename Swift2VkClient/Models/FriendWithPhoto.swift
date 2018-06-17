//
//  Photo.swift
//  Swift2VkClient
//
//  Created by yosh on 31.05.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class FriendWithPhoto: Object {
    @objc dynamic var friendID: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var imageURL: String = ""
    
    let photos = List<Image>()
    
    convenience init(json: JSON) {
        self.init()
        self.friendID = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.imageURL = json["photo_100"].stringValue
    }
    
    override static func primaryKey() -> String? {
        return "friendID"
    }
    
}
