//
//  SessionMainTableViewController.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/15/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import UIKit

class SessionMainTableViewController: UITableViewController {

    @IBOutlet weak var accelerationCell: UITableViewCell!
    @IBOutlet weak var grfCell: UITableViewCell!
    @IBOutlet weak var orientationCell: UITableViewCell!
    @IBOutlet weak var velocityCell: UITableViewCell!
    
    @IBOutlet weak var rightGaitCell: UITableViewCell!
    
    
    var session: Session = Session()
    
    var location = String()
    
    final var SEGUE_SELECT_ORIENTATION = "toOrientation"
    final var SEGUE_SELECT_ACCELERATION = "toAcceleration"
    final var SEGUE_SELECT_VELOCITY = "toVelocity"
    final var SEGUE_SELECT_GRF = "toGRF"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        location = "/\(session.getID())"
        /*if (session.getStats() != nil) {
            parseStats(stats: session.getStats()!)
        }*/
    }
    
    func parseStats(stats: [String: String]) {
        rightGaitCell.detailTextLabel?.text = stats["right_gait"]
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if session.getStats() == nil {
            return 1
        }
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            if (indexPath.row == 0 && session.getAcceleration() == nil) ||
            (indexPath.row == 1 && session.getGRF() == nil) ||
            (indexPath.row == 2 && session.getOrientation() == nil) ||
                (indexPath.row == 3 && session.getVelocity() == nil) {
                return 0
            }
        }
        
        /*
        if let cell = self.tableView.cellForRow(at: indexPath) {
            if (cell == accelerationCell && session.getAcceleration() == nil) ||
                (cell == grfCell && session.getGRF() == nil) ||
                (cell == orientationCell && session.getOrientation() == nil) ||
                (cell == velocityCell && session.getVelocity() == nil)
                {
                return 0
            }
        }*/
        return UITableViewAutomaticDimension
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            if id == SEGUE_SELECT_ORIENTATION  {
                if let nextView = segue.destination as? OrientationMainTableViewController {
                    if let data = session.getOrientation() {
                        nextView.tableData = data
                        nextView.location = location + "/orientation"
                    }
                }
            } else if id == SEGUE_SELECT_GRF {
                if let nextView = segue.destination as? GraphViewController {
                    nextView.name = "Foot"
                    nextView.location = location + "/grf/"
                }
            } else if id == SEGUE_SELECT_ACCELERATION {
                if let nextView = segue.destination as? SessionDetailTableViewController {
                    if let data = session.getAcceleration() {
                        nextView.tableData = data
                        nextView.location = location + "/acceleration"
                    }
                }
            } else if id == SEGUE_SELECT_VELOCITY {
                if let nextView = segue.destination as? SessionDetailTableViewController {
                    if let data = session.getVelocity() {
                        nextView.tableData = data
                        nextView.location = location + "/velocity"
                    }
                }
            }
        }
    }

}
