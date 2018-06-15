//
//  UserGroupsListController.swift
//  Swift2VkClient
//
//  Created by yosh on 20.05.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import RealmSwift

class UserGroupListController: UITableViewController {
    
    var groups = [Groups]()
    var service: VKService?
    var groupsToUpdate: Results<Groups>!
    var notificationToken: NotificationToken?
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard let allGroupsController = segue.source as? AllGroupsListController else {
            return
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
    }
    
    func loadDataFromRealmViaNotifications () {
        guard let realm = try? Realm() else { return }
        groupsToUpdate = realm.objects(Groups.self)
        notificationToken = groupsToUpdate.observe { changes in
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
    
    
    func loadData() {
        guard let token: String = KeychainWrapper.standard.string(forKey: "userToken") else { return }
        loadDataFromRealmViaNotifications()
        service = VKService (token: token)
        service?.getGroups(completion: { (groups) in
            if let groups = groups {
                self.groups = groups
                self.tableView.reloadData()
            }
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsToUpdate.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            // получаем ячейку из пула
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! UserGroupsCellController
            // получаем имя для конкретной строки
            let group = groupsToUpdate[indexPath.row]
            // устанавливаем имя в надпись ячейки
            cell.setGroupCell(group)
            return cell
    }
    
    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
    //                            forRowAt indexPath: IndexPath) {
    // если была нажата кнопка удалить
    //        if editingStyle == .delete {
    //            // мы удаляем группу из массива
    //            groups.remove(at: indexPath.row)
    //            // и удаляем строку из таблицы
    //            tableView.deleteRows(at: [indexPath], with: .left)
    //        }
}

