//
//  EnumFile.swift
//  OpenSkyNetworkChallange
//
//  Created by Erkut Baş on 5/31/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

enum PermissionManagerResult {
    case success
    case fail
}

enum PermissionResult {
    case notDetermined
    case denied
    case authorized
}

enum PermissionType {
    case location
}

enum BackendApiError: Error {
    case missingDataError
    case parseDataError
}

enum OpenSkyRestApiCallType {
    case stateVectorsAll
    case updatedLocationValue
}

enum ApiCallStatus {
    case process
    case done
    case failed
    case none
}

enum TimerControl {
    case start
    case stop
    case none
}

enum CollectionDataStatus {
    case loading
    case populate
    case none
}
