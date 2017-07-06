//
//  SimpleCoach.swift
//  Equilibrium
//
//  Created by Shomil Jain on 7/5/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import UIKit

class SimpleCoach: NSObject {

    private var athletes: [[String: String]]!
    private var user: User!
    
    public init(user: User, athletes: [[String: String]] = []) {
        self.user = user
        self.athletes = athletes
    }
    
    public func getAthletes() -> [[String: String]] {
        return athletes
    }
    
    public func setAthletes(athletes: [[String: String]]) {
        self.athletes = athletes
    }
    
    public func getUser() -> User {
        return user
    }
    
}
