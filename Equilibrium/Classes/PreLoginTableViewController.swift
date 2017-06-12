//
//  PreLoginTableViewController.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/11/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import UIKit

class PreLoginTableViewController: UITableViewController {

    private final var TRAINER_SEGUE = "trainer"
    private final var ATHLETE_SEGUE = "athlete"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var loginType = String()
        if segue.identifier == TRAINER_SEGUE {
            loginType = TRAINER_SEGUE
        } else if segue.identifier == ATHLETE_SEGUE {
            loginType = ATHLETE_SEGUE
        }
        if let nextView = segue.destination as? LoginTableViewController {
            nextView.loginType = loginType
        }
    }
    

}
