//
//  LoginTableViewController.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/11/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import UIKit

class LoginTableViewController: UITableViewController {

    enum segue_identifiers: String {
        case athlete_login
        case trainer_login
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapSignIn(_ sender: Any) {
        LoadingOverlay.shared.showOverlay(self.view)
        if let username = usernameTextField.text, let password = passwordTextField.text {
            if username == "" {
                LoadingOverlay.shared.hideOverlayView()
                showAlert(message: "Please enter your username.", title: "Alert")
            } else if password == "" {
                LoadingOverlay.shared.hideOverlayView()
                showAlert(message: "Please enter your password.", title: "Alert")
            } else {
                tryLogin(username: username, password: password)
            }
        }
    }
    
    func tryLogin(username: String, password: String) {
        let authPath = Downloader.buildURL(type: "auth", parameters: ["user": username, "pass": password])
        Downloader.downloadJSONDict(fromURL: authPath) { (jsonDict) in
            self.itemsDownloaded(json: jsonDict)
        }
    }
    
    func itemsDownloaded(json: [String : Any]?) {
        if let dict = json {
            print(dict)
            if let thisUser = User.parse(json: dict) {
                continueLogin(thisUser)
            } else {
                print("failure")
            }
        } else {
            showAlert(message: "Your username or password was incorrect. Please try again.")
            LoadingOverlay.shared.hideOverlayView()
        }
    }
    
    func continueLogin(_ thisUser: User) {
        self.user = thisUser
        print(user)
        if user.getIsAthlete() {
            // go to athlete view
            // pass this user object
            self.performSegue(withIdentifier: segue_identifiers.athlete_login.rawValue, sender: self)
        } else if user.getIsUserManager() {
            // go to list of athletes, pass user object
            self.performSegue(withIdentifier: segue_identifiers.trainer_login.rawValue, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segue_identifiers.athlete_login.rawValue {
            // need to build in athlete logic here
            //if let nextView = segue.destination as? SessionMainTableViewController {
            //    nextView.user = user
            //}
        } else if segue.identifier == segue_identifiers.trainer_login.rawValue {
            let navController = segue.destination as! UINavigationController
            let nextView = navController.topViewController as! SelectAthleteTableViewController
            nextView.coach = SimpleCoach(user: user)
        }
    }
    
}
