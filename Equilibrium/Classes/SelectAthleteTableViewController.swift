//
//  SelectAthleteTableViewController.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/11/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import UIKit

class SelectAthleteTableViewController: UITableViewController {

    private final var CELL_IDENTIFIER = "cell"
    private final var SEGUE_SELECT_ATHLETE = "select_athlete"

    var list: [Athlete] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // fetch list of athletes for this specific trainer
        let absolute = ["Foot", "Forearm", "Hand", "Shank", "Thigh", "Trunk", "Upperarm"]
        let relative = ["Ankle", "Elbow", "Hip", "Knee", "Shoulder", "Wrist"]
        let orientationDetail = ["Absolute": absolute, "Relative": relative]
        var s102 = Session(name: "Running - 5/5/2016",
                        id: 102,
                        acceleration: ["Body", "Foot", "Forearm", "Shank", "Thigh", "Trunk", "Upperarm", "Wrist"],
                        grf: "Foot",
                        orientation: ["Frontal": orientationDetail,
                                      "Sagittal": orientationDetail,
                                      "Transverse": orientationDetail],
                        stats: "Gait",
                        velocity: ["Foot", "Speed"])
        
        var s101 = Session(name: "Basketball - 4/2/2017",
                           id: 101,
                           acceleration: nil,
                           grf: "Foot",
                           orientation: ["Frontal": orientationDetail,
                                         "Sagittal": orientationDetail,
                                         "Transverse": orientationDetail],
                           stats: nil,
                           velocity: nil)
        
        list.append(Athlete(name: "Bryshon Nellum", sessions: [s101, s102]))
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let athlete = list[indexPath.row]
        cell.textLabel?.text = athlete.getName()
        return cell
    }
    
    // pass the selected athlete to the next screen, which displays a list of sessions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil && segue.identifier! == SEGUE_SELECT_ATHLETE {
            if let nextView = segue.destination as? SelectSessionTableViewController, let path = self.tableView.indexPathForSelectedRow {
                nextView.athlete = list[path.row]
            }
        }
    }
    

}
