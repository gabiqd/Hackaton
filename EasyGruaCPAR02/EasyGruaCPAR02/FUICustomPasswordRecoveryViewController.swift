//
//  FUICustomPasswordRecoveryViewController.swift
//  EasyGruaCPAR02
//
//  Created by Gabriel Quispe Delgadillo on 26/4/18.
//  Copyright © 2018 Cielabs. All rights reserved.
//

import UIKit
import FirebaseAuthUI

class FUICustomPasswordRecoveryViewController: FUIPasswordRecoveryViewController, UITextFieldDelegate {
    var headerShape: HeaderShape!
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    
    var textFieldUserEmail: ACFloatingTextfield!
    var recoverButton: StyledButton!
    var backButton: StyledButtonAlternative!
    var loginLogoImg: LoginLogoImageView!
    
    var passedEmail: String?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, authUI: FUIAuth, email: String?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil, authUI: authUI, email: email)
        
        passedEmail = email
        
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let aSelector : Selector = #selector(FUICustomPasswordRecoveryViewController.dismissKeyboard)
        let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func initViews() {
        
        headerShape = {
            let headerShape = HeaderShape()
            headerShape.translatesAutoresizingMaskIntoConstraints = false
            return headerShape
        }()
        
        loginLogoImg = {
            let loginLogoImg = LoginLogoImageView()
            return loginLogoImg
        }()
        
        titleLabel = {
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.text = getLocalizableString(key: "CRPController.title")
            titleLabel.font = UIFont.boldSystemFont(ofSize: 28.0)
            titleLabel.textColor = .white
            
            return titleLabel
        }()
        
        descriptionLabel = {
            let descriptionLabel = UILabel()
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.text = getLocalizableString(key: "CRPController.description")
            descriptionLabel.font = UIFont.systemFont(ofSize: 16.0)
            descriptionLabel.textColor = UIColor.darkGray
            
            return descriptionLabel
        }()
        
        //MARK : Setup TextField
        //
        
        textFieldUserEmail = {
            let textFieldUserEmail = ACFloatingTextfield()
            
            textFieldUserEmail.delegate = self
            
            textFieldUserEmail.placeholder = getLocalizableString(key: "CRPController.email-placeholder")
            textFieldUserEmail.font = UIFont(name: "Platform-Regular", size: 30)
            textFieldUserEmail.lineColor = UIColor.SanCristobalGreen
            textFieldUserEmail.selectedLineColor = UIColor.SanCristobalDarkGreen
            textFieldUserEmail.selectedPlaceHolderColor = UIColor.SanCristobalGreen
            textFieldUserEmail.errorText = ""
            textFieldUserEmail.translatesAutoresizingMaskIntoConstraints = false
            textFieldUserEmail.keyboardType = UIKeyboardType.emailAddress
            
            textFieldUserEmail.text = passedEmail
            textFieldUserEmail.isEnabled = false
            
            return textFieldUserEmail
        }()
        
        recoverButton = {
            let recoverButton = StyledButton()
            
            recoverButton.setTitle(getLocalizableString(key: "CRPController.recover"), for: .normal)
            recoverButton.addTarget(self, action: #selector(onRecover), for: .touchUpInside)
            return recoverButton
        }()
        
        backButton = {
            let backButton = StyledButtonAlternative()
            
            backButton.setTitle(getLocalizableString(key: "CRPController.back"), for: .normal)
            backButton.addTarget(self, action: #selector(onBackClicked), for: .touchUpInside)
            return backButton
        }()
        
        self.view.addSubview(headerShape)
        headerShape.addSubview(loginLogoImg)
        headerShape.addSubview(titleLabel)
        
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(textFieldUserEmail)
        self.view.addSubview(recoverButton)
        self.view.addSubview(backButton)
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-72-[v0]-72-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": textFieldUserEmail]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": recoverButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": backButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": headerShape]))
        headerShape.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-24-[v0(48)]-12-[v1]-30-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": loginLogoImg, "v1": titleLabel]))
        headerShape.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[v0]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["superview": headerShape, "v0": loginLogoImg]))
        headerShape.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[v0]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["superview": headerShape, "v0": titleLabel]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[v0]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["superview": view, "v0": descriptionLabel]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0(160)]-24-[v6]-24-[v2(52)]-64-[v4(50)]-16-[v5(50)]-72-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": headerShape, "v2": textFieldUserEmail,"v4": recoverButton, "v5": backButton, "v6": descriptionLabel]))
    }
    
    @objc func dismissKeyboard(){
        if textFieldUserEmail.isFirstResponder {
            _ = textFieldUserEmail.resignFirstResponder()
        }
    }
    
    @objc func onBackClicked() {
        self.onBack()
    }
    
    @objc func onRecover() {
        if let email = textFieldUserEmail.text {
            self.recoverEmail(email)
        }
    }
    
    func onCancel(_ sender: AnyObject) {
        self.cancelAuthorization()
    }
    
    func updateEmailValue(_ sender: UITextField) {
        if textFieldUserEmail == sender, let email = textFieldUserEmail.text {
            recoverButton.isEnabled = !email.isEmpty
            self.didChangeEmail(email)
        }
    }
    
    // MARK: - UITextFieldDelegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldUserEmail, let email = textField.text {
            self.recoverEmail(email)
        }
        
        return false
    }
}


