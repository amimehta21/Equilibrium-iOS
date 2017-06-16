//
//  SessionDetailTableViewController.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/15/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import UIKit

class SessionDetailTableViewController: UITableViewController {

    var tableData = [String]()
    var location = String()
    
    final var SEGUE_TO_GRAPH = "toGraph"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableData[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil && segue.identifier! == SEGUE_TO_GRAPH {
            if let nextView = segue.destination as? GraphViewController {
                if let path = tableView.indexPathForSelectedRow {
                    nextView.name = tableData[path.row]
                    nextView.location = location + "/"
                }
            }
        }
    }
}
