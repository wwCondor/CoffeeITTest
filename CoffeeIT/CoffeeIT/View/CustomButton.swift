//
//  CustomButton.swift
//  CoffeeIT
//
//  Created by Wouter Willebrands on 15/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        addtionalSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
        addtionalSetup()
    }
    
    func setupButton() {
        contentMode = .center
        imageView?.contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
    }
    
    func addtionalSetup() {
        layer.cornerRadius = 10
        backgroundColor = UIColor.white
    }
}

class FilterButton: CustomButton {
    override func addtionalSetup() {
        backgroundColor = UIColor.white
        layer.cornerRadius = Constant.filterButtonCornerRadius
        let image = UIImage(named: .filter)?.withRenderingMode(.alwaysTemplate)
        tintColor = UIColor(named: .iconSelectedColor)
        let inset: CGFloat = Constant.filterIconInsets
        imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        setImage(image, for: .normal)
    }
}

class DismissButton: CustomButton {
    override func addtionalSetup() {
        setTitle("X", for: .normal)
        titleLabel?.textColor = UIColor.white
        titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        backgroundColor = UIColor.clear
    }
}

class SliderDismiss: CustomButton {
    override func addtionalSetup() {
        setTitle("X", for: .normal)
        titleLabel?.textColor = UIColor.black
        titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
    }
}
