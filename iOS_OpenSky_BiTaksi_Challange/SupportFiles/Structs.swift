//
//  Structs.swift
//  OpenSkyNetworkChallange
//
//  Created by Erkut Baş on 5/31/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import UIKit

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
    var lomin: String
    var lamin: String
    var lomax: String
    var lamax: String
}

