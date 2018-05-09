//
//  ViewController.swift
//  Swift2VkClient
//
//  Created by yosh on 08.05.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var LoginTextfield: UITextField!
    
    @IBOutlet weak var PasswordTextfield: UITextField!
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        // получаем текст логина
        let login = LoginTextfield.text!
        // получаем текст пароль
        let password = PasswordTextfield.text!
        // проверяем верны ли они
        if login == "admin" && password == "yellow!submar1n3" {
            print("You've done it")
        } else {
            print("Maybe later")
        }
    }
    // Здесь будет связь для кнопки входа вконтакте, которая сейчас является заглушкой
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action:
            #selector(self.hideKeyboard))
        // присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func keyboardWasShown(notification: Notification) {
        // получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
        // добавляем отступ внизу UIScrollView равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    //когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // устанавливаем отступ внизу UIScrollView равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Подписываемся на два уведомления, одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name:
            NSNotification.Name.UIKeyboardWillShow, object: nil)
        // Второе когда она пропадает
        NotificationCenter.default.addObserver(self, selector:
            #selector(self.keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide,
                                                                 object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide,
                                                  object: nil)
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
}
