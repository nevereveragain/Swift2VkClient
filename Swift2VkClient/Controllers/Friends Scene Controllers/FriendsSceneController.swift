//
//  FriendsSceneController.swift
//  Swift2VkClient
//
//  Created by yosh on 20.05.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import UIKit

class FriendsSceneController : UITableViewController {
    var friendsList = [
        "Ivan Ivanov",
        "Darth Vader",
        "Tom and Jerry"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsList.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let weatherController = segue.destination as? FriendSceneCollectionController {
            if let indexPath = tableView.indexPathForSelectedRow {
                let friend = friendsList[indexPath.row]
                weatherController.title = friend
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            // получаем ячейку из пула
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableToCollection", for: indexPath) as! FriendsSceneCellController
            // получаем имя для конкретной строки
            let friend = friendsList[indexPath.row]
            // устанавливаем имя в надпись ячейки
            cell.friendName.text = friend
            return cell
    }
}
