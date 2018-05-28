//
//  NetworkQueries.swift
//  Swift2VkClient
//
//  Created by yosh on 28.05.2018.
//  Copyright © 2018 yosh. All rights reserved.
//


import Alamofire

// MARK: LoginWithVKController
extension LoginWithVKController {
    
    func loadFriendsListWithPhoto() {
        guard let userToken = token else {return}
        let path = "https://api.vk.com/method/friends.get"
        let parameters: Parameters = [
            "access_token": userToken,
            "fields": "photo_100",
            "v": "5.78"
        ]
        
        Alamofire.request(path, parameters: parameters).responseJSON { (response) in
            if let error = response.error {
                print(error)
                return
            }
            
            if let value = response.value {
                print(value)
            }
        }
    }
    
    func getUserGroups() {
        guard let userToken = token else {return}
        let path = "https://api.vk.com/method/groups.get"
        let parameters: Parameters = [
            "access_token": userToken,
            "v": "5.78"
        ]
        
        Alamofire.request(path, parameters: parameters).responseJSON { (response) in
            if let error = response.error {
                print(error)
                return
            }
            
            if let value = response.value {
                print(value)
            }
        }
    }
    
    func getGroupsFromQuery(_ query: String) {
        guard let userToken = token else {return}
        let path = "https://api.vk.com/method/groups.search"
        let parameters: Parameters = [
            "access_token": userToken,
            "v": "5.78",
            "q": query
        ]
        
        Alamofire.request(path, parameters: parameters).responseJSON { (response) in
            if let error = response.error {
                print(error)
                return
            }
            
            if let value = response.value {
                print(value)
            }
        }
    }
}
