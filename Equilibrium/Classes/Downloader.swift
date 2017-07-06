//
//  Downloader.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/28/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import Foundation
import UIKit

protocol JSONProtocol: class {
    func itemsDownloaded(json: [String: Any]?)
}

protocol MyURLProtocol: class {
    func contentDownloaded(content: String)
}

public class Downloader: NSObject, URLSessionDataDelegate {
    
    final var KEY_PASSWORD = "pass"
    final var KEY_USERNAME = "user"
    final var KEY_USERID = "user"
    final var KEY_ORG = "org"
    
    enum type: String {
        case auth = "auth"
        case athletes = "athletes"
        case permission = "permission"
        case trials = "trials"
    }
    
    enum key: String {
        case password = "pass"
        case user = "user"
        case organization = "org"
    }
    
    weak var delegate: JSONProtocol!
    
    static var generalURL: String = "http://localhost:8888/eq_mobileapp/service.php?q="
    
    public static func downloadJSONDict(fromURL urlPath: String, completion: @escaping ([String: Any]?) -> Void) {
        downloadText(atURL: urlPath) { (jsonString) in
            if let text = jsonString {
                completion(parseJSONDict(fromText: text))
            } else {
                print("Json string was nil")
                completion(nil)
            }
        }
    }
    
    public static func downloadJSONArray(fromURL urlPath: String, completion: @escaping ([String]?) -> Void) {
        downloadText(atURL: urlPath) { (jsonString) in
            if let text = jsonString {
                completion(parseJSONArray(fromText: text))
            } else {
                print("Json stirng was nil")
                completion(nil)
            }
        }
    }
    
    public static func downloadJSONAny(fromURL urlPath: String, completion: @escaping (Any?) -> Void) {
        downloadText(atURL: urlPath) { (jsonString) in
            if let text = jsonString {
                completion(parseJSONAny(fromText: text))
            } else {
                print("Json stirng was ")
                completion(nil)
            }
        }
    }
    
    
    public static func downloadText(atURL theURL: String, completion: @escaping (String?) -> Void) {
        if let url = URL(string: theURL) {
            do {
                let contents = try String(contentsOf: url)
                completion(contents)
            } catch {
                print("Contents could not be loaded")
                completion(nil)
            }
        } else {
            print("There was a bad url")
            completion(nil)
        }
    }
    
    public static func parseJSONAny(fromText jsonText: String) -> Any? {
        do {
            print(jsonText)
            // convert String to NSData
            if let data = jsonText.data(using: String.Encoding.utf8) as Data? {
                return (try JSONSerialization.jsonObject(with: data))
            } else {
                print("error 3 occurred while parsing")
            }
        } catch let error as NSError {
            print("Error occurred 1 while parsing")
            print(error.localizedDescription)
        }
        return nil
    }
    
    public static func parseJSONDict(fromText jsonText: String) -> [String: Any]? {
        do {
            print(jsonText)
            // convert String to NSData
            if let data = jsonText.data(using: String.Encoding.utf8) as Data?, let parsedData = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                return parsedData
            } else {
                print("error 2 occurred while parsing")
            }
        } catch let error as NSError {
            print("Error occurred while parsing")
            print(error.localizedDescription)
        }
        return nil
    }
    
    public static func parseJSONArray(fromText jsonText: String) -> [String]? {
        do {
            // convert String to NSData
            if let data = jsonText.data(using: String.Encoding.utf8) as Data?, let parsedData = try JSONSerialization.jsonObject(with: data) as? [String] {
                return parsedData
            } else {
                print("error 2 occurred while parsing")
            }
        } catch let error as NSError {
            print("Error occurred while parsing")
            print(error.localizedDescription)
        }
        return nil
    }
    
    public static func buildURL(type: String, parameters: [String: String]) -> String {
        var answer = generalURL
        answer = answer + type
        for (key, value) in parameters {
            answer = answer + "&" + key + "=" + value
        }
        return answer
    }

}
