//
//  WeatherView.swift
//  CoffeeIT
//
//  Created by Wouter Willebrands on 20/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import UIKit

class WeatherView: UIView {
    
    lazy var temperatureInfoBox: WeatherInfoView = {
        let temperatureInfoBox = WeatherInfoView()
        temperatureInfoBox.translatesAutoresizingMaskIntoConstraints = false
        temperatureInfoBox.backgroundColor = UIColor.clear
        return temperatureInfoBox
    }()
    
    lazy var windInfoBox: WeatherInfoView = {
        let windInfoBox = WeatherInfoView()
        windInfoBox.translatesAutoresizingMaskIntoConstraints = false
        windInfoBox.backgroundColor = UIColor.clear
        return windInfoBox
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
        addSubview(temperatureInfoBox)
        addSubview(windInfoBox)
        
        NSLayoutConstraint.activate([
            temperatureInfoBox.leadingAnchor.constraint(equalTo: leadingAnchor),
            temperatureInfoBox.trailingAnchor.constraint(equalTo: centerXAnchor),
            temperatureInfoBox.topAnchor.constraint(equalTo: topAnchor),
            temperatureInfoBox.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            windInfoBox.leadingAnchor.constraint(equalTo: centerXAnchor),
            windInfoBox.trailingAnchor.constraint(equalTo: trailingAnchor),
            windInfoBox.topAnchor.constraint(equalTo: topAnchor),
            windInfoBox.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

class WeatherInfoView: UIView {
    
    lazy var weatherIcon: UIImageView = {
        let weatherIcon = UIImageView()
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.contentMode = .scaleAspectFit
        weatherIcon.backgroundColor = UIColor.clear
        return weatherIcon
    }()
    
    lazy var topLabel: UILabel = {
        let topLabel = UILabel()
        topLabel.textColor = UIColor.black
        topLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        topLabel.text = "-°C"
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.backgroundColor = UIColor.clear
        return topLabel
    }()
    
    lazy var bottomLabel: UILabel = {
        let bottomLabel = UILabel()
        bottomLabel.textColor = UIColor.darkGray
        bottomLabel.font = UIFont.systemFont(ofSize: 10.0, weight: .light)
        bottomLabel.text = "-"
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.backgroundColor = UIColor.clear
        return bottomLabel
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
        addSubview(weatherIcon)
        addSubview(topLabel)
        addSubview(bottomLabel)
        
        NSLayoutConstraint.activate([
            weatherIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.weatherInfoViewPadding),
            weatherIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherIcon.widthAnchor.constraint(equalToConstant: Constant.weatherIconSize),
            weatherIcon.heightAnchor.constraint(equalToConstant: Constant.weatherIconSize),
            
            topLabel.leadingAnchor.constraint(equalTo: weatherIcon.trailingAnchor),
            topLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            topLabel.topAnchor.constraint(equalTo: weatherIcon.topAnchor),
            topLabel.bottomAnchor.constraint(equalTo: weatherIcon.centerYAnchor),

            bottomLabel.leadingAnchor.constraint(equalTo: weatherIcon.trailingAnchor),
            bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            bottomLabel.topAnchor.constraint(equalTo: weatherIcon.centerYAnchor),
            bottomLabel.bottomAnchor.constraint(equalTo: weatherIcon.bottomAnchor),
        ])
    }
}
