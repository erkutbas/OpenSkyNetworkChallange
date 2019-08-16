//
//  PermissionViewController.swift
//  iOS_OpenSky_BiTaksi_Challange
//
//  Created by Erkut Baş on 5/31/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class PermissionViewController: UIViewController {
    
    lazy var imageView: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = false
        temp.contentMode = .scaleAspectFill
        temp.image = UIImage(named: "background.png")
        return temp
    }()
    
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
    
    lazy var centerView: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.clipsToBounds = true
        temp.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        temp.layer.cornerRadius = 15
        return temp
    }()
    
    lazy var centerViewTopImage: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.clipsToBounds = true
        temp.isUserInteractionEnabled = false
        temp.image = UIImage(named: "wing.jpg")
        temp.contentMode = .scaleAspectFill
        return temp
    }()
    
    lazy var locationViewContainer: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = false
        temp.layer.cornerRadius = 50
        temp.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return temp
    }()
    
    lazy var locationImageContainer: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.layer.cornerRadius = 47
        temp.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        temp.layer.shadowOffset = CGSize(width: 0, height: 5)
        temp.layer.shadowOpacity = 0.8;
        temp.layer.shadowRadius = 5;
        return temp
    }()
    
    lazy var locationImageView: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = false
        temp.clipsToBounds = true
        temp.image = UIImage(named: "location.jpg")
        temp.contentMode = .scaleAspectFill
        temp.layer.cornerRadius = 47
        return temp
    }()
    
    lazy var mainStackView: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [stackViewForUserInfo, stackViewForProcessButtons])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.spacing = 20
        temp.alignment = .fill
        temp.axis = .vertical
        temp.distribution = .fill
        
        
        return temp
    }()
    
    lazy var stackViewForUserInfo: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [mainSubject, detailedInformation])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.spacing = 12
        temp.alignment = .fill
        temp.axis = .vertical
        temp.distribution = .fillProportionally
        
        return temp
    }()
    
    let mainSubject: UILabel = {
        let label = UILabel()
        //label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.contentMode = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalizedConstants.PermissionPrompts.mainSubject
        //label.font = UIFont(name: "Avenier-Medium", size: 48)
        label.font = UIFont(name: "Avenir-Medium", size: 24)
        label.textColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.262745098, alpha: 1)
        
        return label
    }()
    
    let detailedInformation: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalizedConstants.PermissionPrompts.detailedInformation
        label.font = UIFont(name: "Avenir-Light", size: 15)
        label.textColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.262745098, alpha: 1)
        
        return label
    }()
    
    lazy var stackViewForProcessButtons: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [locationPermissionButton])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        //temp.spacing = 10
        temp.alignment = .fill
        temp.axis = .vertical
        temp.distribution = .fillProportionally
        
        return temp
    }()
    
    lazy var locationPermissionButton: PermissionButtonView = {
        let temp = PermissionManager.shared.createPermissionButtonView(permissionType: .location)
        //temp.isUserInteractionEnabled = false
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector.pressedLocationButton)
        tapGesture.delegate = self
        temp.addGestureRecognizer(tapGesture)
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        prepareViewControllerSettings()
        
        //        let tap = UITapGestureRecognizer(target: self, action: #selector(PermissionViewController.koko(_:)))
        //        tap.delegate = self
        //        self.view.addGestureRecognizer(tap)
    }
    
}

// MARK: - major functions
extension PermissionViewController {
    
    fileprivate func changeBackgroundcolor() {
        //self.view.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.262745098, alpha: 1)
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        print("do do")
    }
    
