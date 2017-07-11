//
//  Session.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/12/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//  

// Session – holds the data types present in the file directory

import Foundation


public class Session {
    private var trial: Trial!
    
    // these hold reference names
    private var acceleration: [String]?
    private var grf: String?
    // i.e. ["frontal":["absolute":["foot.json","forearm.json"],"relative":[]]]
    private var orientation: [String: [String: [String]]]?
    private var stats: String?
    private var velocity: [String]?
    
    init() {
        trial = Trial()
        acceleration = nil
        grf = nil
        orientation = nil
        stats = nil
        velocity = nil
    }
    
    init(trial: Trial, acceleration: [String]?, grf: String?, orientation: [String: [String: [String]]]?, stats: String?, velocity: [String]?) {
        self.trial = trial
        self.acceleration = acceleration
        self.grf = grf
        self.orientation = orientation
        self.stats = stats
        self.velocity = velocity
    }
    
    func getTrial() -> Trial { return trial }
    func getAcceleration() -> [String]? { return acceleration }
    func getGRF() -> String? { return grf }
    func getOrientation() -> [String: [String: [String]]]? { return orientation }
    func getStats() -> String? { return stats }
    func getVelocity() -> [String]? { return velocity }
    
}
