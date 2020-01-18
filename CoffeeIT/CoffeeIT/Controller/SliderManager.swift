//
//  IbizaSliderManager.swift
//  CoffeeIT
//
//  Created by Wouter Willebrands on 16/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import UIKit

class SliderManager: NSObject {
    
    var modeSelected: ModeSelected = .ibiza // alows re-usability of slider for "ibiza"-button and filter-button
    
    lazy var fadeView: UIView = {
        let fadeView = UIView()
        fadeView.alpha = 0
        fadeView.backgroundColor = UIColor.white
        fadeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSlider(sender:))))
        return fadeView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        return titleLabel
    }()
    
    lazy var sliderView: UIView = {
        let sliderView = UIView()
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        sliderView.backgroundColor = UIColor.white
        sliderView.layer.shadowColor = UIColor.darkGray.cgColor
        sliderView.layer.shadowOpacity = 0.5
        sliderView.layer.shadowOffset = .zero
        sliderView.layer.shadowRadius = 5
//        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissSlider(sender:))) // Alternative for dismissing slider
//        swipeGesture.direction = .up
//        sliderView.addGestureRecognizer(swipeGesture)
        return sliderView
    }()
    
    lazy var dismissButton: SliderDismiss = {
        let dismissButton = SliderDismiss(type: .custom)
        dismissButton.addTarget(self, action: #selector(dismissSlider(sender:)), for: .touchUpInside)
        return dismissButton
    }()
    
    override init() {
        super.init()
    }
    
    func presentSlider(for mode: ModeSelected) {
        switch mode {
        case .ibiza:
            sliderView.backgroundColor = UIColor.lightGray
            dismissButton.backgroundColor = UIColor.lightGray
        case .filter:
            sliderView.backgroundColor = UIColor.white
            dismissButton.backgroundColor = UIColor.white
        }
        
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        if let window = window {
            
            window.addSubview(fadeView)
            window.addSubview(sliderView)
            
            window.addSubview(titleLabel)
            window.addSubview(dismissButton)
            
            fadeView.frame = window.frame
            
            let windowHeight: CGFloat = window.frame.height
            let sliderHeight: CGFloat = windowHeight/3
            
            NSLayoutConstraint.activate([
                sliderView.topAnchor.constraint(equalTo: window.topAnchor),
                sliderView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                sliderView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
                sliderView.heightAnchor.constraint(equalToConstant: sliderHeight),
                
                titleLabel.topAnchor.constraint(equalTo: window.safeAreaLayoutGuide.topAnchor, constant: Constant.buttonPadding),
                titleLabel.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: Constant.buttonPadding),
                titleLabel.trailingAnchor.constraint(equalTo: dismissButton.leadingAnchor, constant: -Constant.buttonPadding),
                titleLabel.heightAnchor.constraint(equalToConstant: Constant.menuBarHeight),
                
                dismissButton.topAnchor.constraint(equalTo: window.safeAreaLayoutGuide.topAnchor, constant: Constant.buttonPadding),
                dismissButton.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -Constant.buttonPadding),
                dismissButton.widthAnchor.constraint(equalToConstant: Constant.menuBarHeight),
                dismissButton.heightAnchor.constraint(equalToConstant: Constant.menuBarHeight),
            ])
            
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseOut,
                animations: {
                    self.fadeView.alpha = 0.4
                    self.sliderView.center.y += windowHeight
                    self.titleLabel.center.y += windowHeight
                    self.dismissButton.center.y += windowHeight
            },
                completion: nil)
        }
    }
    
    @objc private func dismissSlider(sender: UISwipeGestureRecognizer) {
        dismissSliderMenu()
    }
    
    private func dismissSliderMenu() {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: .curveEaseIn,
            animations: {
                self.fadeView.alpha = 0
                self.sliderView.center.y -= self.sliderView.bounds.height
                self.titleLabel.center.y -= self.sliderView.bounds.height
                self.dismissButton.center.y -= self.sliderView.bounds.height
        },
            completion: { _ in
                self.fadeView.removeFromSuperview()
                self.sliderView.removeFromSuperview()
                self.titleLabel.removeFromSuperview()
                self.dismissButton.removeFromSuperview()
        })
    }
}
