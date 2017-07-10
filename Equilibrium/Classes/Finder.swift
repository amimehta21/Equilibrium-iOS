//
//  Finder.swift
//  Equilibrium
//
//  Created by Shomil Jain on 7/8/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import Foundation
import UIKit

public class Finder {
    
    public static func getAvailableFiles(atPath path: String) -> [String] {
        let folders = try? FileManager.default.contentsOfDirectory(atPath: path)
        return (folders ?? [])
    }
    
    public static func buildParentDir(athleteId: String, trialId: String) -> String {
        let folderPath = Bundle.main.path(forResource: "testdata", ofType: "")
        return "\(folderPath!)/\(athleteId)/\(trialId)/"
    }
    
    public static func getSession(forAthlete athleteId: String, forTrial trial: Trial) -> Session {
        
        let absolute = ["Foot", "Forearm", "Hand", "Shank", "Thigh", "Trunk", "Upperarm"]
        let relative = ["Ankle", "Elbow", "Hip", "Knee", "Shoulder", "Wrist"]
        let orientationDetail = ["Absolute": absolute, "Relative": relative]
        var grf: String? = "Foot"
        var orientation: [String: [String: [String]]]? = ["Frontal": orientationDetail,
                          "Sagittal": orientationDetail,
                          "Transverse": orientationDetail]
        var stats: String? = "Gait"
        var velocity: [String]? = ["Foot", "Speed"]
        var acceleration: [String]? = ["Body", "Foot", "Forearm", "Shank", "Thigh", "Trunk", "Upperarm", "Wrist"]
        let path = buildParentDir(athleteId: athleteId, trialId: "\(trial.getId())")
        print("The path is " + path)
        let files = getAvailableFiles(atPath: path)
        print(files)
        if !(files.contains("acceleration")) {
            acceleration = nil
        }
        if !(files.contains("grf")) {
            grf = nil
        }
        if !(files.contains("orientation")) {
            orientation = nil
        }
        if !(files.contains("velocity")) {
            velocity = nil
        }
        if !(files.contains("stats")) {
            stats = nil
        }
        return Session(trial: trial, acceleration: acceleration, grf: grf, orientation: orientation, stats: stats, velocity: velocity)
    }
    
}
