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
    private var timer: Timer?
    private var points = Array<CLLocationCoordinate2D>()
    
    lazy var rightBarButton: UIBarButtonItem = {
        let temp = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: Selector.refreshTriggered)
        temp.isEnabled = false
        return temp
    }()
    
    convenience init(data: SimulationInputs) {
        self.init()
        
        simulationViewModel.simulationData = data
        
    }
    
    override func prepareViewConfigurations() {
        super.prepareViewConfigurations()
        
        self.setViewControllerProperties()
        addListeners()
        self.delay(1) {
            self.refreshingView.activationManager(active: false)
            self.placeFirstPathAnnotation()
        }
        
    }
    
    override func configureMapViewSettings() {
        super.configureMapViewSettings()
        
        setDelegationToMap()
    }

    deinit {
        simulationViewModel.pathData.unbind()
        simulationViewModel.firstAnnotationPlaces.unbind()
        simulationViewModel.simulationFinished.unbind()
    }
    
}

// MARK: - major functions
extension SimulationViewController {
    
    private func setViewControllerProperties() {
        self.title = LocalizedConstants.TitlePrompts.simulationScreen
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func setDelegationToMap() {
        mapView.delegate = self
        mapView.register(PlaneAnnotationView.self, forAnnotationViewWithReuseIdentifier: PlaneAnnotationView.identifier)
    }
    
    private func addListeners() {
        simulationViewModel.firstAnnotationPlaces.bind { (placed) in
            if placed {
                self.startSimulationProcess()
            }
        }
        
        simulationViewModel.simulationFinished.bind { (finish) in
            self.refreshButtonActivationManager(finish: finish)
        }
        
    }
    
    private func removePolyLines() {
        points.removeAll()
        for item in self.mapView.overlays {
            self.mapView.removeOverlay(item)
        }
    }
    
    private func addPolyLine(path: PathData) {
        guard let coordinate = createCoordinate(path: path) else { return }
        points.append(coordinate)
        
        var polyLine = MKPolyline(coordinates: points, count: points.count)
        self.mapView.addOverlay(polyLine)
    }
    
    private func refreshButtonActivationManager(finish: Bool) {
        DispatchQueue.main.async {
            self.rightBarButton.isEnabled = finish
        }
    }
    
    private func placeFirstPathAnnotation() {
        DispatchQueue.main.async {
            
            self.removePolyLines()
            self.removeAnnotationsOnMap()
            
            guard let firstPath = self.simulationViewModel.returnFirstPath() else { return }
            guard let coordinate = self.createCoordinate(path: firstPath) else { return }
            
            let annotation = PlanePointAnnotation(data: firstPath)
            annotation.coordinate = coordinate
            
            self.mapView.addAnnotation(annotation)
            
            self.changeMapViewRegion(path: firstPath)
            
            self.simulationViewModel.firstAnnotationPlaces.value = true
            
        }
    }
    
    private func startSimulationProcess(fromIndex index: Int = 0) {
        
        guard let paths = self.simulationViewModel.returnPaths() else { return }
        guard index < paths.count else {
            //timer?.invalidate()
            self.simulationViewModel.simulationFinished.value = true
            return
        }
        
        DispatchQueue.main.async {
            for annotation in self.mapView.annotations {
                if let annotation = annotation as? PlanePointAnnotation {
                    UIView.animate(withDuration: 0.4, animations: {
                        guard let coordinate = self.createCoordinate(path: paths[index]) else { return }
                        annotation.coordinate = coordinate
                        self.changeMapViewRegion(path: paths[index])
                        self.addPolyLine(path: paths[index])
                    })
                }
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: TimeInterval(self.simulationViewModel.returnSimulationTime()), repeats: false) { _ in
            self.startSimulationProcess(fromIndex: index+1)
        }
    }
    
    private func createLocation(path: PathData) -> CLLocation? {
        guard let latitude = CLLocationDegrees(exactly: path.latitude) else { return nil }
        guard let longitude = CLLocationDegrees(exactly: path.longitude) else { return nil }
        
        return CLLocation(latitude: latitude, longitude: longitude)
        
    }
    
    private func createCoordinate(path: PathData) -> CLLocationCoordinate2D? {
        guard let latitude = CLLocationDegrees(exactly: path.latitude) else { return nil }
        guard let longitude = CLLocationDegrees(exactly: path.longitude) else { return nil }
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    private func changeMapViewRegion(path: PathData) {
        DispatchQueue.main.async {
            
            guard let coordinate = self.createCoordinate(path: path) else { return }
            
            UIView.animate(withDuration: 0.3, animations: {
                self.mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)), animated: true)
            })
        }
        
    }
    
    private func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    private func removeAnnotationsOnMap() {
        for annotation in mapView.annotations {
            if !(annotation is MKUserLocation) {
                mapView.removeAnnotation(annotation)
            }
        }
    }
    
    @objc fileprivate func refreshTriggered(_ sender: UIBarButtonItem) {
        print("\(#function)")
        self.removePolyLines()
        self.refreshingView.activationManager(active: true)
        self.startSimulationProcess()
        delay(1) {
            self.refreshingView.activationManager(active: false)
        }
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
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = #colorLiteral(red: 1, green: 0.3098039216, blue: 0.6039215686, alpha: 1)
            polylineRenderer.lineWidth = 2
            polylineRenderer.lineCap = .round
            polylineRenderer.lineJoin = .bevel
            return polylineRenderer
        }
        
        return MKOverlayRenderer()
        
    }
    
}

// MARK: - Selector
fileprivate extension Selector {
    static let refreshTriggered = #selector(SimulationViewController.refreshTriggered)
}
