//
//  LoginTableViewController.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/11/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import UIKit

class LoginTableViewController: UITableViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapSignIn(_ sender: Any) {
        if let username = usernameTextField.text, let password = passwordTextField.text {
            if username == "" {
                showAlert(message: "Please enter your username.", title: "Alert")
            } else if password == "" {
                showAlert(message: "Please enter your password.", title: "Alert")
            } else {
                tryLogin(username: username, password: password)
            }
        }
    }
    
    func tryLogin(username: String, password: String) {
    
    }
    
}
