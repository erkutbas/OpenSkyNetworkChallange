//
//  SimulationViewModel.swift
//  iOS_OpenSky_BiTaksi_Challange
//
//  Created by Erkut Baş on 6/2/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

class SimulationViewModel {
    
    var simulationData: SimulationInputs!
    var pathData = Dynamic(Array<PathData>())
    var firstAnnotationPlaces = Dynamic(false)
    var simulationFinished = Dynamic(false)
    
    func returnPaths() -> Array<PathData>? {
        guard let paths = simulationData.paths else { return nil }
        return paths
    }
    
    func returnFirstPath() -> PathData? {
        guard let paths = simulationData.paths else { return nil }
        guard let firstPath = paths.first else { return nil }
        
        print("simulationData.simulationSeconds : \(simulationData.simulationSeconds)")
        print("simulationData.paths : \(simulationData.paths?.count)")
        
        return firstPath
    }
    
    func returnSimulationTime() -> Float {
        guard let seconds = simulationData.simulationSeconds else { return 0.1 }
        guard let paths = simulationData.paths else { return 0.1 }
        
        print("Float(seconds) / Float(paths.count) : \(Float(seconds) / Float(paths.count))")
        
        return Float(seconds) / Float(paths.count)
        
    }
    
    func returnSimulationIsFinished() -> Bool {
        return simulationFinished.value
    }
    
}
