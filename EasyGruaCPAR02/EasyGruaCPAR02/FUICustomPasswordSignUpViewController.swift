//
//  FUICustomPasswordSignUpViewController.swift
//  EasyGruaCPAR02
//
//  Created by Gabriel Quispe Delgadillo on 26/4/18.
//  Copyright © 2018 Cielabs. All rights reserved.
//

import UIKit
import FirebaseAuthUI

class FUICustomPasswordSignUpViewController: FUIPasswordSignUpViewController, UITextFieldDelegate {
    var headerShape: HeaderShape!
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    
    var descriptionDisclaimerLabel: UILabel!
    var textFieldUserName: ACFloatingTextfield!
    var textFieldUserEmail: ACFloatingTextfield!
    var textFieldUserPassword: ACFloatingTextfield!
    var registerButton: StyledButton!
    var changeEmailButton: StyledButtonAlternative!
    var eyePasswordButton: UIButton!
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
        
        let aSelector : Selector = #selector(FUICustomPasswordSignUpViewController.dismissKeyboard)
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
        
        titleLabel = {
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.text = getLocalizableString(key: "CPSUController.title")
            titleLabel.font = UIFont.boldSystemFont(ofSize: 28.0)
            titleLabel.sizeToFit()
            titleLabel.textColor = .white
            
            return titleLabel
        }()
        
        descriptionLabel = {
            let descriptionLabel = UILabel()
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.text = getLocalizableString(key: "CPSUController.description")
            descriptionLabel.font = UIFont.systemFont(ofSize: 16.0)
            descriptionLabel.textColor = UIColor.darkGray
            
            return descriptionLabel
        }()
        
        //MARK : Setup TextField
        //
        textFieldUserName = {
            let textFieldUserName = ACFloatingTextfield()
            
            textFieldUserName.delegate = self
            textFieldUserName.text = ""
            textFieldUserName.placeholder = getLocalizableString(key: "CPSUController.name")
            textFieldUserName.font = UIFont(name: "Platform-Regular", size: 30)
            textFieldUserName.lineColor = UIColor.SanCristobalGreen
            textFieldUserName.selectedLineColor = UIColor.SanCristobalDarkGreen
            textFieldUserName.selectedPlaceHolderColor = UIColor.SanCristobalGreen
            textFieldUserName.errorText = ""
            textFieldUserName.translatesAutoresizingMaskIntoConstraints = false
            textFieldUserName.keyboardType = UIKeyboardType.alphabet
            
            return textFieldUserName
        }()
        
