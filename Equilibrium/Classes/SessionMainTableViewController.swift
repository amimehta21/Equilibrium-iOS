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
    @IBOutlet weak var leftGaitCell: UITableViewCell!
    @IBOutlet weak var rightSwingCell: UITableViewCell!
    @IBOutlet weak var leftSwingCell: UITableViewCell!
    @IBOutlet weak var rightStanceCell: UITableViewCell!
    @IBOutlet weak var leftStanceCell: UITableViewCell!
    @IBOutlet weak var stepsCell: UITableViewCell!
    // @IBOutlet weak var distanceCell: UITableViewCell!
    
    var athleteId: String!
    var trial: Trial!
    var session: Session = Session()
    
    var location = String()
    
    final var SEGUE_SELECT_ORIENTATION = "toOrientation"
    final var SEGUE_SELECT_ACCELERATION = "toAcceleration"
    final var SEGUE_SELECT_VELOCITY = "toVelocity"
    final var SEGUE_SELECT_GRF = "toGRF"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingOverlay.shared.showOverlay(self.view)
        // initialize session from trila ID's here
        let parentDirectory = Finder.buildParentDir(athleteId: athleteId, trialId: "\(trial.getId())")
        print(parentDirectory)
        session = Finder.getSession(forAthlete: athleteId, forTrial: trial)
        location = parentDirectory
        self.tableView.reloadData()
        // location = "/\(session.getID())"
        if let fileName = session.getStats() {
            parseStats(fileName: fileName)
        }
        LoadingOverlay.shared.hideOverlayView()
    }
    
    func parseStats(fileName: String) {
        var path = Finder.buildParentDir(athleteId: athleteId, trialId: "\(trial.getId())")
        path += "/stats/" + fileName.lowercased() + ".json"

        if let jsonObject = FileUtils.getJSON(atPath: path) as? [String: String] {
            rightGaitCell.detailTextLabel?.text = jsonObject["right_gait"]
            leftGaitCell.detailTextLabel?.text = jsonObject["left_gait"]
            rightSwingCell.detailTextLabel?.text = jsonObject["right_swing"]
            leftSwingCell.detailTextLabel?.text = jsonObject["left_swing"]
            rightStanceCell.detailTextLabel?.text = jsonObject["right_stance"]
            leftStanceCell.detailTextLabel?.text = jsonObject["left_stance"]
            stepsCell.detailTextLabel?.text = jsonObject["steps"]
            // distanceCell.detailTextLabel?.text = jsonObject["distance"]
        }
        
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
