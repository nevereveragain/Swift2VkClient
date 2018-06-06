//
//  FriendCollectionCell.swift
//  Swift2VkClient
//
//  Created by yosh on 20.05.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import UIKit
import Kingfisher

class FriendCollectionCell : UICollectionViewCell {
    
    @IBOutlet weak var friendAvatarLarge: UIImageView!
    
    func setFriendCell (_ friend: FriendWithPhoto) {
        // Тут я понял, что надо было делать имя и фамилию разными полями, но в изначальном контексте задачи это не прослеживалось, поэтому пусть пока остается так
        if let friendAvatarURL = URL(string: "\(friend.imageURL)") {
            friendAvatarLarge.kf.setImage(with: friendAvatarURL)
        }
    }
}
