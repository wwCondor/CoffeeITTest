//
//  WeatherModel.swift
//  CoffeeIT
//
//  Created by Wouter Willebrands on 20/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import UIKit

struct Weather: Codable {
    let currently: CurrentWeather
}

struct CurrentWeather: Codable {
    let temperature: Double
    let summary: String
    let icon: String
    let windSpeed: Double
    let windBearing: Double
}

extension CurrentWeather {
    var iconImage: UIImage {
        switch icon {
        case "clear-day": return #imageLiteral(resourceName: "clear-day")
        case "clear-night": return #imageLiteral(resourceName: "clear-night")
        case "rain": return #imageLiteral(resourceName: "rain")
        case "snow": return #imageLiteral(resourceName: "snow")
        case "sleet": return #imageLiteral(resourceName: "sleet")
        case "wind": return #imageLiteral(resourceName: "wind")
        case "fog": return #imageLiteral(resourceName: "fog")
        case "cloudy": return #imageLiteral(resourceName: "cloudy")
        case "partly-cloudy-day": return #imageLiteral(resourceName: "partly-cloudy-day")
        case "partly-cloudy-night": return #imageLiteral(resourceName: "partly-cloudy-night")
        default: return #imageLiteral(resourceName: "default")
        }
    }
}

struct APIKey {
    static let darkSkyKey: String = "a0f662b5bcd5015b177c687e72eb10e7"
}
