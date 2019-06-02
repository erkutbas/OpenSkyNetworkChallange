//
//  OpenSkyNetworkData.swift
//  OpenSkyNetworkChallange
//
//  Created by Erkut Baş on 5/31/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let openSkyNetworkData = try? newJSONDecoder().decode(OpenSkyNetworkData.self, from: jsonData)

import Foundation

// MARK: - OpenSkyNetworkData
class OpenSkyNetworkData: Codable {
    let time: Int
    let states: [[State]]
    
    init(time: Int, states: [[State]]) {
        self.time = time
        self.states = states
    }
}

enum State: Codable {
    case bool(Bool)
    case double(Double)
    case string(String)
    case null
    
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
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(State.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for State"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

