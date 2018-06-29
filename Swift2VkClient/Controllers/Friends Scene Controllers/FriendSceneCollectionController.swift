//
//  FriendsSceneCollectionController.swift
//  Swift2VkClient
//
//  Created by yosh on 20.05.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class FriendSceneCollectionController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var friendAvatar: FriendWithPhoto?
    var service: VKService?
    
    @IBAction func sendText(_ sender: Any) {
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1    
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt IndexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionElement", for: IndexPath) as! FriendCollectionCell
        if let friendAvatar = friendAvatar {
            cell.setFriendCell(friendAvatar)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let cellWidth = width 
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
