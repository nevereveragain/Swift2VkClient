//
//  Message.swift
//  Swift2VkClient
//
//  Created by yosh on 27.06.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Message: Object {
    
    @objc dynamic var ownerId: Int = 0
    @objc dynamic var messageId: Int = 0
    @objc dynamic var messageText: String = ""
//    @objc dynamic var groupPhoto_100: String = ""
    
    convenience init(json: JSON) {
        self.init()
        self.messageText = json["text"].stringValue
        self.ownerId = json["peer_id"].intValue
        self.messageId = json["id"].intValue
//        self.groupPhoto_100 = json["photo_100"].stringValue
    }
    
    override static func primaryKey() -> String? {
        return "messageId"
    }
}

