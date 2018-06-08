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

//    {
//        didSet {
//            self.tableView.reloadData()
//        }
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let token: String = KeychainWrapper.standard.string(forKey: "userToken") else { return }
        service = VKService (token: token)
//        service?.onGetFriendsSuccess = self.onGetFriends(_:)
//        service?.getGroups(completion: { (groups, error) in
//            if let error = error {
//                print(error)
//                return
//            }
//            if let groups = groups {
//                self.groupList = groups
//                self.tableView.reloadData()
//            }
//        })
        service?.getFriend(completion: { (friends) in
            if let friends = friends {
                self.friends = friends
                self.tableView.reloadData()
            }
        })
        
    }
    func loadData() {
        do {
            let realm = try Realm()
            let friendsLoaded = realm.objects(FriendWithPhoto.self).filter("friendID == %@")
            self.friends = Array(friendsLoaded)
        } catch {
            // если произошла ошибка, выводим ее в консоль
            print(error)
        }
    }
    
//    func loadWDataFromRealm(id: Int) {
//        let repository = VKRepo()
//        self.friends = repository.getUsers(user: id)
//    }
//    func onGetFriends(_ friends: [FriendWithPhoto]) {
//        self.friends = friends
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(friends)
//        return friendsList.count
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
            // получаем имя для конкретной строки
//            let friend1 = friendsList[indexPath.row]
//            // устанавливаем имя в надпись ячейки
//            cell.friendName.text = friend1
            let friendCell = friends[indexPath.row]
            cell.setFriendCell(friendCell)
            return cell
            
    }
    
}
