//
//  SimulationViewController.swift
//  iOS_OpenSky_BiTaksi_Challange
//
//  Created by Erkut Baş on 6/2/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit
import MapKit

class SimulationViewController: BaseMapViewController {
    
    private var simulationViewModel = SimulationViewModel()
    
    convenience init(data: SimulationInputs) {
        self.init()
        
    }
    
    override func prepareViewConfigurations() {
        super.prepareViewConfigurations()
        
        self.setViewControllerProperties()
        
    }
    
    override func configureMapViewSettings() {
        super.configureMapViewSettings()
        
        setDelegationToMap()
    }

    deinit {
        simulationViewModel.pathData.unbind()
        simulationViewModel.simulationData.unbind()
    }
    
}

// MARK: - major functions
extension SimulationViewController {
    
    private func setViewControllerProperties() {
        self.title = LocalizedConstants.TitlePrompts.simulationScreen
    }
    
    private func setDelegationToMap() {
        mapView.delegate = self
        mapView.register(PlaneAnnotationView.self, forAnnotationViewWithReuseIdentifier: PlaneAnnotationView.identifier)
    }
    
    private func placeFirstAnnotationToMap(pathData: Array<PathData>) {
        
    }
    
    private func addListeners() {
        simulationViewModel.simulationData.bind { (simulationData) in
            self.startSimulationProcess()
        }
    }
    
    private func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
}

// MARK: - MKMapViewDelegate
extension SimulationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            // Make a fast exit if the annotation is the `MKUserLocation`, as it's not an annotation view we wish to customize.
            return nil
        }
        
        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: PlaneAnnotationView.identifier) as? PlaneAnnotationView else { return nil }
        
        return annotationView
    }
    
    
}
