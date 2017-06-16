//
//  OrientationMainTableViewController.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/15/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import UIKit

class OrientationMainTableViewController: UITableViewController {

    var tableData = [String: [String: [String]]]()
    var location = String()
    
    final var SEGUE_SELECT_ORIENTATION = "toOriDetail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.keys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = Array(tableData.keys)[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil && segue.identifier! == SEGUE_SELECT_ORIENTATION {
            if let nextView = segue.destination as? OrientationDetailTableViewController {
                if let path = tableView.indexPathForSelectedRow {
                    let key = Array(tableData.keys)[path.row]
                    if let data = tableData[key] {
                        nextView.tableData = data
                        nextView.location = location + "/\(key.lowercased())"
                    }
                }
            }
        }
    }
    
}
