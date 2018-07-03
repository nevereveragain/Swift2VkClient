//
//  News.swift
//  Swift2VkClient
//
//  Created by yosh on 03.07.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class News: Object {
    
    @objc dynamic var newsType: String = ""
    @objc dynamic var newsSourceId: Int = 0
    @objc dynamic var newsText: String = ""
    @objc dynamic var newsCommentsCount: Int = 0
    @objc dynamic var newsLikesCount: Int = 0
    @objc dynamic var newsRepostsCount: Int = 0
    @objc dynamic var newsPhotoURL: String = ""
    //    @objc dynamic var groupPhoto_100: String = ""
    
    convenience init(json: JSON) {
        self.init()
        self.newsType = json["text"].stringValue
        self.newsSourceId = json["peer_id"].intValue
        self.newsText = json["id"].intValue
        // TODO: На момент написания случилась ерунда с интернетом и получить ответ от серверов вк я не смог, доделаю позже
//        self.newsCommentsCount = json["comments[count]"].intValue
//        self.newsLikesCount = json["likes[count]"].intValue
//        self.newsRepostsCount = json["reposts[count]"].intValue
//        self.newsPhotoURL = json["photo"].stringValue
        //        self.groupPhoto_100 = json["photo_100"].stringValue
    }
    
    override static func primaryKey() -> String? {
        return "messageId"
    }
}
