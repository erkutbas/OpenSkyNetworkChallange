//
//  PlanePointAnnotation.swift
//  OpenSkyNetworkChallange
//
//  Created by Erkut Baş on 6/1/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import MapKit

class PlanePointAnnotation: MKPointAnnotation {
    
    var stateData = StateData()
    
    init(data: StateData) {
        self.stateData = data
    }
    
}
