//
//  FUICustomAuthPickerViewController.swift
//  EasyGruaCPAR02
//
//  Created by Gabriel Quispe Delgadillo on 26/4/18.
//  Copyright © 2018 Cielabs. All rights reserved.
//

import UIKit
import FirebaseAuthUI

@objc(FUICustomAuthPickerViewController)

class FUICustomAuthPickerViewController: FUIAuthPickerViewController {
    
    var loginLogoImg: LoginLogoImageView!
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var separatorLine: Line!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.SanCristobalGreen
        
        initViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func initViews() {
        
        loginLogoImg = {
            let loginLogoImg = LoginLogoImageView()
            return loginLogoImg
        }()
        
        
        titleLabel = {
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.sizeToFit()
            titleLabel.text = getLocalizableString(key: "CAController.title")
            titleLabel.font = UIFont.boldSystemFont(ofSize: 32.0)
            titleLabel.textColor = .white
            
            return titleLabel
        }()
        
        descriptionLabel = {
            let descriptionLabel = UILabel()
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.sizeToFit()
            descriptionLabel.text = getLocalizableString(key: "CAController.description")
            descriptionLabel.textAlignment = .center
            descriptionLabel.font = UIFont.systemFont(ofSize: 16.0)
            descriptionLabel.textColor = .white
            descriptionLabel.numberOfLines = 0
            
            return descriptionLabel
        }()
        
        separatorLine = {
            let separatorLine = Line()
            separatorLine.backgroundColor = UIColor.white
            separatorLine.translatesAutoresizingMaskIntoConstraints = false
            return separatorLine
        }()
        
        self.view.addSubview(loginLogoImg)
        self.view.addSubview(titleLabel)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(separatorLine)
        
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-88-[v0(56)]-56-[v1]-16-[v2(1)]-16-[v3]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": loginLogoImg, "v1": titleLabel, "v2": separatorLine, "v3": descriptionLabel]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-156-[v0]-156-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": separatorLine]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[v0]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["superview": self.view, "v0": loginLogoImg]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[v0]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["superview": self.view, "v0": titleLabel]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[v0]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["superview": self.view, "v0": descriptionLabel]))
        
    }
    
    func onClose() {
        self.cancelAuthorization()
    }
    
}
