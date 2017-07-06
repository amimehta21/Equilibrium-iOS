//
//  Trial.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/23/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import UIKit

class Trial: NSObject {

    public enum keys: String {
        case trialId
        case name
        case trialType
        case isArchived
        case userId
        case licenseId
        case timestamp
    }
    
    private var trialID: Int!
    private var name: String!
    private var trialType: String!
    public enum type_trial: String {
        case elite = "Elite"
        case basic = "Basic"
    }
    private var isArchived: Bool!
    private var userID: Int!
    private var licenseID: Int?
    private var timestamp: String! // Should be int
    
    public init(trialID: Int, name: String, trialType: String, isArchived: Bool, userID: Int, licenseID: Int? = nil, timestamp: String!) {
        self.trialID = trialID
        self.name = name
        self.trialType = trialType
        self.isArchived = isArchived
        self.userID = userID
        self.licenseID = licenseID
        self.timestamp = timestamp
    }
    
    public static func parseFromJSON(_ sessions: [[String: Any]]) -> [Trial] {
        var trials: [Trial] = []
        for item in sessions {
            if let trialId = item[keys.trialId.rawValue] as? String,
                let name = item[keys.name.rawValue] as? String,
                let trialType = item[keys.trialType.rawValue] as? String,
                let isArchived = item[keys.isArchived.rawValue] as? String,
                let userId = item[keys.userId.rawValue] as? String,
                let timestamp = item[keys.timestamp.rawValue] as? String {
                
                var licenseId: Int? = nil
                if let stringLicenseId = item[keys.licenseId.rawValue] as? Int {
                    licenseId = Int(stringLicenseId)
                }
                let newTrial = Trial(trialID: Int(trialId)!, name: name, trialType: trialType, isArchived: GlobalUtils.bool(isArchived), userID: Int(userId)!, licenseID: licenseId, timestamp: timestamp)
                trials.append(newTrial)
            }
        }
        return trials
    }
    
    public func getName() -> String {
        return name
    }
    
    public func getId() -> Int {
        return trialID
    }
}