    fileprivate func addViews() {
        self.view.addSubview(imageView)
        self.view.addSubview(centerViewContainer)
        self.centerViewContainer.addSubview(centerView)
        self.centerView.addSubview(centerViewTopImage)
        self.centerView.addSubview(locationViewContainer)
        self.locationViewContainer.addSubview(locationImageContainer)
        self.locationImageContainer.addSubview(locationImageView)
        self.centerView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            centerViewContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            centerViewContainer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            centerViewContainer.heightAnchor.constraint(equalToConstant: 430),
            centerViewContainer.widthAnchor.constraint(equalToConstant: 300),
            
            centerView.leadingAnchor.constraint(equalTo: self.centerViewContainer.leadingAnchor),
            centerView.trailingAnchor.constraint(equalTo: self.centerViewContainer.trailingAnchor),
            centerView.topAnchor.constraint(equalTo: self.centerViewContainer.topAnchor),
            centerView.bottomAnchor.constraint(equalTo: self.centerViewContainer.bottomAnchor),
            
            centerViewTopImage.leadingAnchor.constraint(equalTo: self.centerView.leadingAnchor),
            centerViewTopImage.trailingAnchor.constraint(equalTo: self.centerView.trailingAnchor),
            centerViewTopImage.topAnchor.constraint(equalTo: self.centerView.topAnchor),
            centerViewTopImage.heightAnchor.constraint(equalToConstant: 150),
            
            //locationViewContainer.trailingAnchor.constraint(equalTo: self.centerView.trailingAnchor, constant: -12),
            locationViewContainer.centerXAnchor.constraint(equalTo: self.centerView.centerXAnchor),
            locationViewContainer.topAnchor.constraint(equalTo: self.centerView.topAnchor, constant: 110),
            locationViewContainer.heightAnchor.constraint(equalToConstant: 100),
            locationViewContainer.widthAnchor.constraint(equalToConstant: 100),
            
            locationImageContainer.centerXAnchor.constraint(equalTo: self.locationViewContainer.centerXAnchor),
            locationImageContainer.centerYAnchor.constraint(equalTo: self.locationViewContainer.centerYAnchor),
            locationImageContainer.heightAnchor.constraint(equalToConstant: 94),
            locationImageContainer.widthAnchor.constraint(equalToConstant: 94),
            
            locationImageView.centerXAnchor.constraint(equalTo: self.locationImageContainer.centerXAnchor),
            locationImageView.centerYAnchor.constraint(equalTo: self.locationImageContainer.centerYAnchor),
            locationImageView.heightAnchor.constraint(equalToConstant: 94),
            locationImageView.widthAnchor.constraint(equalToConstant: 94),
            
            mainStackView.topAnchor.constraint(equalTo: self.locationViewContainer.bottomAnchor, constant: 10),
            mainStackView.centerXAnchor.constraint(equalTo: self.centerView.centerXAnchor),
            mainStackView.widthAnchor.constraint(equalToConstant: 260),
            mainStackView.heightAnchor.constraint(equalToConstant: 175),
            
            ])
        
    }
    
    private func prepareViewControllerSettings() {
        changeBackgroundcolor()
        addViews()
        
    }
    
    private func startAnimationCommon(inputObject: UIView) {
        
        inputObject.transform = CGAffineTransform(scaleX: 0.95, y: 0.95) // buton view kucultulur
        
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.50),  // yay sonme orani, arttikca yanip sonme artar
            initialSpringVelocity: CGFloat(6.0),    // yay hizi, arttikca hizlanir
            options: UIView.AnimationOptions.allowUserInteraction,
            animations: {
                
                inputObject.transform = CGAffineTransform.identity
                
                
        })
        inputObject.layoutIfNeeded()
    }
    
}

// MARK: - UIGestureRecognizerDelegate
extension PermissionViewController: UIGestureRecognizerDelegate {
    
    @objc fileprivate func pressLocatinButtonView(_ sender: UITapGestureRecognizer) {
        print("\(#function) pressed")
        startAnimationCommon(inputObject: locationPermissionButton)
        
        PermissionManager.shared.requestPermission(permissionType: .location, permissionResult: locationPermissionButton.getPermissionResult())
        
        PermissionManager.shared.completionHandlerForLocationAuthorizationDidChange = { (updatedPermissionButtonProperty) -> Void in
            
            DispatchQueue.main.async {
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.locationPermissionButton.updateButtonView(permissionButtonProperty: updatedPermissionButtonProperty)
                }, completion: { (finish) in
                    if PermissionManager.shared.checkRequiredPermissionsExist() {
                        self.modalTransitionStyle = .crossDissolve
                        self.dismiss(animated: true, completion: nil)
                    }
                })
                
            }
            
        }
        
    }
    
}

fileprivate extension Selector {
    static let pressedLocationButton = #selector(PermissionViewController.pressLocatinButtonView)
}
