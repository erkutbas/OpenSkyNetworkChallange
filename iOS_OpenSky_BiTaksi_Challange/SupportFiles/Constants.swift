//
//  Constants.swift
//  OpenSkyNetworkChallange
//
//  Created by Erkut Baş on 5/31/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import UIKit

struct CONSTANT {
    struct MAP_KIT_CONSTANT {
        static var DISTANCE_FILTER_10 : Double = 10.0
        static var DISTANCE_FILTER_50 : Double = 50.0
        static var ZOOM_DEGREE_002 : Double = 0.02
        static var ZOOM_DEGREE_0_0025 : Double = 0.0025
        static var ZOOM_DEGREE_0_005 : Double = 0.005
        static var ZOOM_DEGREE_0_01 : Double = 0.01
        static var ZOOM_DEGREE_0_05 : Double = 0.05
        static var ZOOM_DEGREE_0_025 : Double = 0.025
        static var RADIUS_01 : Double = 0.10
    }
    
    struct OPEN_SKY_KEYS {
        struct URLS {
            static var stateAll : String = "https://Q2FTZTAy:fXUXaJ987hnSu8B@opensky-network.org/api/states/all?"
        }
    }
    
    struct CHARS {
        static let SPACE = ""
    }
    
    struct NUMERICS {
        static let INT_ZERO: Int = 0
        static let FLOAT_ZERO: CGFloat = 0.0
        static let BOOL_FALSE: Bool = false
    }
    
}
