//
//  Reachability.swift
//  CoffeeIT
//
//  Created by Wouter Willebrands on 15/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import SystemConfiguration

struct Reachability {
    // Object that checks internet connection
    private static let reachability = SCNetworkReachabilityCreateWithName( kCFAllocatorDefault, "https://coffeeit.nl/")
    
    static func checkReachable() -> Bool {
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(self.reachability!, &flags)
        
        var isReachable: Bool = false
        
        if (isNetworkReachable(with: flags)) {
            if flags.contains(.isWWAN) {
                isReachable = true
            } else {
                isReachable = true
            }
    
        } else if (!isNetworkReachable(with: flags)) {
            isReachable = false
        }
        
        return isReachable
    }
    
    private static func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachble = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachble && (!needsConnection || canConnectWithoutUserInteraction)
    }
}
