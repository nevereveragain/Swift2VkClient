//
//  VKService.swift
//  Swift2VkClient
//
//  Created by yosh on 02.06.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import Foundation
import SwiftyJSON
//import Alamofire
import RealmSwift

public var fileURL: URL?
enum VKServiceMethod {
    case getUsers
    case getFriends
    case getPhotos
    case getGroups
    case searchGroups
    
    var methodName: String {
        switch self {
        case .getUsers:
            return "users.get"
        case .getFriends:
            return "friends.get"
        case .getPhotos:
            return "photos.getAll"
        case .getGroups:
            return "groups.get"
        case .searchGroups:
            return "groups.search"
        }
    }
    
    var parameters: String {
        switch self {
        case .getUsers:
            return "fields=photo_100,city,verified"
        case .getFriends:
            return "fields=nickname,photo_100"
        case .getPhotos:
            return ""
        case .getGroups:
            return "extended=1&fields=name,photo_100"
        case .searchGroups:
            return "q="
        }
    }
}
class VKService {
    let token: String
    let baseURL: String = "https://api.vk.com/method/"
    var baseParameters: String {
        return "access_token=\(token)&v=5.78"
    }
    
    init(token: String) {
        self.token = token
    }
    
    func getURLPath(for method: VKServiceMethod) -> String {
        var urlPath = baseURL + method.methodName + "?" + baseParameters
        if method.parameters.count > 0 {
            urlPath += "&" + method.parameters
        }
        return urlPath
    }
    
    func getFriends (completion: @escaping ([FriendWithPhoto]?) -> Void) {
        let urlPath = getURLPath(for: .getFriends)
        guard let url = URL(string: urlPath) else { return }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let json = try? JSON(data: data) {
                    let items = json["response"]["items"].arrayValue
                    let friends = items.map { FriendWithPhoto(json: $0) }
                    let repository = VKRepo()
                    repository.saveUsersData(friends)
                    completion(friends)
                }
            }
        }
        
        task.resume()
    }
    
    
    func getGroups (completion: @escaping ([Groups]?) -> Void) {
        let urlPath = getURLPath(for: .getGroups)
        guard let url = URL(string: urlPath) else { return }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let json = try? JSON(data: data) {
                    let items = json["response"]["items"].arrayValue
                    let groups = items.map { Groups(json: $0) }
                    let repository = VKRepo()
                    repository.saveGroupsData(groups)
                    completion(groups)
                }
            }
        }
        
        task.resume()
    }
    
    
    func groupSearch(_ request: String) {
        let urlPath = getURLPath(for: .searchGroups) + request
        // getURLPath выходил из гварда если в запросе был пробел.   Добавил обработку этого случая - обрезал пробел с помощью addingPercentEncoding
        guard let urlString = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return }
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data, let json = try? JSON(data: data) {
                let items = json["response"]["items"].arrayValue
                let groups = items.map { Groups(json: $0) }
                print(groups)
            }
        }
        task.resume()
    }
    
}

