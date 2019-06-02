//
//  Protocols.swift
//  iOS_OpenSky_BiTaksi_Challange
//
//  Created by Erkut Baş on 5/31/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

protocol MapViewProtocols: class {
    func returnLatLongData(openSkyNetworkRequestStruct: OpenSkyNetworkRequestStruct)
    func planeAnnotationSelected(data: CommonPlaceData)
}

extension MapViewProtocols {
    func returnLatLongData(openSkyNetworkRequestStruct: OpenSkyNetworkRequestStruct) {}
    func planeAnnotationSelected(data: CommonPlaceData) {}
}

protocol SlideMenuProtocols: class {
    func returnSelectedCountry(country: String)
}

protocol CommonPlaceData {}

protocol CommonViewModel {
    func handleGenericResponse<T: Codable>(response: Result<T, Error>)
}

protocol CenterTemplateProtocols {
    func takasi() 
}
