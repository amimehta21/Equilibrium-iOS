//
//  Athlete.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/12/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import Foundation

public class Athlete: NSObject {
    
    private var athleteID: Int!
    private var userID: Int!
    private var dob: Date!
    private var gender: Character!
    public enum type_gender: Character {
        case male = "M"
        case female = "F"
    }
    private var height_ft: Int!
    private var height_in: Int!
    private var heightUnit: String! // "cms" or "ft" or ","
    public enum type_height_unit: String {
        case cms = "cms"
        case ft = "ft"
        case comma = ","
    }
    private var weight: Int!
    private var weightUnit: String! // "lb" or "kg"
    public enum unit_weight: String {
        case lb = "lb";
        case kg = "kg";
    }
    
    public init(athleteID: Int, userID: Int, dob: Date, gender: type_gender, height_ft: Int, height_in: Int, heightUnit: type_height_unit, weight: Int, weightUnit: unit_weight) {
        self.athleteID = athleteID
        self.userID = userID
        self.dob = dob
        self.gender = gender.rawValue
        self.height_ft = height_ft
        self.height_in = height_in
        self.heightUnit = heightUnit.rawValue
        self.weight = weight
        self.weightUnit = weightUnit.rawValue
    }
    
    public static func parse(json: [String: Any]) -> Athlete? {
        return nil
    }
    
}
