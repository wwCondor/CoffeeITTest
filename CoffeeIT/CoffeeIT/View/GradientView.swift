//
//  GradientView.swift
//  CoffeeIT
//
//  Created by Wouter Willebrands on 16/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import UIKit

class GradientView: UIView {
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        guard let gradientLayer = layer as? CAGradientLayer else { return }
        
        let firstColor = UIColor.clear
        let secondColor = UIColor.darkGray.withAlphaComponent(0.5)
        
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.locations = [0.0, 1.0]
    }
}
