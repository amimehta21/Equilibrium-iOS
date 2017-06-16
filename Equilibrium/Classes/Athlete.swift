//
//  Athlete.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/12/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import Foundation

public class Athlete {
    
    private var name: String
    private var sessions: [Session]
    
    init() {
        name = String()
        sessions = []
    }
    
    init(name: String, sessions: [Session]) {
        self.name = name
        self.sessions = sessions
    }
    
    public func getName() -> String {
        return name
    }
    
    public func getSessions() -> [Session] {
        return sessions;
    }
    
    public func containsSession(forID: Int) -> Bool {
        for trial in sessions {
            if trial.getID() == forID {
                return true
            }
        }
        return false
    }
    
    public func addSession(session: Session) {
        sessions.append(session)
    }
    
}
