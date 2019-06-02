//
//  UpdatedLocationInfoViewController.swift
//  iOS_OpenSky_BiTaksi_Challange
//
//  Created by Erkut Baş on 6/2/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class UpdatedLocationInfoViewController: CenterTemplateViewControler {

    private var pathSructData: PathStruct!
    var completionHandlerDismiss: ((Bool) -> (Void))?
    
    convenience init(pathStructData: PathStruct){
        self.init()
        print("pathStructData : \(pathStructData)")
        for item in pathStructData.pathData! {
            print("item.latitude : \(item.latitude)")
            print("item.latitude : \(item.latitude)")
        }
        
        setDataToViews(pathData: pathStructData)
        
    }
    
    override func prepareViewConfigurations() {
        print("KOKO1")
        super.prepareViewConfigurations()
        viewSettings()
        
    }
    
    override func configureSliderOptions() {
        super.configureSliderOptions()
        setSliderOptions()
        
    }
    
    override func configureStackViewPrompts() {
        super.configureStackViewPrompts()
    }
    
    override func configurationOfOperationButtons() {
        super.configurationOfOperationButtons()
        
        setButtonOptions()
        
    }
    
}

// MARK: - major functions
extension UpdatedLocationInfoViewController {
    
    private func viewSettings() {
        self.view.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.262745098, alpha: 1).withAlphaComponent(0.4)
    }
    
    private func setSliderOptions() {
        rangeSlider.addTarget(self, action: Selector.changeSliderValue, for: .valueChanged)
    }
    
    private func setButtonOptions() {
        cancelButton.addTarget(self, action: Selector.dismissViewController, for: .touchUpInside)
        proceedButton.addTarget(self, action: Selector.simulateTrigger, for: .touchUpInside)
    }
    
    private func setDataToViews(pathData: PathStruct) {
        
        self.pathSructData = pathData
        
        middleDetailedInformation.text = pathData.icao24
        
        guard let startTime = pathData.startTime else { return }
        
        let date = Date(timeIntervalSince1970: TimeInterval(startTime))
        let dateFormatter = DateFormatter()
//        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
//        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
//        dateFormatter.timeZone = .current
        dateFormatter.timeStyle = .short
        let localDate = dateFormatter.string(from: date)
        
        leftDetailedInformation.text = localDate
        
        print("localDate : \(localDate)")
        
        guard let endTime = pathData.endTime else { return }
        
        let date2 = Date(timeIntervalSince1970: TimeInterval(endTime))
        let dateFormatter2 = DateFormatter()
        //        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        //        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        //        dateFormatter.timeZone = .current
        dateFormatter2.timeStyle = .short
        let localDate2 = dateFormatter.string(from: date2)
        
        rightDetailedInformation.text = localDate2
        
        print("localDate2 : \(localDate2)")
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute]
        print(formatter.string(from: date, to: date2)!)
        
    }
    
    private func getRangeSliderValue() -> Int {
        
        if Int(rangeSlider.value) <= 0 {
            return 10
        } else {
            return Int(rangeSlider.value)
        }
        
    }
    
    private func returnSimulationInputs() -> SimulationInputs? {
        guard let paths = pathSructData.pathData else { return nil }
        let data = SimulationInputs(simulationSeconds: getRangeSliderValue(), paths: paths)
        return data
    }
    
    @objc fileprivate func simulateTrigger(_ sender: UIButton) {
        
        guard let simulationData = returnSimulationInputs() else { return }
        
        let simulationViewController = SimulationViewController(data: simulationData)
        self.navigationController?.pushViewController(simulationViewController, animated: true)
    }
    
    @objc fileprivate func dismissViewController(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.completionHandlerDismiss?(true)
        }
        
    }
    
    @objc fileprivate func changeSliderValue(_ sender: UISlider) {
        print("sender.value : \(sender.value)")
        let roundedStepValue = round(sender.value / 30) * 30
        sender.value = roundedStepValue
        rangeSlider.value = sender.value

        print("sender.value : \(sender.value)")
        print("rangeSlider.value : \(rangeSlider.value)")
    }
    
}

// MARK: - Selector
fileprivate extension Selector {
    static let changeSliderValue = #selector(UpdatedLocationInfoViewController.changeSliderValue)
    static let simulateTrigger = #selector(UpdatedLocationInfoViewController.simulateTrigger)
    static let dismissViewController = #selector(UpdatedLocationInfoViewController.dismissViewController)
}


