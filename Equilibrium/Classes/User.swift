//
//  User.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/23/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import UIKit

class User: NSObject {
    
    enum urlKeys: String {
        case auth
        case user
        case pass
        case athletes
        case org
        case permission
        case trials
    }
    
    enum keys: String {
        case agreeToPolicy
        case canLogin
        case creationDate
        case email
        case isAccountActive
        case isAthlete
        case isDataCollector
        case isDataVisualizer
        case isLicenseAllocator
        case isPurchaser
        case isUserManager
        case name
        case orgId
        case password
        case userId
    }
    
    private var userID: Int!
    private var name: String!
    private var email: String!
    private var password: String!
    private var isAccountActive: Bool!
    private var canLogin: Bool!
    private var isUserManager: Bool!
    private var isAthlete: Bool!
    private var isDataVisualizer: Bool!
    private var agreeToPolicy: Bool!
    private var isLicenseAllocator: Bool!
    private var orgID: Int? // optional
    private var isPurchaser: Bool!
    private var isDataCollector: Bool? // optional
    private var creationDate: String!
    
    public func getUserID() -> Int {
        return userID
    }
    
    public func getName() -> String {
        return name
    }
    
    public func getEmail() -> String {
        return email
    }
    
    public func getPassword() -> String {
        return password
    }
    
    public func getIsAccountActive() -> Bool {
        return isAccountActive
    }
    
    public func getCanLogin() -> Bool {
        return canLogin
    }
    
    public func getIsUserManager() -> Bool {
        return isUserManager
    }
    
    public func getIsAthlete() -> Bool {
        return isAthlete
    }
    
    public func getIsDataVisualizer() -> Bool {
        return isDataVisualizer
    }
    
    public func getAgreeToPolicy() -> Bool {
        return agreeToPolicy
    }
    
    public func getIsLicenseAllocator() -> Bool {
        return isLicenseAllocator
    }
    
    public func getOrgID() -> Int? {
        return orgID
    }
    
    public func getIsPurchaser() -> Bool {
        return isPurchaser
    }
    
    public func getIsDataCollector() -> Bool? {
        return isDataCollector
    }
    
    public func getCreationDate() -> String {
        return creationDate
    }
    
    override var description: String {
        var answer: String = ""
        answer += "****** ATHLETE DESCRIPTION ******" + "\n"
        answer += "User ID = \(userID)" + "\n"
        answer += "Name = \(name)" + "\n"
        answer += "Email = \(email)" + "\n"
        answer += "Password = \(password)" + "\n"
        answer += "isAccountActive = \(isAccountActive)" + "\n"
        answer += "canLogin = \(canLogin)" + "\n"
        answer += "isUserManager = \(isUserManager)" + "\n"
        answer += "isAthlete = \(isAthlete)" + "\n"
        answer += "isDataVisualizer = \(isDataVisualizer)" + "\n"
        answer += "agreeToPolicy = \(agreeToPolicy)" + "\n"
        answer += "isLicenseAllocator = \(isLicenseAllocator)" + "\n"
        answer += "orgID = \(String(describing: orgID))" + "\n"
        answer += "isPurchaser = \(isPurchaser)" + "\n"
        answer += "isDataCollector = \(String(describing: isDataCollector))" + "\n"
        answer += "creationDate = \(creationDate)" + "\n"
        answer += "****** END ATHLETE DESCRIPTION ******"
        return answer
    }
    
    public init(userID: Int, name: String, email: String, password: String, isAccountActive: Bool = true, canLogin: Bool = true, isUserManager: Bool = false, isAthlete: Bool = true, isDataVisualizer: Bool = true, agreeToPolicy: Bool = false, isLicenseAllocator: Bool = false, orgID: Int? = nil, isPurchaser: Bool = false, isDataCollector: Bool? = true, creationDate: String) {
        self.userID = userID
        self.name = name
        self.email = email
        self.password = password
        self.isAccountActive = isAccountActive
        self.canLogin = canLogin
        self.isUserManager = isUserManager
        self.isAthlete = isAthlete
        self.isDataVisualizer = isDataVisualizer
        self.agreeToPolicy = agreeToPolicy
        self.isLicenseAllocator = isLicenseAllocator
        self.orgID = orgID
        self.isPurchaser = isPurchaser
        self.isDataVisualizer = isDataVisualizer
        self.creationDate = creationDate
    }
    
    public static func parse(json: [String: Any]) -> User? {
        if let agreeToPolicy = json[keys.agreeToPolicy.rawValue] as? String,
            let canLogin = json[keys.canLogin.rawValue] as? String,
            let creationDate = json[keys.creationDate.rawValue] as? String,
            let email = json[keys.email.rawValue] as? String,
            let isAccountActive = json[keys.isAccountActive.rawValue] as? String,
            let isAthlete = json[keys.isAthlete.rawValue] as? String,
            let isDataVisualizer = json[keys.isDataVisualizer.rawValue] as? String,
            let isLicenseAllocator = json[keys.isLicenseAllocator.rawValue] as? String,
            let isPurchaser = json[keys.isPurchaser.rawValue] as? String,
            let isUserManager = json[keys.isUserManager.rawValue] as? String,
            let name = json[keys.name.rawValue] as? String,
            let password = json[keys.password.rawValue] as? String,
            let userId = json[keys.userId.rawValue] as? String {
            
            // these may or may not exist
            
            var orgIdInt: Int? = nil
            if let orgIDString = json[keys.orgId.rawValue] as? String {
                orgIdInt = Int(orgIDString)!
            }
            
            var isDataCollectorBool: Bool? = nil
            if let isDataCollectorString = json[keys.isDataCollector.rawValue] as? String {
                isDataCollectorBool = GlobalUtils.bool(isDataCollectorString)
            }
            
            return User(userID: Int(userId)!,
                        name: name,
                        email: email,
                        password: password,
                        isAccountActive: GlobalUtils.bool(isAccountActive),
                        canLogin: GlobalUtils.bool(canLogin),
                        isUserManager: GlobalUtils.bool(isUserManager),
                        isAthlete: GlobalUtils.bool(isAthlete),
                        isDataVisualizer: GlobalUtils.bool(isDataVisualizer),
                        agreeToPolicy: GlobalUtils.bool(agreeToPolicy),
                        isLicenseAllocator: GlobalUtils.bool(isLicenseAllocator),
                        orgID: orgIdInt,
                        isPurchaser: GlobalUtils.bool(isPurchaser),
                        isDataCollector: isDataCollectorBool,
                        creationDate: creationDate)
        }
        
        return nil
    }
    
}
