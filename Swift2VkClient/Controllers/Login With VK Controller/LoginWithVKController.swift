//
//  LoginWithVKController.swift
//  Swift2VkClient
//
//  Created by yosh on 25.05.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class LoginWithVKController: UIViewController {
    

    @IBOutlet weak var webView: WKWebView!
    var token: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        webView.navigationDelegate = self
        
        if let request = vkAuthRequest() {
            webView.load(request)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let friendScene = segue.destination as? FriendsSceneController else {return}
        friendScene.token = token
    }
    
    func vkAuthRequest() -> URLRequest? {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "http"
        urlConstructor.host = "oauth.vk.com"
        urlConstructor.path = "/authorize"
        urlConstructor.queryItems = [
            URLQueryItem(name: "client_id", value: "6485589"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "v", value: "5.78")
        ]
        guard let url = urlConstructor.url else { return nil }
        
        return URLRequest(url: url)
    }
    
    func goToScreen () {
        self.performSegue(withIdentifier: "performVk", sender: self)
    }
    // MARK: Lesson 4
    // Спрашивал в телеграме:
    //@swiftcampus у меня вопрос.
    //
    //Контекст - не зная, как прикопать данные, придется работать с prepare(for segue: UIStoryboardSegue, sender: Any?) а значит, тащить токен через вообще все экраны приложения.
    //
    //А с учетом того, что следующий переход у нас идет в таббар контроллер, эта идея выглядит пугающе 🙂
    //
    //Я правильно понимаю, что нам нужно реализовать запросы к апи контакта на том же экране, где мы получили токен?
    
    // На момент, когда у меня было время сделать домашку вы не успели ответить, поэтому прикладываю пока так, думаю, когда мы придем к хранению данных, нужно будет вынести на отдельные экраны эти функции.
    // В целом, если бы понадобилось работать в текущей логике - мне пришлось бы использовать prepare чтобы передать токен на соответствующий экран

    
    // MARK: 4.1
    // Так как у нас в двух заданиях - вывести список друзей и вывести фото друга, я сделал одну функцию, в которой доп.параметром запрошу фотографию друга
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

extension LoginWithVKController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Swift.Void) {
        
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment else {
                decisionHandler(.allow)
                return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map({ $0.components(separatedBy: "=") })
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        if let token = params["access_token"] {
            print(token)
            self.token = token
            loadFriendsListWithPhoto()
            getUserGroups()
            getGroupsFromQuery("Dodo pizza")
            // Для удобства закоментил вызов метода перехода на другой экран
//            goToScreen()
        }
        
        decisionHandler(.allow)
    }
    
}