        textFieldUserEmail = {
            let textFieldUserEmail = ACFloatingTextfield()
            
            textFieldUserEmail.delegate = self
            
            textFieldUserEmail.placeholder = getLocalizableString(key: "CPSUController.email-placeholder")
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
        
        textFieldUserPassword = {
            let textFieldUserPassword = ACFloatingTextfield()
            
            textFieldUserPassword.delegate = self
            textFieldUserPassword.text = ""
            textFieldUserPassword.placeholder = getLocalizableString(key: "CPSUController.password-placeholder")
            textFieldUserPassword.font = UIFont(name: "Platform-Regular", size: 30)
            textFieldUserPassword.textAlignment = .left
            textFieldUserPassword.lineColor = UIColor.SanCristobalGreen
            textFieldUserPassword.selectedLineColor = UIColor.SanCristobalDarkGreen
            textFieldUserPassword.selectedPlaceHolderColor = UIColor.SanCristobalGreen
            textFieldUserPassword.translatesAutoresizingMaskIntoConstraints = false
            textFieldUserPassword.keyboardType = UIKeyboardType.default
            textFieldUserPassword.isSecureTextEntry = true
            
            return textFieldUserPassword
        }()
        
        registerButton = {
            let registerButton = StyledButton()
            
            registerButton.setTitle(getLocalizableString(key: "CPSUController.register"), for: .normal)
            registerButton.addTarget(self, action: #selector(registerClicked), for: .touchUpInside)
            return registerButton
        }()
        
        changeEmailButton = {
            let changeEmailButton = StyledButtonAlternative()
            
            changeEmailButton.setTitle(getLocalizableString(key: "CPSUController.change-email"), for: .normal)
            changeEmailButton.addTarget(self, action: #selector(changeEmailButtonClicked), for: .touchUpInside)
            return changeEmailButton
        }()
        
        descriptionDisclaimerLabel = {
            let descriptionDisclaimerLabel = UILabel()
            descriptionDisclaimerLabel.text = getLocalizableString(key: "CPSUController.terms-cond-disclaimer")
            //descriptionDisclaimerLabel.font = UIFont(name: "Platform-Regular", size: 4)
            descriptionDisclaimerLabel.font = UIFont.systemFont(ofSize: 12.0)
            descriptionDisclaimerLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionDisclaimerLabel.numberOfLines = 0
            return descriptionDisclaimerLabel
        }()
        
        eyePasswordButton = {
            let eyesPasswordButton = UIButton()
            eyesPasswordButton.setImage(UIImage(named: "eyesClosed"), for: .normal)
            
            eyesPasswordButton.addTarget(self, action: #selector(showHideAction), for: .touchUpInside)
            eyesPasswordButton.translatesAutoresizingMaskIntoConstraints = false
            
            return eyesPasswordButton
        }()
        
        loginLogoImg = {
            let loginLogoImg = LoginLogoImageView()
            return loginLogoImg
        }()
        
        self.view.addSubview(headerShape)
        headerShape.addSubview(loginLogoImg)
        headerShape.addSubview(titleLabel)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(textFieldUserName)
        self.view.addSubview(textFieldUserEmail)
        self.view.addSubview(textFieldUserPassword)
        self.view.addSubview(registerButton)
        self.view.addSubview(changeEmailButton)
        self.view.addSubview(descriptionDisclaimerLabel)
        self.view.addSubview(eyePasswordButton)
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": textFieldUserName]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": textFieldUserEmail]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]-8-[v1(25)]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": textFieldUserPassword, "v1": eyePasswordButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": registerButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": changeEmailButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": descriptionDisclaimerLabel]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": headerShape]))
        headerShape.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-24-[v0(48)]-12-[v1]-30-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": loginLogoImg, "v1": titleLabel]))
        headerShape.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[v0]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["superview": headerShape, "v0": loginLogoImg]))
        headerShape.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[v0]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["superview": headerShape, "v0": titleLabel]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[v0]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["superview": view, "v0": descriptionLabel]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-36-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": textFieldUserName, "v1": eyePasswordButton]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0(160)]-24-[v3(52)]-16-[v4(52)]-16-[v5(52)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": headerShape, "v1": titleLabel, "v3": textFieldUserEmail, "v4": textFieldUserName, "v5": textFieldUserPassword]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v4(46)]-8-[v5(46)]-32-[v6]-12-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v4": registerButton, "v5": changeEmailButton, "v6": descriptionDisclaimerLabel, "v7": titleLabel, "v8": descriptionLabel]))
    }
    
    @objc func dismissKeyboard(){
        if textFieldUserName.isFirstResponder {
            _ = textFieldUserName.resignFirstResponder()
        } else if textFieldUserEmail.isFirstResponder {
            _ = textFieldUserEmail.resignFirstResponder()
        } else if textFieldUserPassword.isFirstResponder {
            _ = textFieldUserPassword.resignFirstResponder()
        }
    }
    
    @objc func changeEmailButtonClicked() {
        self.onBack()
    }
    
    @objc func registerClicked() {
        onNext()
    }
    
    func onNext() {
        if let email = textFieldUserEmail.text,
            let password = textFieldUserPassword.text,
            let username = textFieldUserName.text {
            self.signUp(withEmail: email, andPassword: password, andUsername: username)
        }
    }
    
    func onCancel(_ sender: AnyObject) {
        self.cancelAuthorization()
    }
    
    func onBack(_ sender: AnyObject) {
        self.onBack()
    }
    
    @objc func showHideAction() {
        
        if textFieldUserPassword.isSecureTextEntry{
            textFieldUserPassword.isSecureTextEntry = false
            eyePasswordButton.setImage(UIImage(named: "eyesOpened"), for: .normal)
        }else{
            textFieldUserPassword.isSecureTextEntry = true;
            eyePasswordButton.setImage(UIImage(named: "eyesClosed"), for: .normal)
        }
    }
    
    // MARK: - UITextFieldDelegate methods
    func updateTextFieldValue(_ sender: AnyObject?) {
        if let email = textFieldUserEmail.text,
            let password = textFieldUserPassword.text,
            let username = textFieldUserName.text {
            
            //nextButton.isEnabled = !email.isEmpty && !password.isEmpty && !username.isEmpty
            self.didChangeEmail(email, orPassword: password, orUserName: username)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldUserEmail {
            _ = textFieldUserName.becomeFirstResponder()
        } else if textField == textFieldUserName {
            _ = textFieldUserPassword.becomeFirstResponder()
        } else if textField == textFieldUserPassword {
            self.onNext()
        }
        
        return false
    }
    
}

