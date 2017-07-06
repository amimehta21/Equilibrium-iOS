//
//  FirstViewController.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/11/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    // this segue does not currently exist
    private final var SEGUE_TO_LOGIN = "toLogin"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did load!")
        self.performSegue(withIdentifier: SEGUE_TO_LOGIN, sender: self)
        
    }
    
}
