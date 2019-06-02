//
//  SlideMenu.swift
//  OpenSkyNetworkChallange
//
//  Created by Erkut Baş on 6/1/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class SlideMenu: BaseView {
    
    private var slideMenuViewModel = SlideMenuViewModel()
    
    lazy var topBadge: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.image = UIImage(named: "gradient_slider.png")
        temp.contentMode = .scaleAspectFill
        //temp.clipsToBounds = true
        return temp
    }()
    
    lazy var sliderLine: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.2588235294, blue: 0.3333333333, alpha: 1)
        temp.layer.cornerRadius = 3
        return temp
    }()
    
    lazy var countryPicker: UIPickerView = {
        let temp = UIPickerView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.backgroundColor = UIColor.clear
        temp.contentMode = .center
//        temp.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        temp.contentMode = .center
//        temp.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        temp.layer.shadowOffset = .zero
//        temp.layer.shadowOpacity = 0.5;
//        temp.layer.shadowRadius = 1;
        
        temp.dataSource = self
        temp.delegate = self

        return temp
        
    }()
    
    lazy var mainStackView: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [stackViewInformationView, stackViewFligthCount])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.spacing = 10
        temp.alignment = .fill
        temp.axis = .horizontal
        temp.distribution = .fillProportionally
        
        
        return temp
    }()

    lazy var stackViewInformationView: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [mainSubject, detailedInformation])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        //temp.spacing = 2
        temp.alignment = .fill
        temp.axis = .vertical
        temp.distribution = .fillProportionally
        
        return temp
    }()
    
    let mainSubject: UILabel = {
        let label = UILabel()
        //label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.contentMode = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalizedConstants.SlideMenuPrompts.filterOptions
        //label.font = UIFont(name: "Avenier-Medium", size: 48)
        label.font = UIFont(name: "Avenir-Medium", size: 18)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        return label
    }()
    
    let detailedInformation: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.contentMode = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalizedConstants.SlideMenuPrompts.detailedFilterOptions
        label.font = UIFont(name: "Avenir-Light", size: 12)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        return label
    }()
    
    lazy var stackViewFligthCount: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [fligthCount])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        //temp.spacing = 10
        temp.alignment = .fill
        temp.axis = .vertical
        temp.distribution = .fillProportionally
        
        return temp
    }()
    
    let fligthCount: UILabel = {
        let label = UILabel()
        //label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.contentMode = .center
        //label.lineBreakMode = .byWordWrapping
        //label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "50"
        //label.font = UIFont(name: "Avenier-Medium", size: 48)
        label.font = UIFont(name: "Avenir-Medium", size: 30)
        label.textColor = #colorLiteral(red: 0.2392156863, green: 0.2588235294, blue: 0.3333333333, alpha: 1)
        
        return label
    }()
    
    deinit {
        slideMenuViewModel.fligthCount.unbind()
        slideMenuViewModel.countryDataState.unbind()
        slideMenuViewModel.selectedCountry.unbind()
    }
    
    // delegations
    weak var delegate: SlideMenuProtocols?
    
    override func prepareViewConfigurations() {
        
        viewSettings()
        addViews()
        addListeners()
    }
    
    private func viewSettings() {
        self.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.262745098, alpha: 1)
        self.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        
    }
    
    private func addViews() {
        
        self.addSubview(topBadge)
        self.addSubview(sliderLine)
        self.addSubview(mainStackView)
        self.addSubview(countryPicker)
        //self.addSubview(stackViewInformationView)
        
        NSLayoutConstraint.activate([
            
            topBadge.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topBadge.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topBadge.topAnchor.constraint(equalTo: self.topAnchor),
            topBadge.heightAnchor.constraint(equalToConstant: 8),
            
            sliderLine.heightAnchor.constraint(equalToConstant: 4),
            sliderLine.widthAnchor.constraint(equalToConstant: 200),
            sliderLine.topAnchor.constraint(equalTo: self.topBadge.bottomAnchor, constant: 10),
            sliderLine.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            mainStackView.topAnchor.constraint(equalTo: self.sliderLine.bottomAnchor, constant: 10),
            
            countryPicker.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
//            countryPicker.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            countryPicker.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            countryPicker.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countryPicker.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countryPicker.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
        
    }
    
    private func addListeners() {
        slideMenuViewModel.fligthCount.bind { (count) in
            DispatchQueue.main.async {
                UIView.transition(with: self.fligthCount, duration: 0.3, options: UIView.AnimationOptions.curveEaseIn, animations: {
                    self.fligthCount.text = String(describing: count)
                })
            }
        }
        
        slideMenuViewModel.countryDataState.bind { (status) in
            switch status {
            case .loading:
                break
            case .populate:
                self.reloadPickerView()
            default:
                break
            }
        }
        
        slideMenuViewModel.selectedCountry.bind { (selectedCountry) in
            self.setSelectedCountryTitle(selectedCountry: selectedCountry)
        }
    }
    
    private func reloadPickerView() {
        DispatchQueue.main.async {
            self.countryPicker.reloadAllComponents()
        }
    }
    
    private func setSelectedCountryTitle(selectedCountry: String) {
        DispatchQueue.main.async {
            UIView.transition(with: self.detailedInformation, duration: 0.3, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                self.detailedInformation.text = selectedCountry
            })
        }
    }
    
    
    // outsider
    func updateSlideMenuData(data: Array<CommonPlaceData>) {
        guard let stateData = data as? Array<StateData> else { return }
        slideMenuViewModel.createCountryDataWithRawData(stateData: stateData)
        slideMenuViewModel.selectedCountry.value = LocalizedConstants.SlideMenuPrompts.detailedFilterOptions
    }
    
    func setDelegation(delegate: SlideMenuProtocols) {
        self.delegate = delegate
    }
    
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension SlideMenu: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return slideMenuViewModel.returnComponentCount()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return slideMenuViewModel.returnCountryCount()
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: slideMenuViewModel.returnCountryDataByIndex(index: row), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCountry = slideMenuViewModel.returnCountryDataByIndex(index: row)
        slideMenuViewModel.selectedCountry.value = selectedCountry
        delegate?.returnSelectedCountry(country: selectedCountry)
    }
    
}


// MARK: - to change just specified corners radius
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

