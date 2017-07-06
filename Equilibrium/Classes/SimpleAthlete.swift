//
//  SimpleAthlete.swift
//  Equilibrium
//
//  Created by Shomil Jain on 7/5/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import UIKit

class SimpleAthlete: NSObject {

    private var name: String!
    private var userId: String!
    
    private var trials: [Trial]!
    
    public init(name: String, userId: String, trials: [Trial] = []) {
        self.name = name
        self.userId = userId
        self.trials = trials
    }
    
    public func getName() -> String { return name }
    public func getUserId() -> String { return userId }
    public func getTrials() -> [Trial] { return trials }
    
    public func setTrials(trials: [Trial]) {
        self.trials = trials
    }
}
