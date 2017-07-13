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
    
    var athlete: SimpleAthlete!

    override func viewDidLoad() {
        super.viewDidLoad()
        // LoadingOverlay.shared.showOverlay(self.view)
        // downloadSessions()
    }
    
    func downloadSessions() {
        print("Download sessions for athlete: \(athlete.getUserId())")
        let url = Downloader.buildURL(type: Downloader.type.trials.rawValue, parameters: [Downloader.key.user.rawValue: athlete.getUserId()])
        print(url)
        Downloader.downloadJSONAny(fromURL: url) { (snapshot) in
            if let value = snapshot as? [[String: Any]] {
                print("Parsing")
                self.parseSessions(value)
            }
        }
    }
    
    public func parseSessions(_ value: [[String: Any]]) {
        let trials = Trial.parseFromJSON(value)
        athlete.setTrials(trials: trials)
        self.tableView.reloadData()
        LoadingOverlay.shared.hideOverlayView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return athlete.getTrials().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let trial = athlete.getTrials()[indexPath.row]
        cell.textLabel?.text = trial.getName()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trial = athlete.getTrials()[indexPath.row]
        print("Athlete ID: " + athlete.getUserId())
        print("Trial ID: " + "\(trial.getId())")
    }
    
    
    // pass the selected athlete to the next screen, which displays a list of sessions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil && segue.identifier! == SEGUE_SELECT_SESSION {
            if let nextView = segue.destination as? SessionMainTableViewController, let path = self.tableView.indexPathForSelectedRow {
                nextView.athleteId = athlete.getUserId()
                nextView.trial = athlete.getTrials()[path.row]
                print("passed")
            }
        }
    }
    
}
