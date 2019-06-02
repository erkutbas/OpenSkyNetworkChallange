//
//  PlanePointAnnotation.swift
//  iOS_OpenSky_BiTaksi_Challange
//
//  Created by Erkut Baş on 6/1/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import MapKit

class PlanePointAnnotation: MKPointAnnotation {
    
    var commonPlaceData: CommonPlaceData?
    
    init(data: CommonPlaceData) {
        self.commonPlaceData = data
    }
    
}
