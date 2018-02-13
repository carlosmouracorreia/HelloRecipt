//
//  LoginViewController.swift
//  HelloRecipe
//
//  Created by NTW-laptop on 12/02/18.
//  Copyright © 2018 Carlos Correia. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var pwd: UITextField!
    var loginClosure : (() ->())!
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let userText = username.text, let pwdText = pwd.text {
        
            if userText.count == 0 || pwdText.count == 0 {
                UIHelpers.presentDialog(title: "Login Error", message: "Empty credential(s)", view: self)
            } else if !isValidEmail(testStr: userText)  {
                    UIHelpers.presentDialog(title: "Login Error", message: "Invalid email address", view: self)
            } else if !isValidPwd(pwd: pwdText) {
                    UIHelpers.presentDialog(title: "Login Error", message: "Password must have min 8 chars, 1 Alphabet Char and 1 number", view: self)
                    self.pwd.text = nil
            } else {
                    User.login()
                    self.loginClosure()
                    return
            }
        }
        
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.view.updateConstraints()
        self.view.layoutIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.username.delegate = self
        self.pwd.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == username {
            pwd.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            loginPressed(loginBtn)
        }
        return false
    }
    
    @IBAction func editingEnd(_ sender: UITextField) {
        //TODO - validation on the boxes. nothing for now
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.username.text = nil
        self.pwd.text = nil
    }
}

extension LoginViewController {
    private func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    private func isValidPwd(pwd: String) -> Bool {
        let pwdRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        
        let pwdTest = NSPredicate(format:"SELF MATCHES %@", pwdRegEx)
        return pwdTest.evaluate(with: pwd)
    }
}
