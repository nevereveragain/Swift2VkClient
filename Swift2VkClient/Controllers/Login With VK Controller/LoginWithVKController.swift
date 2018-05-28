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
            // MARK: NetworkQueries - файл, в котором вынесены методы работы с сетью
            loadFriendsListWithPhoto()
            getUserGroups()
            getGroupsFromQuery("Dodo pizza")
            // Для удобства закоментил вызов метода перехода на другой экран
//            goToScreen()
        }
        
        decisionHandler(.allow)
    }
    
}




