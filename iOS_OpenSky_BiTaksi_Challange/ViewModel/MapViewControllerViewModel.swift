//
//  MapViewControllerViewModel.swift
//  iOS_OpenSky_BiTaksi_Challange
//
//  Created by Erkut Baş on 5/31/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

class MapViewControllerViewModel: CommonViewModel {
    
    var statesListener = Dynamic(ApiCallStatus.none)
    var statesList = Array<CommonPlaceData>()
    var timerTriggerState = Dynamic(TimerControl.none)
    var pathStruct = Dynamic(PathStruct())
    var errorOccured = Dynamic(false)
    
    /// Description: start a url request to get data from OpenSky Network API
    ///
    /// - Parameter openSkyNetworkRequestStruct: input data to create api request
    /// - Author: Erkut Bas
    func getStatesData(openSkyNetworkRequestStruct: OpenSkyNetworkRequestStruct) {
        
        guard let urlRequest = OpenSkyNetworkManager.shared.createUrlRequest(openSkyNetworkRequestStruct: openSkyNetworkRequestStruct) else { return }
        print("urlRequest : \(urlRequest)")
        
        // stop timer, because user starts a network connection to API
        self.changeTimerListenerValue(timerControlStatus: .stop)
        
        switch openSkyNetworkRequestStruct.callType {
        case .stateVectorsAll:
            // getting open sky network state data operation is just beginning
            self.changeStateListenerValue(apiCallStatus: .process)

            OpenSkyNetworkManager.shared.startUrlRequest(type: OpenSkyNetworkData.self, urlRequest: urlRequest) { (result) in
                self.handleGenericResponse(response: result)
            }
            
        case .updatedLocationValue:
            OpenSkyNetworkManager.shared.startUrlRequest(type: OpenSkyLocationUpdateData.self, urlRequest: urlRequest) { (result) in
                self.handleGenericResponse(response: result)
            }
            break
        }
        
    }
    
    func handleGenericResponse<T>(response: Result<T, Error>) {
        switch response {
        case .failure(let error):
            print("Error : \(error)")
            errorOccured.value = true
        case .success(let data):
            errorOccured.value = false
            if let data = data as? OpenSkyNetworkData {
                print("OpenSkyNetworkData retrieved")
                self.handleOpenSkyStateData(data: data)
            } else if let data = data as? OpenSkyLocationUpdateData {
                self.handleOpenSkyUpdatedLocationData(data: data)
            }
        }
    }
    
    private func handleOpenSkyStateData(data: OpenSkyNetworkData) {
        
        // clear states list
        self.clearStatesList()
        
        for item in data.states {
            let temp = StateData(data: item)
            statesList.append(temp)
            print("----------------------------------")
            temp.displayData()
        }
        
        // after network connection finishes, start timer
        changeTimerListenerValue(timerControlStatus: .start)
        // getting fresh data operation is finished
        changeStateListenerValue(apiCallStatus: .done)
    }
    
    private func handleOpenSkyUpdatedLocationData(data: OpenSkyLocationUpdateData) {
        var tempArray = Array<PathData>()
        for item in data.path {
            let path = PathData(data: item)
            tempArray.append(path)
        }
        
        let tempPathStruct = PathStruct(icao24: data.icao24, callSign: data.callsign, startTime: data.startTime, endTime: data.endTime, pathData: tempArray)
        
        pathStruct.value = tempPathStruct
    }
    
    private func changeStateListenerValue(apiCallStatus: ApiCallStatus) {
        statesListener.value = apiCallStatus
    }
    
    private func changeTimerListenerValue(timerControlStatus: TimerControl) {
        timerTriggerState.value = timerControlStatus
    }
    
    private func clearStatesList() {
        statesList.removeAll()
    }
    
    func returnStateDataList() -> Array<CommonPlaceData> {
        return self.statesList
    }
    
    func returnFilteredStateData(selectedCountry: String) -> Array<CommonPlaceData>? {
        guard let stateData = statesList as? Array<StateData> else { return nil }
        return stateData.filter { $0.origin_country == selectedCountry }
        
    }
    
}
