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
    //    var friendsList = [
    //        "Ivan Ivanov",
    //        "Darth Vader",
    //        "Tom and Jerry"
    //    ]
    
    var service: VKService?
    var friends = [FriendWithPhoto]()
    var friendsToUpdate: Results<FriendWithPhoto>!
    var notificationToken: NotificationToken?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
    }
    func loadDataFromRealmViaNotifications () {
        guard let realm = try? Realm() else { return }
        friendsToUpdate = realm.objects(FriendWithPhoto.self)
        notificationToken = friendsToUpdate.observe { changes in
            switch changes {
            case .initial:
                self.tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                self.tableView.endUpdates()
            case .error(let error):
                print(error)
            }
        }
    }
    
    //    func pairTableAndRealm() {
    //        guard let realm = try? Realm() else { return }
    //        cities = realm.objects(City.self)
    //
    //        notificationToken = cities.observe { changes in
    //            switch changes {
    //            case .initial:
    //                self.tableView.reloadData()
    //            case .update(_, let deletions, let insertions, let modifications):
    //                self.tableView.beginUpdates()
    //                self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
    //                self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
    //                self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
    //                self.tableView.endUpdates()
    //            case .error(let error):
    //                print(error)
    //            }
    //        }
    
    
    //TODO: Refactoring
    func loadData() {
        guard let token: String = KeychainWrapper.standard.string(forKey: "userToken") else { return }
        loadDataFromRealmViaNotifications()
        service = VKService (token: token)
        service?.getFriends(completion: { (friends) in
            if let friends = friends {
                self.friends = friends
                self.tableView.reloadData()
            }
        })
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsToUpdate.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let friendController = segue.destination as? FriendSceneCollectionController {
            if let indexPath = tableView.indexPathForSelectedRow {
                let friend = friendsToUpdate[indexPath.row]
                friendController.title = "\(friend.firstName)" + " " + "\(friend.lastName)"
                friendController.friendAvatar = friend
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            // получаем ячейку из пула
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableToCollection", for: indexPath) as! FriendsSceneCellController
            let friendCell = friendsToUpdate[indexPath.row]
            cell.setFriendCell(friendCell)
            return cell
            
    }
    
}
