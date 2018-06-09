//
//  VKRepo.swift
//  Swift2VkClient
//
//  Created by yosh on 06.06.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import Foundation
import RealmSwift

class VKRepo {
    
    func saveUsersData(_ users: [FriendWithPhoto]) {
        let realm = try! Realm()
        let forRemoving = realm.objects(FriendWithPhoto.self)
        do {
            
            try realm.write {
                realm.delete(forRemoving)
                realm.add(users)
                print(realm.configuration.fileURL)
            }
        } catch {
            print(error)
        }
    }
    // TODO: Refactoring
    func saveGroupsData(_ groups: [Groups]) {
        let realm = try! Realm()
        let forRemoving = realm.objects(Groups.self)
        do {
            
            try realm.write {
                realm.delete(forRemoving)
                realm.add(groups)
            }
        } catch {
            print(error)
        }
    }
}
