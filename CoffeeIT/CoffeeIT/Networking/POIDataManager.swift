//
//  LocationDataManager.swift
//  CoffeeIT
//
//  Created by Wouter Willebrands on 15/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import Foundation

struct POIDataManager {
    typealias POICompletionHandler = ([POIData]?, Error?) -> Void
    
    static func getPOI(completion: @escaping POICompletionHandler) {
        let url = URL(string: "https://api.lovemetender.com/pois")!
        
        var allPOI = [POIData]()
        Networker.request(url: url) { (result) in
            switch result {
            case .success(let data):
                guard let places = try? JSONDecoder.dataDecoder.decode([POIData].self, from: data) else { return }
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
