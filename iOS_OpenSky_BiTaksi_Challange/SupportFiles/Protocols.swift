//
//  Protocols.swift
//  OpenSkyNetworkChallange
//
//  Created by Erkut Baş on 5/31/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

protocol MapViewProtocols: class {
    func returnLatLongData(openSkyNetworkRequestStruct: OpenSkyNetworkRequestStruct)
    func planeAnnotationSelected(data: StateData)
}

extension MapViewProtocols {
    func returnLatLongData(openSkyNetworkRequestStruct: OpenSkyNetworkRequestStruct) {}
    func planeAnnotationSelected(data: StateData) {}
}

protocol SlideMenuProtocols: class {
    func returnSelectedCountry(country: String)
}

protocol CommonPlaceData {}
