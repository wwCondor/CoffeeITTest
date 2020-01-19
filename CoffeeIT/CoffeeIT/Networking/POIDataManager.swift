//
//  LocationDataManager.swift
//  CoffeeIT
//
//  Created by Wouter Willebrands on 15/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import Foundation

struct POIDataManager {
    typealias POICompletionHandler = ([POI]?, Error?) -> Void
    
    static func getPOI(completion: @escaping POICompletionHandler) {
        
        var allPOI = [POI]()
        Networker.request(url: "https://api.lovemetender.com/pois") { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                guard let places = try? decoder.decode([POI].self, from: data) else { return }
                for place in places {
                    allPOI.append(place)
                }
                completion(places, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
