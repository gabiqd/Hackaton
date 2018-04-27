//
//  FUICustomEmailEntryViewController.swift
//  EasyGruaCPAR02
//
//  Created by Gabriel Quispe Delgadillo on 26/4/18.
//  Copyright © 2018 Cielabs. All rights reserved.
//

import UIKit
import FirebaseAuthUI

class FUICustomEmailEntryViewController: FUIEmailEntryViewController, UITextFieldDelegate {
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    
    var headerShape: HeaderShape!
    
    var textFieldUserEmail: ACFloatingTextfield!
    var nextStyledButton: StyledButton!
    var cancelStyledButton: StyledButtonAlternative!
    var loginLogoImg: LoginLogoImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = .white
        
        let aSelector : Selector = #selector(FUICustomEmailEntryViewController.dismissKeyboard)
        let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        
        initViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
        //update state of all UI elements (e g disable 'Next' buttons)
        self.updateEmailValue(textFieldUserEmail)
    }
    
    func initViews() {
        headerShape = {
            let headerShape = HeaderShape()
            headerShape.translatesAutoresizingMaskIntoConstraints = false
            return headerShape
        }()
        
        titleLabel = {
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.sizeToFit()
            titleLabel.text = getLocalizableString(key: "CEEController.title")
            titleLabel.font = UIFont.boldSystemFont(ofSize: 28.0)
            titleLabel.textColor = .white
            
            return titleLabel
        }()
        
        descriptionLabel = {
            let descriptionLabel = UILabel()
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.text = getLocalizableString(key: "CEEController.description")
            descriptionLabel.font = UIFont.systemFont(ofSize: 16.0)
            descriptionLabel.textColor = UIColor.darkGray
            
            return descriptionLabel
        }()
        
        textFieldUserEmail = {
            let textFieldUserEmail = ACFloatingTextfield()
            
            textFieldUserEmail.delegate = self
            textFieldUserEmail.text = ""
            textFieldUserEmail.placeholder = getLocalizableString(key: "CEEController.email-placeholder")
            textFieldUserEmail.font = UIFont(name: "Platform-Regular", size: 30)
            textFieldUserEmail.lineColor = UIColor.SanCristobalGreen
            textFieldUserEmail.selectedLineColor = UIColor.SanCristobalDarkGreen
            textFieldUserEmail.selectedPlaceHolderColor = UIColor.SanCristobalGreen
            textFieldUserEmail.errorText = ""
            textFieldUserEmail.translatesAutoresizingMaskIntoConstraints = false
            textFieldUserEmail.keyboardType = UIKeyboardType.emailAddress
            
            return textFieldUserEmail
        }()
        
        nextStyledButton = {
            let nextStyledButton = StyledButton()
            
            nextStyledButton.setTitle(getLocalizableString(key: "CEEController.next"), for: .normal)
            nextStyledButton.addTarget(self, action: #selector(nextStyledButtonClicked), for: .touchUpInside)
            return nextStyledButton
        }()
        
        cancelStyledButton = {
            let cancelStyledButton = StyledButtonAlternative()
            
            cancelStyledButton.setTitle(getLocalizableString(key: "CEEController.back"), for: .normal)
            cancelStyledButton.addTarget(self, action: #selector(backStyledButtonClicked), for: .touchUpInside)
            return cancelStyledButton
        }()
        
        loginLogoImg = {
            let loginLogoImg = LoginLogoImageView()
            return loginLogoImg
        }()
        
        self.view.addSubview(headerShape)
        headerShape.addSubview(loginLogoImg)
        headerShape.addSubview(titleLabel)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(textFieldUserEmail)
        self.view.addSubview(nextStyledButton)
        self.view.addSubview(cancelStyledButton)
        
        //self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[v0]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["superview": view, "v0": loginLogoImg]))
        //self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[v0]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["superview": view, "v0": titleLabel]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[v0]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["superview": view, "v0": descriptionLabel]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": headerShape]))
        headerShape.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-24-[v0(48)]-12-[v1]-30-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": loginLogoImg, "v1": titleLabel]))
        headerShape.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[v0]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["superview": headerShape, "v0": loginLogoImg]))
        headerShape.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[v0]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["superview": headerShape, "v0": titleLabel]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": textFieldUserEmail]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nextStyledButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": cancelStyledButton]))
        
        
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0(160)]-24-[v2]-16-[v3(52)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": headerShape, "v1": titleLabel, "v2": descriptionLabel, "v3": textFieldUserEmail]))
        //self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-56-[v0(100)]-40-[v1]-30-[v2]-16-[v3(52)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": headerShape, "v1": titleLabel, "v2": descriptionLabel, "v3": textFieldUserEmail]))
        
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v4(46)]-12-[v5(46)]-44-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v3": textFieldUserEmail, "v4": nextStyledButton, "v5": cancelStyledButton]))
    }
    
    @objc func dismissKeyboard(){
        if textFieldUserEmail.isFirstResponder {
            _ = textFieldUserEmail.resignFirstResponder()
        }
    }
    
    @objc func backStyledButtonClicked() {
        self.onBack()
    }
    
    @objc func nextStyledButtonClicked() {
        
        if let email = textFieldUserEmail.text {
            if textFieldUserEmail.isFirstResponder {
                _ = textFieldUserEmail.resignFirstResponder()
            }
            self.onNext(email)
        }
        //self.present(MainTabBarViewController(), animated: true, completion: nil)
    }
    
    func updateEmailValue(_ sender: UITextField) {
        if textFieldUserEmail == sender, let email = textFieldUserEmail.text {
            //nextStyledButton.isEnabled = !email.isEmpty
            self.didChangeEmail(email)
        }
    }
    
    // MARK: - UITextFieldDelegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldUserEmail, let email = textField.text {
            self.onNext(email)
        }
        
        return false
    }
}

