//
//  OpenSkyUpdatedLocationData.swift
//  iOS_OpenSky_BiTaksi_Challange
//
//  Created by Erkut Baş on 6/2/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let openSkyLocationUpdateData = try? newJSONDecoder().decode(OpenSkyLocationUpdateData.self, from: jsonData)

import Foundation

// MARK: - OpenSkyLocationUpdateData
class OpenSkyLocationUpdateData: Codable {
    let icao24: String
    let callsign: String
    let startTime: Int
    let endTime: Int
    let path: [[Path]]
    
    init(icao24: String, callsign: String, startTime: Int, endTime: Int, path: [[Path]]) {
        self.icao24 = icao24
        self.callsign = callsign
        self.startTime = startTime
        self.endTime = endTime
        self.path = path
    }
}

enum Path: Codable {
    case bool(Bool)
    case double(Double)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        throw DecodingError.typeMismatch(Path.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Path"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
}
