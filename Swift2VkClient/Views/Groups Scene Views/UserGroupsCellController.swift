//
//  UserGroupCellController.swift
//  Swift2VkClient
//
//  Created by yosh on 20.05.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import UIKit

class UserGroupsCellController : UITableViewCell {
    
    @IBOutlet weak var userGroupImage: UIImageView!
    
    @IBOutlet weak var userGroupName: UILabel!
    
    func setGroupCell (_ group: Groups) {
        userGroupName.text = "\(group.groupName)"
        if let groupAvatarURL = URL(string: "\(group.groupPhoto_100)") {
            userGroupImage.kf.setImage(with: groupAvatarURL)
        }
    }
}
