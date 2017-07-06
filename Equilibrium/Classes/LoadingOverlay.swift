//
//  LoadingOverlay.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/28/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

public class LoadingOverlay {
    
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var nvActivity: NVActivityIndicatorView!
    var label: UILabel!
    
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    
    public func showOverlay(_ view: UIView!, text: String = "") {
        overlayView = UIView(frame: UIScreen.main.bounds)
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        // add nActivity
        let rect = CGRect(x: overlayView.center.x - 25, y: overlayView.center.y - 25, width: 50, height: 50)
        nvActivity = NVActivityIndicatorView(frame: rect)
        nvActivity.color = .white
        nvActivity.type = .ballClipRotateMultiple
        nvActivity.backgroundColor = .clear
        nvActivity.startAnimating()
        overlayView.addSubview(nvActivity)
        
        let labelRect = CGRect(x: 0, y: overlayView.center.y + 50, width: overlayView.frame.width, height: 30)
        label = UILabel(frame: labelRect)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.minimumScaleFactor = 0.5
        label.textColor = UIColor.white
        label.text = text
        overlayView.addSubview(label)
        
        view.addSubview(overlayView)
    }
    
    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        if nvActivity != nil {
            nvActivity.stopAnimating()
        }
        overlayView.removeFromSuperview()
    }
}
