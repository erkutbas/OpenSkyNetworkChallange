//
//  MapViewController.swift
//  OpenSkyNetworkChallange
//
//  Created by Erkut Baş on 5/30/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    private var viewModel = MapViewControllerViewModel()
    private var second = 0
    private var timer = Timer()
    
    lazy var mapView: MapView = {
        let temp = MapView(frame: .zero)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.delegate = self
        return temp
    }()
    
    lazy var refreshingView: RefreshingView = {
        let temp = RefreshingView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = false
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        prepareViewControllerConfigurations()
        
    }
    
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
    
}

// MARK: - major functions
extension MapViewController {
    
    private func prepareViewControllerConfigurations() {
        addMapView()
        addRefreshingView()
        addListeners()
        addSliderMenu()
        //runTimer()

        //https://{Q2FTZTAy:fXUXaJ987hnSu8B}@opensky-network.org/api/states/all?lomin=27.3445316488&lamin=40.226013967&lomax=30.7411966586&lamax=41.6004635693
        
        //https://{Q2FTZTAy:fXUXaJ987hnSu8B}@opensky-network.org/api/tracks/all?icao24={ICAO-24}&time=0
        //https://{Q2FTZTAy:fXUXaJ987hnSu8B}@opensky-network.org/api/tracks/all?icao24=4249b2&time=0
        
        //https://{Q2FTZTAy:fXUXaJ987hnSu8B}@opensky-network.org/api/states/all?lomin=24.72641500275614&lamin=18.972265810569912&lomax=44.41391500275614&lamax=46.99941509264417
        
            //https://Q2FTZTAy:fXUXaJ987hnSu8B@opensky-network.org/api/tracks/all?icao24=a9d4b5&time=0
    }
    
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
                self.resetTimer()
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
    }
    
    private func addSliderMenu() {
        SlideMenuLoader.shared.createSlider(inputView: self.view, delegate: self)
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector.triggerRefreshData, userInfo: nil, repeats: true)
    }
    
    private func activityManagerOfMapView(active: Bool) {
        DispatchQueue.main.async {
            self.mapView.mapView.isUserInteractionEnabled = active
        }
    }
    
    private func refreshingViewDisplayManager(active: Bool) {
        refreshingView.activationManager(active: active)
    }
    
    private func feedDataToMapView() {
        mapView.addAnnotations(data: viewModel.returnStateDataList())
    }
    
    private func updateSlideMenuData() {
        SlideMenuLoader.shared.updateSlideMenuData(data: viewModel.returnStateDataList())
    }
    
    private func resetTimer() {
        self.second = 0
        self.timer.invalidate()
    }
    
    private func timerActivation(active: Bool) {
        DispatchQueue.main.async {
            if active {
                self.runTimer()
            } else {
                self.timer.invalidate()
            }
        }
        
    }
    
    @objc fileprivate func triggerRefreshData() {
        print("second : \(second)")
        
        second += 1
        
        if second % 10 == 0 {
            self.resetTimer()
            viewModel.getStatesData(openSkyNetworkRequestStruct: mapView.getCurrentVisibleRectSkyNetworkRequestStruct())
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.timerActivation(active: false)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resetTimer()
        self.timerActivation(active: true)
    }
    
}

// MARK: - MapViewProtocols
extension MapViewController: MapViewProtocols {
    func returnLatLongData(openSkyNetworkRequestStruct: OpenSkyNetworkRequestStruct) {
        viewModel.getStatesData(openSkyNetworkRequestStruct: openSkyNetworkRequestStruct)
    }
    
    
}

// MARK: - SlideMenuProtocols
extension MapViewController: SlideMenuProtocols {
    func returnSelectedCountry(country: String) {
        print("country: \(country)")
        guard let filteredData = viewModel.returnFilteredStateData(selectedCountry: country) else { return }
        self.resetTimer()
        self.timerActivation(active: true)
        SlideMenuLoader.shared.animateSlideMenu(active: false)
        mapView.addAnnotations(data: filteredData)
    }
    
    
}

// MARK: - Selector
fileprivate extension Selector {
    static let triggerRefreshData = #selector(MapViewController.triggerRefreshData)
}


