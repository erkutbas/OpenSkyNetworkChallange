//
//  LocalizedConstants.swift
//  iOS_OpenSky_BiTaksi_Challange
//
//  Created by Erkut Baş on 5/30/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

struct LocalizedConstants {
    struct PermissionPrompts {
        static let mainSubject = NSLocalizedString("permissionMainSubject", comment: "")
        static let detailedInformation = NSLocalizedString("permissionDetailedInformation", comment: "")
        static let locationRequest = NSLocalizedString("locationRequest", comment: "")
        static let locationAccessed = NSLocalizedString("locationAccessed", comment: "")
        static let locationEnable = NSLocalizedString("locationEnable", comment: "")

    }
    
    struct SlideMenuPrompts {
        static let filterOptions = NSLocalizedString("filterOptions", comment: "")
        static let detailedFilterOptions = NSLocalizedString("detailedFilterOptions", comment: "")
    }
    
    struct TitlePrompts {
        static let startTime = NSLocalizedString("startTime", comment: "")
        static let endTime = NSLocalizedString("endTime", comment: "")
        static let simulatorSpeed = NSLocalizedString("simulatorSpeed", comment: "")
        static let icao24Info = NSLocalizedString("icao24Info", comment: "")
        static let cancelPrompt = NSLocalizedString("cancelPrompt", comment: "")
        static let simulatePrompt = NSLocalizedString("simulatePrompt", comment: "")
        static let finishPrompt = NSLocalizedString("finishPrompt", comment: "")
        static let simulationScreen = NSLocalizedString("simulationScreen", comment: "")
        static let brokenData = NSLocalizedString("brokenData", comment: "")
    }
}
