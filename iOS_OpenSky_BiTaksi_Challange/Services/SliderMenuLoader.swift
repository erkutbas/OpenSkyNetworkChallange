//
//  SliderMenuLoader.swift
//  iOS_OpenSky_BiTaksi_Challange
//
//  Created by Erkut Baş on 6/1/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import UIKit

class SlideMenuLoader: NSObject {
    
    private var slideMenu : SlideMenu!
    private var shadowMenu : UIView!
    
    public static let shared = SlideMenuLoader()
    
    func createSlider(inputView : UIView, delegate: SlideMenuProtocols) {
        
        let screen = UIScreen.main.bounds
        
        print("screen : \(screen)")
        print("UIScreen.main.bounds : \(UIScreen.main.bounds)")
        print("self.superview : \(inputView.superview)")
        
        addShadowView(inputFrame: screen, inputView: inputView)
        addSlideMenuView(inputFrame: screen, inputView: inputView)
        addGestures()
        setSlideMenuDelegation(delegate: delegate)
        
    }
    
    private func addShadowView(inputFrame : CGRect, inputView : UIView) {
        
        shadowMenu = UIView(frame: inputFrame)
        shadowMenu.backgroundColor = UIColor(white: 0, alpha: 0.5)
        shadowMenu.frame = inputFrame
        shadowMenu.alpha = 0
        
        inputView.addSubview(shadowMenu)
        
    }
    
    private func addSlideMenuView(inputFrame : CGRect, inputView : UIView) {
        
        //let width : CGFloat = Constants.StaticViewSize.ViewSize.Width.width_250
        //let width : CGFloat = inputView.frame.width - Constants.StaticViewSize.ViewSize.Width.width_100
        //let width : CGFloat = inputView.frame.width - (inputView.frame.width / 4)
        let height: CGFloat = inputView.frame.height - 100
        slideMenu = SlideMenu(frame: CGRect(x: 0, y: height, width: inputView.frame.width, height: 300))
        inputView.addSubview(slideMenu)
        
        //animateSlideMenu(active: true)
        
    }
    
    /// - Parameter active: visible or not
    func animateSlideMenu(active: Bool) {
        print("animateSlideMenu starts")
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            if active {
                self.shadowMenu.alpha = 1
                
                self.slideMenu.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 300, width: self.slideMenu.frame.width, height: self.slideMenu.frame.height)
                
            } else {
                self.shadowMenu.alpha = 0
                
                self.slideMenu.frame = CGRect(x: 0 , y: UIScreen.main.bounds.height - 100, width: self.slideMenu.frame.width, height: self.slideMenu.frame.height)
            }
            
        }, completion: nil)
        
    }
    
    func setSlideMenuDelegation(delegate : SlideMenuProtocols) {
        slideMenu.setDelegation(delegate: delegate)
    }
    
    func updateSlideMenuData(data: Array<CommonPlaceData>) {
        slideMenu.updateSlideMenuData(data: data)
    }
    
    func updateFlightCount(count: Int) {
        slideMenu.updateFlightCount(count: count)
    }
    
}

// MARK: - UIGestureRecognizerDelegate
extension SlideMenuLoader : UIGestureRecognizerDelegate {
    
    private func addGestures() {
        addGestureToShadowView()
        addSwipeGestureRecognizer()
        addTapGestureRecognizer()
    }
    
    private func addGestureToShadowView() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector.closeMenuView)
        tapGesture.delegate = self
        shadowMenu.addGestureRecognizer(tapGesture)
    }
    
    private func addTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector.openSliderMenu)
        tapGesture.delegate = self
        self.slideMenu.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func openSliderMenu(_ sender : UITapGestureRecognizer)  {
        
        animateSlideMenu(active: true)
        
    }
    
    @objc fileprivate func closeMenuView(_ sender : UITapGestureRecognizer)  {
        
        animateSlideMenu(active: false)
        
    }
    
    private func addSwipeGestureRecognizer() {
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: Selector.swipeToClose)
        swipeGesture.direction = .down
        swipeGesture.delegate = self
        self.shadowMenu.addGestureRecognizer(swipeGesture)
        
    }
    
    @objc fileprivate func swipeToClose(_ sender : UISwipeGestureRecognizer) {
        
        print("swipeToClose starts")
        
        switch sender.direction {
        case .down:
            SlideMenuLoader.shared.animateSlideMenu(active: false)
            return
        default:
            break
        }
        
    }
    
    @objc private func tapToOpen(_ sender : UITapGestureRecognizer) {
        SlideMenuLoader.shared.animateSlideMenu(active: true)
    }
    
}

// MARK: - Selector
fileprivate extension Selector {
    static let openSliderMenu = #selector(SlideMenuLoader.openSliderMenu)
    static let swipeToClose = #selector(SlideMenuLoader.swipeToClose)
    static let closeMenuView = #selector(SlideMenuLoader.closeMenuView)
}


