//
//  Device.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/23/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import UIKit

class Device: NSObject {

    private var deviceNumber: Int!
    private var deviceID: String!
    private var deviceType: String!
    public enum type_device: String {
        case elite = "Elite"
        case basic = "Basic"
    }
    private var orgID: Int!
    
    public init(deviceNumber: Int, deviceID: String, deviceType: type_device, orgID: Int) {
        self.deviceNumber = deviceNumber
        self.deviceID = deviceID
        self.deviceType = deviceType.rawValue
        self.orgID = orgID
    }
    
}
