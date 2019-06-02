//
//  UpdatedLocationInfoViewController.swift
//  iOS_OpenSky_BiTaksi_Challange
//
//  Created by Erkut Baş on 6/2/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class UpdatedLocationInfoViewController: BaseViewController {
    
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

    convenience init(pathStructData: PathStruct){
        self.init()
    }
    
    override func prepareViewConfigurations() {
        
    }
    
    
}

// MARK: - major functions
extension UpdatedLocationInfoViewController {
    
}

