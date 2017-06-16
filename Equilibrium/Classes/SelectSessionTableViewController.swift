//
//  SelectSessionTableViewController.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/11/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import UIKit

class SelectSessionTableViewController: UITableViewController {
    
    private final var CELL_IDENTIFIER = "cell"
    private final var SEGUE_SELECT_SESSION = "select_session"
    
    var athlete: Athlete = Athlete()

    override func viewDidLoad() {
        super.viewDidLoad()
        // fetch list of athletes for this specific trainer
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return athlete.getSessions().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let session = athlete.getSessions()[indexPath.row]
        cell.textLabel?.text = session.getName();
        return cell
    }
    
    // pass the selected athlete to the next screen, which displays a list of sessions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil && segue.identifier! == SEGUE_SELECT_SESSION {
            if let nextView = segue.destination as? SessionMainTableViewController, let path = self.tableView.indexPathForSelectedRow {
                nextView.session = athlete.getSessions()[path.row]
                print("passed")
                print(athlete.getSessions()[path.row].getAcceleration())
            }
        }
    }
    
}
