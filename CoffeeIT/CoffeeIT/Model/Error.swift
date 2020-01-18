//
//  Error.swift
//  CoffeeIT
//
//  Created by Wouter Willebrands on 17/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case noData
    case noReachability
}

extension NetworkingError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .noData:                         return "No Data"
        case .noReachability:                 return "No internet, reconnect and try again"
        }
    }
}
