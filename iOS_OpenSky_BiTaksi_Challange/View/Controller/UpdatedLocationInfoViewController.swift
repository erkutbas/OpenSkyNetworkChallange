//
//  UpdatedLocationInfoViewController.swift
//  iOS_OpenSky_BiTaksi_Challange
//
//  Created by Erkut Baş on 6/2/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class UpdatedLocationInfoViewController: CenterTemplateViewControler {
    
    convenience init(pathStructData: PathStruct){
        self.init()
        print("pathStructData : \(pathStructData)")
        for item in pathStructData.pathData! {
            print("item.latitude : \(item.latitude)")
            print("item.latitude : \(item.latitude)")
        }
    }
    
    override func prepareViewConfigurations() {
        print("KOKO1")
        super.prepareViewConfigurations()
        viewSettings()
        
    }
    
    override func configureSliderOptions() {
        print("KOKO2")
    }
    
    override func configureStackViewPrompts() {
        
    }
    
    override func configurationOfOperationButtons() {
        
    }
    
}

// MARK: - major functions
extension UpdatedLocationInfoViewController {
    
    private func viewSettings() {
        self.view.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.262745098, alpha: 1).withAlphaComponent(0.4)
    }
    
    
}

