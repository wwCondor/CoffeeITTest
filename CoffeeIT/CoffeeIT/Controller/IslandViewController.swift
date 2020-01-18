//
//  IslandViewController.swift
//  CoffeeIT
//
//  Created by Wouter Willebrands on 17/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import UIKit

class IslandViewController: UIViewController {
    
    lazy var dismissButton: DismissButton = {
        let dismissButton = DismissButton(type: .custom)
        dismissButton.addTarget(self, action: #selector(popViewController(sender:)), for: .touchUpInside)
        return dismissButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: .pageBackgroundColor)
        
        setupDismissButton()
    }
    
    private func setupDismissButton() {
        view.addSubview(dismissButton)
        
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constant.buttonSpacing),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.buttonPadding),
            dismissButton.widthAnchor.constraint(equalToConstant: Constant.menuBarHeight),
            dismissButton.heightAnchor.constraint(equalToConstant: Constant.menuBarHeight),
        ])
    }
    
    @objc private func popViewController(sender: CustomButton) {
        dismiss(animated: true, completion: nil)
    }
}
