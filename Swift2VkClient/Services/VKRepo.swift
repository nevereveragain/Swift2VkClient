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
    
    func saveUsersData(_ users: [Object]) {
    let realm = try! Realm()
        do {
            
            try realm.write {
            realm.add(users)
//            print("\r⚡️: \(Thread.current)\r" + "🏭: \(OperationQueue.current?.underlyingQueue?.label ?? "None")\r")
            print(realm.configuration.fileURL)
            }
        } catch {
            print(error)
        }
    }
}
