//
//  Constant.swift
//  CoffeeIT
//
//  Created by Wouter Willebrands on 15/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import UIKit

struct Constant {
    static let menuBarHeight: CGFloat                = 50
    static let smallButtonHeight: CGFloat            = 50
    static let largeButtonHeight: CGFloat            = 80
    static let buttonPadding: CGFloat                = 25
    static let buttonSpacing: CGFloat                = 15
    static let buttonCenterPadding: CGFloat          = Constant.buttonPadding/3
    static let iconSize: CGFloat                     = 30
    
    static let filterButtonSize: CGFloat             = 50
    static let filterButtonCornerRadius: CGFloat     = Constant.filterButtonSize/2
    static let filterIconInsets: CGFloat             = 15
    
    static let previewHeigth: CGFloat                = Constant.largeButtonHeight + Constant.smallButtonHeight
}
