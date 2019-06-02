//
//  Base.swift
//  iOS_OpenSky_BiTaksi_Challange
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

class CenterTemplateViewControler: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewConfigurations()
        print("KOK31")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Receive memory warning from \(String(describing: self))")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.cancelButton.setTitle(LocalizedConstants.TitlePrompts.finishPrompt, for: .normal)
        
    }
    
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
        temp.alignment = .fill
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
        label.text = LocalizedConstants.TitlePrompts.startTime
        //label.font = UIFont(name: "Avenier-Medium", size: 48)
        label.font = UIFont(name: "Avenir-Medium", size: 18)
        label.textColor = #colorLiteral(red: 0.2705882353, green: 0.3098039216, blue: 0.3882352941, alpha: 1)
        
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
        label.text = "00:00"
        label.font = UIFont(name: "Avenir-Heavy", size: 30)
        label.textColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.262745098, alpha: 1)
        
        return label
    }()
    
    lazy var rightStackView: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [rightMainSubject, rightDetailedInformation])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        //temp.spacing = 12
        temp.alignment = .fill
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
        label.text = LocalizedConstants.TitlePrompts.endTime
        //label.font = UIFont(name: "Avenier-Medium", size: 48)
        label.font = UIFont(name: "Avenir-Medium", size: 18)
        label.textColor = #colorLiteral(red: 0.2705882353, green: 0.3098039216, blue: 0.3882352941, alpha: 1)
        
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
        label.text = "00:00"
        label.font = UIFont(name: "Avenir-Heavy", size: 30)
        label.textColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.262745098, alpha: 1)
        
        return label
    }()
    
    lazy var middleStackView: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [middleMainSubject, middleDetailedInformation])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        //temp.spacing = 12
        temp.alignment = .fill
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
        label.text = LocalizedConstants.TitlePrompts.icao24Info
        //label.font = UIFont(name: "Avenier-Medium", size: 48)
        label.font = UIFont(name: "Avenir-Medium", size: 18)
        label.textColor = #colorLiteral(red: 0.2705882353, green: 0.3098039216, blue: 0.3882352941, alpha: 1)
        
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
        label.text = LocalizedConstants.TitlePrompts.icao24Info
        label.font = UIFont(name: "Avenir-Heavy", size: 30)
        label.textColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.262745098, alpha: 1)
        
        return label
    }()
    
    lazy var rangeSlider: UISlider = {
        let temp = UISlider()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.thumbTintColor = #colorLiteral(red: 0.2705882353, green: 0.3098039216, blue: 0.3882352941, alpha: 1)
        temp.minimumTrackTintColor = #colorLiteral(red: 0.4066316783, green: 0.3673116565, blue: 1, alpha: 1)
        temp.minimumValue = 0
        temp.maximumValue = 60
        temp.setValue(0, animated: true)
        //temp.addTarget(self, action: .changeSliderValue, for: .valueChanged)
        return temp
    }()
    
    let sliderTitle: UILabel = {
        let label = UILabel()
        //label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.contentMode = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalizedConstants.TitlePrompts.simulatorSpeed
        //label.font = UIFont(name: "Avenier-Medium", size: 48)
        label.font = UIFont(name: "Avenir-Medium", size: 14)
        label.textColor = #colorLiteral(red: 0.4705882353, green: 0.5176470588, blue: 0.6196078431, alpha: 1)
        
        return label
    }()
    
    let sliderRangeLeft: UILabel = {
        let label = UILabel()
        //label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.contentMode = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        //label.font = UIFont(name: "Avenier-Medium", size: 48)
        label.font = UIFont(name: "Avenir-Light", size: 12)
        label.textColor = #colorLiteral(red: 0.4705882353, green: 0.5176470588, blue: 0.6196078431, alpha: 1)
        
        return label
    }()
    
    let sliderRangeMiddle: UILabel = {
        let label = UILabel()
        //label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.contentMode = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "30"
        //label.font = UIFont(name: "Avenier-Medium", size: 48)
        label.font = UIFont(name: "Avenir-Light", size: 12)
        label.textColor = #colorLiteral(red: 0.4705882353, green: 0.5176470588, blue: 0.6196078431, alpha: 1)
        
        return label
    }()
    
    let sliderRangeRight: UILabel = {
        let label = UILabel()
        //label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.contentMode = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "60"
        //label.font = UIFont(name: "Avenier-Medium", size: 48)
        label.font = UIFont(name: "Avenir-Light", size: 12)
        label.textColor = #colorLiteral(red: 0.4705882353, green: 0.5176470588, blue: 0.6196078431, alpha: 1)
        
        return label
    }()
    
    lazy var operationButtonsStackView: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [cancelButton, proceedButton])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.spacing = 10
        temp.alignment = .fill
        temp.axis = .horizontal
        temp.distribution = .fillEqually
        
        return temp
    }()
    
    let cancelButton: UIButton = {
        let temp = UIButton(type: .system)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.setTitle(LocalizedConstants.TitlePrompts.cancelPrompt, for: .normal)
        temp.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        temp.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        temp.backgroundColor = #colorLiteral(red: 0.2705882353, green: 0.3098039216, blue: 0.3882352941, alpha: 1)
        temp.contentVerticalAlignment = .center
        temp.contentHorizontalAlignment = .center
        temp.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        temp.layer.shadowOffset = CGSize(width: 0, height: 5)
        temp.layer.shadowOpacity = 0.8;
        temp.layer.shadowRadius = 5;
        temp.layer.cornerRadius = 10
        //temp.addTarget(self, action: #selector(CustomPermissionView.dismisView(_:)), for: .touchUpInside)
        
        return temp
    }()
    
    let proceedButton: UIButton = {
        let temp = UIButton(type: .system)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.setTitle(LocalizedConstants.TitlePrompts.simulatePrompt, for: .normal)
        temp.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        temp.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        temp.backgroundColor = #colorLiteral(red: 0, green: 0.8138262033, blue: 0.8954362273, alpha: 1)
        temp.contentVerticalAlignment = .center
        temp.contentHorizontalAlignment = .center
        temp.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        temp.layer.shadowOffset = CGSize(width: 0, height: 5)
        temp.layer.shadowOpacity = 0.8;
        temp.layer.shadowRadius = 5;
        temp.layer.cornerRadius = 10
        //temp.addTarget(self, action: #selector(CustomPermissionView.dismisView(_:)), for: .touchUpInside)
        
        return temp
    }()

    func prepareViewConfigurations() {
        print("KOKO4")
        addViews()
        configureSliderOptions()
        configureStackViewPrompts()
        configurationOfOperationButtons()
        
    }
    
    func configureSliderOptions() {}
    func configureStackViewPrompts() {}
    func configurationOfOperationButtons() {}
    
    func addViews() {
        print("KOKO5")
        self.view.addSubview(centerViewContainer)
        self.centerViewContainer.addSubview(centerViewTopImage)
        self.centerViewTopImage.addSubview(insideImage)
        self.centerViewContainer.addSubview(middleStackView)
        self.centerViewContainer.addSubview(leftStackView)
        self.centerViewContainer.addSubview(rightStackView)
        self.centerViewContainer.addSubview(sliderTitle)
        self.centerViewContainer.addSubview(rangeSlider)
        self.centerViewContainer.addSubview(operationButtonsStackView)
        self.centerViewContainer.addSubview(sliderRangeRight)
        self.centerViewContainer.addSubview(sliderRangeLeft)
        self.centerViewContainer.addSubview(sliderRangeMiddle)
        
        NSLayoutConstraint.activate([
            
            centerViewContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            centerViewContainer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            centerViewContainer.heightAnchor.constraint(equalToConstant: 400),
            centerViewContainer.widthAnchor.constraint(equalToConstant: 300),
            
            centerViewTopImage.leadingAnchor.constraint(equalTo: self.centerViewContainer.leadingAnchor),
            centerViewTopImage.trailingAnchor.constraint(equalTo: self.centerViewContainer.trailingAnchor),
            centerViewTopImage.topAnchor.constraint(equalTo: self.centerViewContainer.topAnchor),
            centerViewTopImage.heightAnchor.constraint(equalToConstant: 200),
            
            insideImage.centerXAnchor.constraint(equalTo: self.centerViewTopImage.centerXAnchor),
            insideImage.bottomAnchor.constraint(equalTo: self.centerViewTopImage.bottomAnchor, constant: -50),
            
            middleStackView.centerXAnchor.constraint(equalTo: self.centerViewContainer.centerXAnchor),
            middleStackView.bottomAnchor.constraint(equalTo: self.centerViewTopImage.bottomAnchor, constant: 10),
            
            leftStackView.leadingAnchor.constraint(equalTo: self.centerViewContainer.leadingAnchor, constant: 10),
            leftStackView.topAnchor.constraint(equalTo: self.centerViewTopImage.bottomAnchor, constant: 10),
            
            rightStackView.trailingAnchor.constraint(equalTo: self.centerViewContainer.trailingAnchor, constant: -10),
            rightStackView.topAnchor.constraint(equalTo: self.centerViewTopImage.bottomAnchor, constant: 10),
            
            operationButtonsStackView.leadingAnchor.constraint(equalTo: self.centerViewContainer.leadingAnchor, constant: 10),
            operationButtonsStackView.trailingAnchor.constraint(equalTo: self.centerViewContainer.trailingAnchor, constant: -10),
            operationButtonsStackView.bottomAnchor.constraint(equalTo: self.centerViewContainer.bottomAnchor, constant: -15),
            
            rangeSlider.leadingAnchor.constraint(equalTo: self.centerViewContainer.leadingAnchor, constant: 10),
            rangeSlider.trailingAnchor.constraint(equalTo: self.centerViewContainer.trailingAnchor, constant: -10),
            rangeSlider.bottomAnchor.constraint(equalTo: self.operationButtonsStackView.topAnchor, constant: -10),
            
            sliderTitle.centerXAnchor.constraint(equalTo: self.centerViewContainer.centerXAnchor),
            sliderTitle.bottomAnchor.constraint(equalTo: self.rangeSlider.topAnchor, constant: -10),
            
            sliderRangeMiddle.centerXAnchor.constraint(equalTo: self.centerViewContainer.centerXAnchor),
            sliderRangeMiddle.bottomAnchor.constraint(equalTo: self.rangeSlider.topAnchor, constant: 3),
            
            sliderRangeLeft.leadingAnchor.constraint(equalTo: self.centerViewContainer.leadingAnchor, constant: 20),
            sliderRangeLeft.bottomAnchor.constraint(equalTo: self.rangeSlider.topAnchor, constant: 3),
            
            sliderRangeRight.trailingAnchor.constraint(equalTo: self.centerViewContainer.trailingAnchor, constant: -20),
            sliderRangeRight.bottomAnchor.constraint(equalTo: self.rangeSlider.topAnchor, constant: 3),
            
            ])
        
    }
    
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
    
    func prepareViewConfigurations() {
        addView()
    }
    
    func configureMapViewSettings() {}
    
    func addView() {
        self.view.addSubview(mapView)
        self.view.addSubview(refreshingView)
        
        NSLayoutConstraint.activate([
            
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            refreshingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            refreshingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            refreshingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            refreshingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            ])
        
    }
    
    
}
