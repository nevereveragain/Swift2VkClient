//
//  FriendsSceneController.swift
//  Swift2VkClient
//
//  Created by yosh on 20.05.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import RealmSwift

class FriendsSceneController : UITableViewController {
    var friendsList = [
        "Ivan Ivanov",
        "Darth Vader",
        "Tom and Jerry"
    ]
    
    var service: VKService?
    var friends = [FriendWithPhoto]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        //        guard let token: String = KeychainWrapper.standard.string(forKey: "userToken") else { return }
        //        service = VKService (token: token)
        //        service?.getFriend(completion: { (friends) in
        //            if let friends = friends {
        //                self.friends = friends
        //                self.tableView.reloadData()
        //            }
        //        })
        
    }
    func loadData() {
        guard let token: String = KeychainWrapper.standard.string(forKey: "userToken") else { return }
        service = VKService (token: token)
        service?.getFriends(completion: { (friends) in
            if let friends = friends {
                self.friends = friends
                self.tableView.reloadData()
            }
        })
//        do {
//            let realm = try Realm()
//            let friendsLoaded = realm.objects(FriendWithPhoto.self).filter("friendID == %@")
//            self.friends = Array(friendsLoaded)
//        } catch {
//            // если произошла ошибка, выводим ее в консоль
//            print(error)
//        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let friendController = segue.destination as? FriendSceneCollectionController {
            if let indexPath = tableView.indexPathForSelectedRow {
                let friend = friends[indexPath.row]
                friendController.title = "\(friend.firstName)" + " " + "\(friend.lastName)"
                friendController.friendAvatar = friend
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            // получаем ячейку из пула
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableToCollection", for: indexPath) as! FriendsSceneCellController
            let friendCell = friends[indexPath.row]
            cell.setFriendCell(friendCell)
            return cell
            
    }
    
}
