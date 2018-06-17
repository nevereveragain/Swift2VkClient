//
//  Images.swift
//  Swift2VkClient
//
//  Created by yosh on 09.06.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Image: Object {
    @objc dynamic var ownerID = 0
    @objc dynamic var imageURL = ""
    
    convenience init(json: JSON) {
        self.init()
        self.ownerID = json["id"].intValue
        self.imageURL = json["photo_100"].stringValue
    }
    let pix = LinkingObjects(fromType: FriendWithPhoto.self, property: "photos")
}
