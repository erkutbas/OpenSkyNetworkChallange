//
//  Structs.swift
//  OpenSkyNetworkChallange
//
//  Created by Erkut Baş on 5/31/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import UIKit
import MapKit

struct PermissionButtonProperty {
    var image: UIImage
    var backgroundColor: UIColor
    var backgroundColorOfIconContainer: UIColor
    var buttonPrompt: String
    var permissionResult: PermissionResult
}

struct OpenSkyNetworkRequestStruct {
    var callType: OpenSkyRestApiCallType
    var urlString: String
    var ica024: String?
    var time: String?
    var lomin: String?
    var lamin: String?
    var lomax: String?
    var lamax: String?
    
    init(callType: OpenSkyRestApiCallType, urlString: String, ica024: String, time: String) {
        self.callType = callType
        self.urlString = urlString
        self.ica024 = ica024
        self.time = time
    }
    
    init(callType: OpenSkyRestApiCallType, urlString: String, lomin: String, lamin: String?, lomax: String?, lamax: String?) {
        self.callType = callType
        self.urlString = urlString
        self.lomin = lomin
        self.lamin = lamin
        self.lomax = lomax
        self.lamax = lamax
    }
}

struct PathStruct {
    let icao24: String?
    let callsign: String?
    let startTime: Int?
    let endTime: Int?
    let pathData: Array<PathData>?
    
    init() {
        self.icao24 = CONSTANT.CHARS.SPACE
        self.callsign = CONSTANT.CHARS.SPACE
        self.startTime = CONSTANT.NUMERICS.INT_ZERO
        self.endTime = CONSTANT.NUMERICS.INT_ZERO
        self.pathData = []
    }
    
    init(icao24: String, callSign: String, startTime: Int, endTime: Int, pathData: Array<PathData>) {
        
        self.icao24 = icao24
        self.callsign = callSign
        self.startTime = startTime
        self.endTime = endTime
        self.pathData = pathData
        
    }
}

