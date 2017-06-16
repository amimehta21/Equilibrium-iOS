//
//  OrientationDetailTableViewController.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/15/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import UIKit

class OrientationDetailTableViewController: UITableViewController {

    var tableData = [String: [String]]()
    var location = String()
    final var SEGUE_TO_GRAPH = "toGraph"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = Array(tableData.keys)[section]
        return (tableData[key]?.count)!
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(tableData.keys)[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let key = Array(tableData.keys)[indexPath.section]
        cell.textLabel?.text = tableData[key]?[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil && segue.identifier! == SEGUE_TO_GRAPH {
            if let nextView = segue.destination as? GraphViewController {
                if let path = tableView.indexPathForSelectedRow {
                    let key = Array(tableData.keys)[path.section]
                    if let data = tableData[key] {
                        let value = data[path.row]
                        nextView.name = value
                        nextView.location = location + "/\(key.lowercased())/"
                    }
                }
            }
        }
    }
}
