//
//  Base.swift
//  OpenSkyNetworkChallange
//
//  Created by Erkut Baş on 5/31/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareViewConfigurations()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareViewConfigurations() {
        
    }
    
}

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewConfigurations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Receive memory warning from \(String(describing: self))")
    }
    
    func prepareViewConfigurations() {}
}

class CenterTemplateViewControler: BaseViewController {
    
    lazy var centerViewContainer: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        temp.layer.cornerRadius = 15
        temp.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        temp.layer.shadowOffset = .zero
        temp.layer.shadowOpacity = 1;
        temp.layer.shadowRadius = 5;
        return temp
    }()
    
    lazy var centerViewTopImage: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.clipsToBounds = true
        temp.isUserInteractionEnabled = false
        temp.image = UIImage(named: "dots.png")
        temp.contentMode = .scaleAspectFill
        return temp
    }()
    
    lazy var insideImage: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.clipsToBounds = true
        temp.isUserInteractionEnabled = false
        temp.image = UIImage(named: "illustration.png")
        temp.contentMode = .scaleAspectFill
        return temp
    }()
    
    lazy var leftStackView: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [leftMainSubject, leftDetailedInformation])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        //temp.spacing = 12
        temp.alignment = .center
        temp.axis = .vertical
        temp.distribution = .fillProportionally
        
        return temp
    }()
    
    let leftMainSubject: UILabel = {
        let label = UILabel()
        //label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.contentMode = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalizedConstants.PermissionPrompts.mainSubject
        //label.font = UIFont(name: "Avenier-Medium", size: 48)
        label.font = UIFont(name: "Avenir-Medium", size: 16)
        label.textColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.262745098, alpha: 1)
        
        return label
    }()
    
    let leftDetailedInformation: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalizedConstants.PermissionPrompts.detailedInformation
        label.font = UIFont(name: "Avenir-Heavy", size: 24)
        label.textColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.262745098, alpha: 1)
        
        return label
    }()
    
    lazy var rightStackView: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [rightMainSubject, rightDetailedInformation])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        //temp.spacing = 12
        temp.alignment = .center
        temp.axis = .vertical
        temp.distribution = .fillProportionally
        
        return temp
    }()
    
    let rightMainSubject: UILabel = {
        let label = UILabel()
        //label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.contentMode = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalizedConstants.PermissionPrompts.mainSubject
        //label.font = UIFont(name: "Avenier-Medium", size: 48)
        label.font = UIFont(name: "Avenir-Medium", size: 16)
        label.textColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.262745098, alpha: 1)
        
        return label
    }()
    
    let rightDetailedInformation: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalizedConstants.PermissionPrompts.detailedInformation
        label.font = UIFont(name: "Avenir-Heavy", size: 24)
        label.textColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.262745098, alpha: 1)
        
        return label
    }()
    
    lazy var middleStackView: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [middleMainSubject, middleDetailedInformation])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        //temp.spacing = 12
        temp.alignment = .center
        temp.axis = .vertical
        temp.distribution = .fillProportionally
        
        return temp
    }()
    
    let middleMainSubject: UILabel = {
        let label = UILabel()
        //label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.contentMode = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalizedConstants.PermissionPrompts.mainSubject
        //label.font = UIFont(name: "Avenier-Medium", size: 48)
        label.font = UIFont(name: "Avenir-Medium", size: 16)
        label.textColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.262745098, alpha: 1)
        
        return label
    }()
    
    let middleDetailedInformation: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalizedConstants.PermissionPrompts.detailedInformation
        label.font = UIFont(name: "Avenir-Heavy", size: 24)
        label.textColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.262745098, alpha: 1)
        
        return label
    }()
    
}

class BaseMapViewController: UIViewController {
    
    lazy var mapView: MKMapView = {
        let temp = MKMapView(frame: .zero)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.showsScale = true
        temp.showsCompass = true
        temp.showsUserLocation = true
        //temp.setUserTrackingMode(.followWithHeading, animated: true)
//        temp.delegate = self
//
//        temp.register(PlaneAnnotationView.self, forAnnotationViewWithReuseIdentifier: PlaneAnnotationView.identifier)
        
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
        prepareViewConfigurations()
        configureMapViewSettings()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Receive memory warning from \(String(describing: self))")
    }
    
    func prepareViewConfigurations() {}
    func configureMapViewSettings() {}
    
}
