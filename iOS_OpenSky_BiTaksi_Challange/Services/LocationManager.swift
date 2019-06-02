//
//  LocationManager.swift
//  iOS_OpenSky_BiTaksi_Challange
//
//  Created by Erkut Baş on 5/31/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    public static let shared = LocationManager()
    
    private var locationManager: CLLocationManager!
    
    // completion handler
    private var completionHandlerForLocationUpdates: ((CLLocation) -> Void)?
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        
        guard let locationManager = self.locationManager else {
            return
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.pausesLocationUpdatesAutomatically = true // Enable automatic pausing
    }
    
    /// Description: starts updating location
    func startUpdateLocation() {
        print("\(#function)")
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    /// Description: stops updating location
    func stopUpdateLocation() {
        print("\(#function)")
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    
    /// Description: It's called to get current location. Starts location update and stop after getting location
    ///
    /// - Parameter completion: completion containing cllocation object
    func getCurrentLocationData(completion: @escaping (CLLocation) -> Void) {
        print("\(#function)")
        if CLLocationManager.locationServicesEnabled() {
            self.startUpdateLocation()
            completionHandlerForLocationUpdates = { (location) -> Void in
                completion(location)
                self.stopUpdateLocation()
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            // Location updates are not authorized.
            self.locationManager.stopUpdatingLocation()
            return
        }
        // Notify the user of any errors.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("\(#function)")
        guard let location = locations.last  else {
            return
        }
        print("location : \(location)")
        completionHandlerForLocationUpdates?(location)
    }
    
    // if location changes need to be listened continuously, call this function from outside
    func listenUpdatedLocation(completion: @escaping (CLLocation) -> Void) {
        completionHandlerForLocationUpdates = completion
    }
    
}



