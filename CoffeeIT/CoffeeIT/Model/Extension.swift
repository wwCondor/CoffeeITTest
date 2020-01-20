//
//  Extension.swift
//  CoffeeIT
//
//  Created by Wouter Willebrands on 15/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlert(description: String, viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: description, preferredStyle: .alert)
        
        let confirmation = UIAlertAction(title: "OK", style: .default) {
            (action) in alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(confirmation)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func presentFailedPermissionActionSheet(description: String, viewController: UIViewController) {
        let actionSheet = UIAlertController(title: nil, message: description, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Ok, take me to Settings", style: .default, handler: { (action) in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString + Bundle.main.bundleIdentifier!) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)}}))
        
        actionSheet.addAction(UIAlertAction(title: "Thanks, but I'll go to settings myself", style: .cancel, handler: { (action) in }))
        viewController.present(actionSheet, animated: true, completion: nil)
    }
}

extension UIView {
    func addGradient(from firstColor: UIColor, to secondColor: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.locations = [0.0, 1.0] // starting locations for colors, currently set to blend in middle
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

//extension Double {
//    func rounded() -> Double {
//        
//    }
//}
