//
//  FriendsSceneController.swift
//  Swift2VkClient
//
//  Created by yosh on 20.05.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class FriendsSceneController : UITableViewController {
    var friendsList = [
        "Ivan Ivanov",
        "Darth Vader",
        "Tom and Jerry"
    ]
    var service: VKService?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        guard let token: String = KeychainWrapper.standard.string(forKey: "userToken") else { return }
        
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
//            guard let token: String = KeychainWrapper.standard.string(forKey: "userToken") else {return cell}
            // MARK: ВОПРОС В строчке выше я вытащил токен из кейчейна. Где мне его правильно вытащить так, чтобы он (токен) стал доступен на уровне всего класса FriendSceneController? Правильно ли помещать токен таким образом в гвард, и что лучше возвращать, если токен пропал?
            // MARK: ВОПРОС2 Не получилось привязать данные полученные с помощью VKService к таблице экрана FriendSceneController - получаю разные ошибки связаные с опционалами, например, если обкладываю гвардом строку ниже для извлечения опционала, то получаю ошибку Cannot assign value of type 'VKService' to type 'VKService?'. А если не обкладываю, то даже принт выводит Optional(). Как быть?
//            service = VKService (token: token)
            // получаем имя для конкретной строки
            let friend = friendsList[indexPath.row]
            // устанавливаем имя в надпись ячейки
            cell.friendName.text = friend
            return cell
            // MARK: Вопрос3 Какие типы хранилищ правильней использовать для каких типов данных? Как я понял - UserDefaults для открытых настроек приложения, Keychain - для шифрованых данных (токены, логины-пароли, приватные сесси и и тд), а в базах все, что нужно закешировать? Или есть нюансы?
    }
    
}
