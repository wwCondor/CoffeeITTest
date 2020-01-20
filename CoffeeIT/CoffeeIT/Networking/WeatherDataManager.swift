
//
//  WeatherDataManagerswift.swift
//  CoffeeIT
//
//  Created by Wouter Willebrands on 20/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import Foundation

struct WeatherDataManager {
    typealias WeatherCompletionHandler = (Weather?, Error?) -> Void
    
    static func getCurrentWeather(latitude: Double, longitude: Double, completion: @escaping WeatherCompletionHandler) {
        let url = "https://api.darksky.net/forecast/\(APIKey.darkSkyKey)/\(latitude),\(longitude)"
        
        Networker.request(url: url) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                guard let weather = try? decoder.decode(Weather.self, from: data) else { return }
                completion(weather, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
