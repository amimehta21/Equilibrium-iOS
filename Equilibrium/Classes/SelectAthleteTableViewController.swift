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
        
        let user = User(userID: 1, name: "Test", email: "", password: "", creationDate: "")
        coach = SimpleCoach(user: user, athletes: [["userId":"0", "name":"Dhiraj"], ["userId":"1","name":"Karan"]])
        self.tableView.reloadData()

        /*LoadingOverlay.shared.showOverlay(self.view)
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
        }*/
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
            
            if row == 0 {
                // for each trial, add here
                
                let t1 = Trial(trialID: 1, name: "Abs - 1", trialType: "", isArchived: false, userID: 0, licenseID: nil, timestamp: "")
                let t2 = Trial(trialID: 2, name: "Jog - 1", trialType: "", isArchived: false, userID: 0, licenseID: nil, timestamp: "")
                let t3 = Trial(trialID: 3, name: "Jog - 2", trialType: "", isArchived: false, userID: 0, licenseID: nil, timestamp: "")
                let t4 = Trial(trialID: 4, name: "Pull Ups - 1", trialType: "", isArchived: false, userID: 0, licenseID: nil, timestamp: "")
                let t5 = Trial(trialID: 5, name: "Pull Ups - 2", trialType: "", isArchived: false, userID: 0, licenseID: nil, timestamp: "")
                let t6 = Trial(trialID: 6, name: "Range of Motion - 2", trialType: "", isArchived: false, userID: 0, licenseID: nil, timestamp: "")
                let t7 = Trial(trialID: 7, name: "Run - 1", trialType: "", isArchived: false, userID: 0, licenseID: nil, timestamp: "")
                let t8 = Trial(trialID: 8, name: "Run - 2", trialType: "", isArchived: false, userID: 0, licenseID: nil, timestamp: "")
                let t9 = Trial(trialID: 9, name: "Squat - 1", trialType: "", isArchived: false, userID: 0, licenseID: nil, timestamp: "")
                let t10 = Trial(trialID: 10, name: "Squat - 2", trialType: "", isArchived: false, userID: 0, licenseID: nil, timestamp: "")
                let t11 = Trial(trialID: 11, name: "Stand-Sit-Stand - 1", trialType: "", isArchived: false, userID: 0, licenseID: nil, timestamp: "")
                let t12 = Trial(trialID: 12, name: "Stand-Sit-Stand - 2", trialType: "", isArchived: false, userID: 0, licenseID: nil, timestamp: "")
                let t13 = Trial(trialID: 13, name: "Toe Touch - 1", trialType: "", isArchived: false, userID: 0, licenseID: nil, timestamp: "")
                let t14 = Trial(trialID: 14, name: "Walk - 1", trialType: "", isArchived: false, userID: 0, licenseID: nil, timestamp: "")
                let t15 = Trial(trialID: 15, name: "Walk - 2", trialType: "", isArchived: false, userID: 0, licenseID: nil, timestamp: "")
                
                let trials: [Trial] = [t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15]
                
                
                nextView.athlete = SimpleAthlete(name: coach.getAthletes()[row]["name"]!, userId: coach.getAthletes()[row]["userId"]!, trials: trials)
            } else if row == 1 {
                
                let t1 = Trial(trialID: 1, name: "Back Kick - 1", trialType: "", isArchived: false, userID: 1, licenseID: nil, timestamp: "")
                let t2 = Trial(trialID: 2, name: "Back Kick - 2", trialType: "", isArchived: false, userID: 1, licenseID: nil, timestamp: "")
                let t3 = Trial(trialID: 3, name: "Bounding Drill - 1", trialType: "", isArchived: false, userID: 1, licenseID: nil, timestamp: "")
                let t4 = Trial(trialID: 4, name: "Bounding Drill - 2", trialType: "", isArchived: false, userID: 1, licenseID: nil, timestamp: "")
                let t5 = Trial(trialID: 5, name: "Fast Leg Drill - 1", trialType: "", isArchived: false, userID: 1, licenseID: nil, timestamp: "")
                let t6 = Trial(trialID: 6, name: "Fast Leg Drill - 2", trialType: "", isArchived: false, userID: 1, licenseID: nil, timestamp: "")
                let t7 = Trial(trialID: 7, name: "Hurdles - 1", trialType: "", isArchived: false, userID: 1, licenseID: nil, timestamp: "")
                let t8 = Trial(trialID: 8, name: "Hurdles - 2", trialType: "", isArchived: false, userID: 1, licenseID: nil, timestamp: "")
                let t9 = Trial(trialID: 9, name: "Run - 1", trialType: "", isArchived: false, userID: 1, licenseID: nil, timestamp: "")
                let t10 = Trial(trialID: 10, name: "Straight Leg Drill - 1", trialType: "", isArchived: false, userID: 1, licenseID: nil, timestamp: "")
                let t11 = Trial(trialID: 11, name: "Straight Leg Drill - 2", trialType: "", isArchived: false, userID: 1, licenseID: nil, timestamp: "")

                
                let trials: [Trial] = [t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11]
                
                nextView.athlete = SimpleAthlete(name: coach.getAthletes()[row]["name"]!, userId: coach.getAthletes()[row]["userId"]!, trials: trials)
            }
            
            print("passed some data")
        }
    }
    

}
