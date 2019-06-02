//
//  MapViewControllerViewModel.swift
//  OpenSkyNetworkChallange
//
//  Created by Erkut Baş on 5/31/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

class MapViewControllerViewModel: CommonViewModel {
    
    var statesListener = Dynamic(ApiCallStatus.none)
    var statesList = Array<CommonPlaceData>()
    var timerTriggerState = Dynamic(TimerControl.none)
    
    /// Description: start a url request to get data from OpenSky Network API
    ///
    /// - Parameter openSkyNetworkRequestStruct: input data to create api request
    /// - Author: Erkut Bas
    func getStatesData(openSkyNetworkRequestStruct: OpenSkyNetworkRequestStruct) {
        
        switch openSkyNetworkRequestStruct.callType {
        case .stateVectorsAll:
            // getting open sky network state data operatio is just beginning
            self.changeStateListenerValue(apiCallStatus: .process)
            // stop timer, because user starts a network connection to API
            self.changeTimerListenerValue(timerControlStatus: .stop)
            
            guard let urlRequest = OpenSkyNetworkManager.shared.createUrlRequest(openSkyNetworkRequestStruct: openSkyNetworkRequestStruct) else { return }
            print("urlRequest : \(urlRequest)")
            
            OpenSkyNetworkManager.shared.startUrlRequest(type: OpenSkyNetworkData.self, urlRequest: urlRequest) { (result) in
                self.handleGenericResponse(response: result)
                
                // after network connection finishes, start timer
                self.changeTimerListenerValue(timerControlStatus: .start)
            }
            
        case .updatedLocationValue:
            break
        }
        
    }
    
    func handleGenericResponse<T>(response: Result<T, Error>) {
        switch response {
        case .failure(let error):
            print("Error : \(error)")
            
        case .success(let data):
            if let data = data as? OpenSkyNetworkData {
                print("OpenSkyNetworkData retrieved")
                self.handleResponseData(data: data)
            } else {
                print(".... retrieved")
            }
        }
    }
    
    private func handleResponseData(data: OpenSkyNetworkData) {
        
        // clear states list
        self.clearStatesList()
        
        for item in data.states {
            let temp = StateData(data: item)
            statesList.append(temp)
            print("----------------------------------")
            temp.displayData()
        }
        
        // getting fresh data operation is finished
        changeStateListenerValue(apiCallStatus: .done)
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
