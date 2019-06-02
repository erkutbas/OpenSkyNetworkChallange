//
//  MapView.swift
//  iOS_OpenSky_BiTaksi_Challange
//
//  Created by Erkut Baş on 5/30/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit
import MapKit

class MapView: BaseView {
    
    lazy var mapView: MKMapView = {
        let temp = MKMapView(frame: .zero)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.showsScale = true
        temp.showsCompass = true
        temp.showsUserLocation = true
        //temp.setUserTrackingMode(.followWithHeading, animated: true)
        temp.delegate = self
        
        temp.register(PlaneAnnotationView.self, forAnnotationViewWithReuseIdentifier: PlaneAnnotationView.identifier)
        
        return temp
    }()
    
    weak var delegate: MapViewProtocols?
    
    override func prepareViewConfigurations() {
        configureViewSetttings()
    }
    
}

// MARK: - major functions
extension MapView {
    
    private func configureViewSetttings() {
        addMapView()
        
    }
    
    private func addMapView() {
        self.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            
            mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: self.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            ])
    }
    
    private func arrangeMapZoomRateAfterLoaded() {
        LocationManager.shared.getCurrentLocationData { (location) in
            
            self.mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: CONSTANT.MAP_KIT_CONSTANT.ZOOM_DEGREE_0_025, longitudeDelta: CONSTANT.MAP_KIT_CONSTANT.ZOOM_DEGREE_0_025)), animated: true)
            
        }
    }
    
    private func createOpenSkyNetworkRequestStruct(highestNorthCorner: CLLocationCoordinate2D, lowestSouthCorner: CLLocationCoordinate2D) -> OpenSkyNetworkRequestStruct {
        
        let openSkyNetworkRequestStruct = OpenSkyNetworkRequestStruct(callType: .stateVectorsAll, urlString: CONSTANT.OPEN_SKY_KEYS.URLS.stateAll, lomin: String(describing: highestNorthCorner.longitude), lamin: String(describing: lowestSouthCorner.latitude), lomax: String(describing: lowestSouthCorner.longitude), lamax: String(describing: highestNorthCorner.latitude))
        print("openSkyNetworkRequestStruct : \(openSkyNetworkRequestStruct)")
        
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
    func addAnnotations(data: Array<CommonPlaceData>) {
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
    
    func getCurrentVisibleRectSkyNetworkRequestStruct() -> OpenSkyNetworkRequestStruct {
        return createOpenSkyNetworkRequestStruct(highestNorthCorner: mapView.northWestCoordinate, lowestSouthCorner: mapView.southEastCoordinate)
    }
    
}

// MARK: - MKMapViewDelegate
extension MapView: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("\(#function)")
        
//        createOpenSkyNetworkRequestStruct(highestNorthCorner: mapView.northWestCoordinate, lowestSouthCorner: mapView.southEastCoordinate)
//
//        print("kuzey batı : \(mapView.northWestCoordinate)")
//        print("kuzey dogu : \(mapView.northEastCoordinate)")
//        print("güney batı : \(mapView.southWestCoordinate)")
//        print("güney dogu : \(mapView.southEastCoordinate))")
//
//        print("lamax : \(mapView.northWestCoordinate.latitude)")
//        print("lomax : \(mapView.southEastCoordinate.longitude)")
//        print("lamin : \(mapView.southWestCoordinate.latitude)")
//        print("lomin : \(mapView.southWestCoordinate.longitude))")
        
        
        guard delegate != nil else {
            return
        }
        
        delegate?.returnLatLongData(openSkyNetworkRequestStruct: createOpenSkyNetworkRequestStruct(highestNorthCorner: mapView.northWestCoordinate, lowestSouthCorner: mapView.southEastCoordinate))
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let planeAnnotation = view.annotation as? PlaneAnnotationView else { return }
        
        guard let annotation = planeAnnotation.annotation as? PlanePointAnnotation else { return }
        
        print("yarro")
        
    }
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("TAKATAKA")
        guard !annotation.isKind(of: MKUserLocation.self) else {
            // Make a fast exit if the annotation is the `MKUserLocation`, as it's not an annotation view we wish to customize.
            return nil
        }
        
        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: PlaneAnnotationView.identifier) as? PlaneAnnotationView else { return nil }
        
        //annotationView.delegate = self
//        annotationView.frame.size.height = 50
//        annotationView.frame.size.width = 50
        
        return annotationView
        
    }
    
}


