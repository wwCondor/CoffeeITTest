//
//  DataModel.swift
//  CoffeeIT
//
//  Created by Wouter Willebrands on 15/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import Foundation

struct POI: Codable {
    let _id: String
    let tenderService: Bool
    let openingHours: [OpeningHour]
    let type: Type
    let name: String
    let coverImage: String
    let location: Location
    let shortDescription: String
    let city: String
    
//    static let compassMykonos: POIData = POIData(openingHours: [OpeningHours(day: "Monday", startTime: "09:00", endtime: "01.30")],
//                                                  type: EstablishmentType(name: "Restaurant"),
//                                                  name: "Compass Mykonos",
//                                                  location: Location(coordinates: [25.329118, 37.461028]),
//                                                  city: "Mykonos")
}

struct OpeningHour: Codable {
    let _id: String?
    let day: String?
    let startTime: String?
    let endTime: String?
}

struct Type: Codable {
    let name: String
    let color: String
    let image: String
}

struct Location: Codable {
    let coordinates: [Double]
}



