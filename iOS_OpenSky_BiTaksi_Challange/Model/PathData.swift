//
//  PathData.swift
//  iOS_OpenSky_BiTaksi_Challange
//
//  Created by Erkut Baş on 6/2/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import UIKit

class PathData: CommonPlaceData {
    
    var time            : Int
    var latitude        : CGFloat
    var longitude       : CGFloat
    var baro_altitude   : CGFloat
    var true_track      : CGFloat
    var on_ground       : Bool
    
    init() {
        
        time            = CONSTANT.NUMERICS.INT_ZERO
        latitude        = CONSTANT.NUMERICS.FLOAT_ZERO
        longitude       = CONSTANT.NUMERICS.FLOAT_ZERO
        baro_altitude   = CONSTANT.NUMERICS.FLOAT_ZERO
        true_track      = CONSTANT.NUMERICS.FLOAT_ZERO
        on_ground       = CONSTANT.NUMERICS.BOOL_FALSE
        
    }
    
    init(data: Array<Path>) {
        
        switch data[0] {
        case .double(let data):
            time = Int(data)
        default:
            time = CONSTANT.NUMERICS.INT_ZERO
        }
        
        switch data[1] {
        case .double(let data):
            latitude = CGFloat(data)
        default:
            latitude = CONSTANT.NUMERICS.FLOAT_ZERO
        }

        switch data[2] {
        case .double(let data):
            longitude = CGFloat(data)
        default:
            longitude = CONSTANT.NUMERICS.FLOAT_ZERO
        }
        
        switch data[3] {
        case .double(let data):
            baro_altitude = CGFloat(data)
        default:
            baro_altitude = CONSTANT.NUMERICS.FLOAT_ZERO
        }
        
        switch data[4] {
        case .double(let data):
            true_track = CGFloat(data)
        default:
            true_track = CONSTANT.NUMERICS.FLOAT_ZERO
        }
        
        switch data[5] {
        case .bool(let data):
            on_ground = data
        default:
            on_ground = CONSTANT.NUMERICS.BOOL_FALSE
        }
        
        
    }
    
    func displayData() {
        
        print("time         : \(time)")
        print("latitude     : \(latitude)")
        print("longitude    : \(longitude)")
        print("baro_altitude: \(baro_altitude)")
        print("true_track   : \(true_track)")
        print("on_ground    : \(on_ground)")
        
    }
    
    
    
}
