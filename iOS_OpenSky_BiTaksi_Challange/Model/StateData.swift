//
//  StateData.swift
//  OpenSkyNetworkChallange
//
//  Created by Erkut Baş on 5/31/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import UIKit

class StateData: CommonPlaceData {
    
    var icao24          : String
    var callsign        : String
    var origin_country  : String
    var time_position   : Int
    var last_contact    : Int
    var longitude       : CGFloat
    var latitude        : CGFloat
    var baro_altitude   : CGFloat
    var on_ground       : Bool
    var velocity        : CGFloat
    var true_track      : CGFloat
    var vertical_rate   : CGFloat
    var sensors         : [Int]
    var geo_altitude    : CGFloat
    var squawk          : String
    var spi             : Bool
    var position_source : Int
    
    init() {
        
        icao24          = CONSTANT.CHARS.SPACE
        callsign        = CONSTANT.CHARS.SPACE
        origin_country  = CONSTANT.CHARS.SPACE
        time_position   = CONSTANT.NUMERICS.INT_ZERO
        last_contact    = CONSTANT.NUMERICS.INT_ZERO
        longitude       = CONSTANT.NUMERICS.FLOAT_ZERO
        latitude        = CONSTANT.NUMERICS.FLOAT_ZERO
        baro_altitude   = CONSTANT.NUMERICS.FLOAT_ZERO
        on_ground       = CONSTANT.NUMERICS.BOOL_FALSE
        velocity        = CONSTANT.NUMERICS.FLOAT_ZERO
        true_track      = CONSTANT.NUMERICS.FLOAT_ZERO
        vertical_rate   = CONSTANT.NUMERICS.FLOAT_ZERO
        sensors         = [Int]()
        geo_altitude    = CONSTANT.NUMERICS.FLOAT_ZERO
        squawk          = CONSTANT.CHARS.SPACE
        spi             = CONSTANT.NUMERICS.BOOL_FALSE
        position_source = CONSTANT.NUMERICS.INT_ZERO
        
    }

    init(data: Array<State>) {
        
        switch data[0] {
        case .string(let data):
            icao24 = data
        default:
            icao24 = CONSTANT.CHARS.SPACE
        }
        
        switch data[1] {
        case .string(let data):
            callsign = data
        default:
            callsign = CONSTANT.CHARS.SPACE
        }
        
        switch data[2] {
        case .string(let data):
            origin_country = data
        default:
            origin_country = CONSTANT.CHARS.SPACE
        }
        
        switch data[3] {
        case .double(let data):
            time_position = Int(data)
        default:
            time_position = CONSTANT.NUMERICS.INT_ZERO
        }
        
        switch data[4] {
        case .double(let data):
            last_contact = Int(data)
        default:
            last_contact = CONSTANT.NUMERICS.INT_ZERO
        }
        
        switch data[5] {
        case .double(let data):
            longitude = CGFloat(data)
        default:
            longitude = CONSTANT.NUMERICS.FLOAT_ZERO
        }
        
        switch data[6] {
        case .double(let data):
            latitude = CGFloat(data)
        default:
            latitude = CONSTANT.NUMERICS.FLOAT_ZERO
        }
        
        switch data[7] {
        case .double(let data):
            baro_altitude = CGFloat(data)
        default:
            baro_altitude = CONSTANT.NUMERICS.FLOAT_ZERO
        }
        
        switch data[8] {
        case .bool(let data):
            on_ground = data
        default:
            on_ground = CONSTANT.NUMERICS.BOOL_FALSE
        }
        
        switch data[9] {
        case .double(let data):
            velocity = CGFloat(data)
        default:
            velocity = CONSTANT.NUMERICS.FLOAT_ZERO
        }
        
        switch data[10] {
        case .double(let data):
            true_track = CGFloat(data)
        default:
            true_track = CONSTANT.NUMERICS.FLOAT_ZERO
        }
        
        switch data[11] {
        case .double(let data):
            vertical_rate = CGFloat(data)
        default:
            vertical_rate = CONSTANT.NUMERICS.FLOAT_ZERO
        }
        
        // sensors
        /*
        switch data[12] {
        case .string(let data):
            sensors = data
        default:
            sensors = CONSTANT.CHARS.SPACE
        }*/
        sensors         = [Int]()
        
        switch data[13] {
        case .double(let data):
            geo_altitude = CGFloat(data)
        default:
            geo_altitude = CONSTANT.NUMERICS.FLOAT_ZERO
        }
        
        switch data[14] {
        case .string(let data):
            squawk = data
        default:
            squawk = CONSTANT.CHARS.SPACE
        }
        
        switch data[15] {
        case .bool(let data):
            spi = data
        default:
            spi = CONSTANT.NUMERICS.BOOL_FALSE
        }
        
        switch data[16] {
        case .double(let data):
            position_source = Int(data)
        default:
            position_source = CONSTANT.NUMERICS.INT_ZERO
        }
        
    }
    
    func displayData() {
        
        print("icao24 : \(icao24)")
        print("callsign : \(callsign)")
        print("origin_country : \(origin_country)")
        print("time_position : \(time_position)")
        print("last_contact : \(last_contact)")
        print("longitude : \(longitude)")
        print("latitude : \(latitude)")
        print("baro_altitude : \(baro_altitude)")
        print("on_ground : \(on_ground)")
        print("velocity : \(velocity)")
        print("true_track : \(true_track)")
        print("vertical_rate : \(vertical_rate)")
        print("sensors : \(sensors)")
        print("geo_altitude : \(geo_altitude)")
        print("squawk : \(squawk)")
        print("spi : \(spi)")
        print("position_source : \(position_source)")
        
    }
    
}

