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
    
    var coach: SimpleCoach!

    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingOverlay.shared.showOverlay(self.view)
        if let orgID = coach.getUser().getOrgID() {
            print("isUserManager: \(coach.getUser().getIsUserManager())")
            print("isUserAthlete: \(coach.getUser().getIsAthlete())")

            let userPath = Downloader.buildURL(type: User.urlKeys.athletes.rawValue, parameters: [User.urlKeys.user.rawValue: "\(coach.getUser().getUserID())", User.urlKeys.org.rawValue: "\(orgID)"])
            
            // download & parse a list of athletes for this coach
            Downloader.downloadJSONAny(fromURL: userPath, completion: { (snapshot) in
                self.itemsDownloaded(snapshot: snapshot)
            })
        } else {
            print("org id not found")
        }
    }
    
    func itemsDownloaded(snapshot: Any?) {
        if let athletes = snapshot as? [[String: String]] {
            coach.setAthletes(athletes: athletes)
            self.tableView.reloadData()
            LoadingOverlay.shared.hideOverlayView()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coach.getAthletes().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let athlete = coach.getAthletes()[indexPath.row]
        cell.textLabel?.text = athlete["name"]
        return cell
    }
    
    // pass the selected athlete to the next screen, which displays a list of sessions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == SEGUE_SELECT_ATHLETE, let nextView = segue.destination as? SelectSessionTableViewController {
            let row = self.tableView.indexPathForSelectedRow!.row
            nextView.athlete = SimpleAthlete(name: coach.getAthletes()[row]["name"]!, userId: coach.getAthletes()[row]["userId"]!)
        }
    }
    

}
