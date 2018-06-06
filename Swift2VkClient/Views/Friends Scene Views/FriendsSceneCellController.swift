//
//  FriendsSceneCellController.swift
//  Swift2VkClient
//
//  Created by yosh on 20.05.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import UIKit
import Kingfisher

class FriendsSceneCellController : UITableViewCell {
    
    @IBOutlet weak var friendName: UILabel!
    
    @IBOutlet weak var friendAvatar: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setFriendCell (_ friend: FriendWithPhoto) {
        // Тут я понял, что надо было делать имя и фамилию разными полями, но в изначальном контексте задачи это не прослеживалось, поэтому пусть пока остается так
        friendName.text = "\(friend.firstName)" + " " + "\(friend.lastName)"
        if let friendAvatarURL = URL(string: "\(friend.imageURL)") {
            friendAvatar.kf.setImage(with: friendAvatarURL)
        }
    }
}
