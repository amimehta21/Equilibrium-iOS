//
//  FileUtils.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/18/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import Foundation
import UIKit

public class FileUtils {
    
    public static func getJSON(atPath: String) -> [String: Any]? {
        let url = URL(fileURLWithPath: atPath)
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: [])

            if let object = json as? [String: Any] {
                return object
            } else {
                print("JSON is invalid")
                return nil
            }
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    public static func getStringFromFile(atPath: String) -> String? {
        let url = URL(fileURLWithPath: atPath)
        let dataString = try? String(contentsOf: url)
        return dataString
    }

}
