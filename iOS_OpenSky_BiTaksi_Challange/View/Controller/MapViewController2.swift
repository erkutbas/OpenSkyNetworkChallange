//
//  MapViewController2.swift
//  iOS_OpenSky_BiTaksi_Challange
//
//  Created by Erkut Baş on 6/2/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit
import MapKit

class MapViewController2: BaseMapViewController {

    private var viewModel = MapViewControllerViewModel()
    private var second = 0
    private var timer: Timer?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("MapViewController didAppear")
        PermissionManager.shared.triggerPermissionCheck(callerViewController: self)
        PermissionManager.shared.completionHandlerPermissionsAcquired = { (granted) -> Void in
            print("granted : \(granted)")
        }
        
    }
    
    deinit {
        viewModel.statesListener.unbind()
        viewModel.timerTriggerState.unbind()
    }
    
    override func prepareViewConfigurations() {
        addMapView()
        addRefreshingView()
        addListeners()
        addSliderMenu()
    }
    
    override func configureMapViewSettings() {
        mapView.delegate = self
        mapView.register(PlaneAnnotationView.self, forAnnotationViewWithReuseIdentifier: PlaneAnnotationView.identifier)
    }

}

// MARK: - major functions for controller
extension MapViewController2 {
    
    private func addMapView() {
        self.view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            ])
    }
    
    private func addRefreshingView() {
        self.view.addSubview(refreshingView)
        
        NSLayoutConstraint.activate([
            
            refreshingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            refreshingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            refreshingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            refreshingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            ])
    }
    
    private func addListeners() {
        // data state listener
        viewModel.statesListener.bind { (status) in
            switch status {
            case .process:
                self.activityManagerOfMapView(active: false)
                self.refreshingViewDisplayManager(active: true)
            case .done, .failed:
                self.activityManagerOfMapView(active: true)
                self.refreshingViewDisplayManager(active: false)
                self.feedDataToMapView()
                self.updateSlideMenuData()
            default:
                break
            }
        }
        
        // timer state listener
        viewModel.timerTriggerState.bind { (timerStatus) in
            switch timerStatus {
            case .start:
                self.timerActivation(active: true)
                break
            case .stop:
                self.timerActivation(active: false)
            default:
                break
            }
        }
        
        // annotation selected listener
        viewModel.pathStruct.bind { (pathStructData) in
            self.triggerUpdatedLocationViewController(data: pathStructData)
        }
    }
    
    private func addSliderMenu() {
        SlideMenuLoader.shared.createSlider(inputView: self.view, delegate: self)
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector.triggerRefreshData, userInfo: nil, repeats: true)
    }
    
    private func activityManagerOfMapView(active: Bool) {
        DispatchQueue.main.async {
            self.mapView.isUserInteractionEnabled = active
        }
    }
    
    private func refreshingViewDisplayManager(active: Bool) {
        refreshingView.activationManager(active: active)
    }
    
    private func feedDataToMapView() {
        self.addAnnotations(data: viewModel.returnStateDataList())
    }
    
    private func updateSlideMenuData() {
        SlideMenuLoader.shared.updateSlideMenuData(data: viewModel.returnStateDataList())
    }
    
    private func resetTimer() {
        self.second = 0
        self.timer?.invalidate()
    }
    
    private func timerActivation(active: Bool) {
        DispatchQueue.main.async {
            if active {
                self.runTimer()
            } else {
                self.resetTimer()
            }
        }
        
    }
    
    @objc fileprivate func triggerRefreshData() {
        print("second : \(second)")
        second += 1
        if second % 100 == 0 {
            self.resetTimer()
            viewModel.getStatesData(openSkyNetworkRequestStruct: getCurrentVisibleRectSkyNetworkRequestStruct())
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.timerActivation(active: false)
    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.resetTimer()
//        self.timerActivation(active: true)
//    }
    
    private func arrangeMapZoomRateAfterLoaded() {
        LocationManager.shared.getCurrentLocationData { (location) in
            self.mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: CONSTANT.MAP_KIT_CONSTANT.ZOOM_DEGREE_0_025, longitudeDelta: CONSTANT.MAP_KIT_CONSTANT.ZOOM_DEGREE_0_025)), animated: true)
            
        }
    }
    
    private func createOpenSkyNetworkRequestStruct(highestNorthCorner: CLLocationCoordinate2D, lowestSouthCorner: CLLocationCoordinate2D) -> OpenSkyNetworkRequestStruct {
        let openSkyNetworkRequestStruct = OpenSkyNetworkRequestStruct(callType: .stateVectorsAll, urlString: CONSTANT.OPEN_SKY_KEYS.URLS.stateAll, lomin: String(describing: highestNorthCorner.longitude), lamin: String(describing: lowestSouthCorner.latitude), lomax: String(describing: lowestSouthCorner.longitude), lamax: String(describing: highestNorthCorner.latitude))
        return openSkyNetworkRequestStruct
    }
    
    private func removeAnnotationsOnMap() {
        for annotation in mapView.annotations {
            if !(annotation is MKUserLocation) {
                mapView.removeAnnotation(annotation)
            }
        }
    }
    
    // caller from outside
    private func addAnnotations(data: Array<CommonPlaceData>) {
        //        mapViewModel.annotationData.value = data
        print("\(#function)")
        
        DispatchQueue.main.async {
            self.removeAnnotationsOnMap()
            
            guard let stateData = data as? Array<StateData> else { return }
            
            for item in stateData {
                //let annotation = MKPointAnnotation()
                let annotation = PlanePointAnnotation(data: item)
                
                guard let latitude = CLLocationDegrees(exactly: item.latitude) else { return }
                guard let longitude = CLLocationDegrees(exactly: item.longitude) else { return }
                
                annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                
                self.mapView.addAnnotation(annotation)
                
            }
            
            print("annotation count : \(self.mapView.annotations.count)")
        }
    }
    
    private func getCurrentVisibleRectSkyNetworkRequestStruct() -> OpenSkyNetworkRequestStruct {
        return createOpenSkyNetworkRequestStruct(highestNorthCorner: mapView.northWestCoordinate, lowestSouthCorner: mapView.southEastCoordinate)
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    private func triggerUpdatedLocationViewController(data: PathStruct) {
        DispatchQueue.main.async {
            
            let updatedLocationViewController = UpdatedLocationInfoViewController(pathStructData: data)
            let navigationController = UINavigationController(rootViewController: updatedLocationViewController)
            navigationController.modalPresentationStyle = .overCurrentContext
            navigationController.modalTransitionStyle = .crossDissolve
            self.present(navigationController, animated: true, completion: nil)
            
            
        }
    }
    
}


