//
//  SlideMenuViewModel.swift
//  iOS_OpenSky_BiTaksi_Challange
//
//  Created by Erkut Baş on 6/1/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

class SlideMenuViewModel {
    
    var fligthCount = Dynamic(Int())
    var selectedCountry = Dynamic(String())
    var countryDataState = Dynamic(CollectionDataStatus.none)
    var uniqueCountryList = Array<String>()
    
    func returnCountryCount() -> Int {
        return uniqueCountryList.count
    }
    
    func returnCountryDataByIndex(index: Int) -> String {
        return uniqueCountryList[index]
    }
    
    func createCountryDataWithRawData(stateData: Array<StateData>) {

        uniqueCountryList.removeAll()
        
        countryDataState.value = .loading
        
        var tempCountryList = Array<String>()
        
        for item in stateData {
            tempCountryList.append(item.origin_country)
        }
        
        let uniqueArray = Set(tempCountryList)
        print("uniqueArray : \(uniqueArray.count)")
        
        for item in uniqueArray {
            uniqueCountryList.append(item)
        }
        
        uniqueCountryList.sort { $0 < $1 }
        
        fligthCount.value = tempCountryList.count
        countryDataState.value = .populate
        
    }
    
    func returnComponentCount() -> Int {
        if uniqueCountryList.count > 0 {
            return 1
        } else {
            return 0
        }
    }
    
}
