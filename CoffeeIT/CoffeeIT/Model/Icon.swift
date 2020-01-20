//
//  Icon.swift
//  CoffeeIT
//
//  Created by Wouter Willebrands on 15/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import UIKit

extension UIImage {
    struct Name: RawRepresentable {
        typealias RawValue = String

        var rawValue: RawValue

        var name: String { return rawValue}

        init(rawValue: String) {
            self.rawValue = rawValue
        }

        init(name: String) {
            self.init(rawValue: name)
        }
    }

    convenience init?(named: Name) {
        self.init(named: named.name)
    }
}

extension UIImage.Name {
    static let filter            = UIImage.Name(name: "Filter")
    static let tree              = UIImage.Name(name: "Tree")
    static let discover          = UIImage.Name(name: "Discover")
    static let profile           = UIImage.Name(name: "Profile")
    static let windDirection     = UIImage.Name(name: "WindDirection")

}
