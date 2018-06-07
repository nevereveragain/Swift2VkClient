//
//  UserGroupsListController.swift
//  Swift2VkClient
//
//  Created by yosh on 20.05.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class UserGroupListController: UITableViewController {
    // Список существующих групп, который потом будет приходить с сервера
    var groupsList = [
        "И этого я ждал 45 минут?",
        "Dype Skogen",
        "CARPENTER BRUT",
        "I am waiting for you last summer"
    ]
    var userGroupList = [Groups]()
    var service: VKService?
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard let allGroupsController = segue.source as? AllGroupsListController else {
            return
        }
        
        if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
            let groupToAdd = allGroupsController.filteredData[indexPath.row]
            if !groupsList.contains(groupToAdd.name) {
                groupsList.append(groupToAdd.name)
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let token: String = KeychainWrapper.standard.string(forKey: "userToken") else { return }
        service = VKService (token: token)
        service?.getGroups(completion: { (groups) in
            if let groups = groups {
                self.userGroupList = groups
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

//                self.tableView.reloadData()
            }
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userGroupList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            // получаем ячейку из пула
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! UserGroupsCellController
            // получаем имя для конкретной строки
            let group = userGroupList[indexPath.row]
            // устанавливаем имя в надпись ячейки
            cell.setGroupCell(group)
            return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        // если была нажата кнопка удалить
        if editingStyle == .delete {
            // мы удаляем группу из массива
            groupsList.remove(at: indexPath.row)
            // и удаляем строку из таблицы
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}
