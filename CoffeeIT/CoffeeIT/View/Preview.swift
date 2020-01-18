//
//  Preview.swift
//  CoffeeIT
//
//  Created by Wouter Willebrands on 18/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import UIKit

class Preview: UIView {
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
        titleLabel.textColor = UIColor.darkGray
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addContent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        addContent()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white
        layer.masksToBounds = true
        layer.cornerRadius = 10
    }
    
    private func addContent() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: Constant.smallButtonHeight)
        ])
    }
}
