//
//  Color.swift
//  CoffeeIT
//
//  Created by Wouter Willebrands on 16/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import UIKit

extension UIColor {
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

extension UIColor.Name {
    static let iconColor                = UIColor.Name(name: "IconColor")
    static let iconSelectedColor        = UIColor.Name(name: "IconSelectedColor")
    static let pageBackgroundColor      = UIColor.Name(name: "PageBackgroundColor")
}