// MARK: - MKMapViewDelegate
extension MapViewController2: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("\(#function)")
        viewModel.getStatesData(openSkyNetworkRequestStruct: createOpenSkyNetworkRequestStruct(highestNorthCorner: mapView.northWestCoordinate, lowestSouthCorner: mapView.southEastCoordinate))
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            // Make a fast exit if the annotation is the `MKUserLocation`, as it's not an annotation view we wish to customize.
            return nil
        }
        
        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: PlaneAnnotationView.identifier) as? PlaneAnnotationView else { return nil }
        
        annotationView.delegate = self
//        annotationView.frame.size.height = 50
//        annotationView.frame.size.width = 50
        
        return annotationView
        
    }
    
}

// MARK: - MapViewProtocols
extension MapViewController2: MapViewProtocols {
    func planeAnnotationSelected(data: CommonPlaceData) {
        guard let stateData = data as? StateData else { return }
        print("icao24 : \(stateData.icao24)")
        
        viewModel.getStatesData(openSkyNetworkRequestStruct: OpenSkyNetworkRequestStruct(callType: .updatedLocationValue, urlString: CONSTANT.OPEN_SKY_KEYS.URLS.updatedLocation, ica024: stateData.icao24, time: "0"))
    }
}

// MARK: - SlideMenuProtocols
extension MapViewController2: SlideMenuProtocols {
    func returnSelectedCountry(country: String) {
        print("country: \(country)")
        guard let filteredData = viewModel.returnFilteredStateData(selectedCountry: country) else { return }
        self.resetTimer()
        self.timerActivation(active: true)

        delay(1) {
            SlideMenuLoader.shared.animateSlideMenu(active: false)
        }
        
        SlideMenuLoader.shared.updateFlightCount(count: filteredData.count)
        addAnnotations(data: filteredData)
    }
    
}

// MARK: - get frame coordinates and mapKit location data
extension MKMapView {
    var northWestCoordinate: CLLocationCoordinate2D {
        return MKMapPoint(x: visibleMapRect.minX, y: visibleMapRect.minY).coordinate
    }
    
    var northEastCoordinate: CLLocationCoordinate2D {
        return MKMapPoint(x: visibleMapRect.maxX, y: visibleMapRect.minY).coordinate
    }
    
    var southEastCoordinate: CLLocationCoordinate2D {
        return MKMapPoint(x: visibleMapRect.maxX, y: visibleMapRect.maxY).coordinate
    }
    
    var southWestCoordinate: CLLocationCoordinate2D {
        return MKMapPoint(x: visibleMapRect.minX, y: visibleMapRect.maxY).coordinate
    }
}

// MARK: - Selector
fileprivate extension Selector {
    static let triggerRefreshData = #selector(MapViewController2.triggerRefreshData)
}

