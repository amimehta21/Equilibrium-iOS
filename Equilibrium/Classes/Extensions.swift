//
//  Extensions.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/12/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(message: String, title: String = "Alert") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
