//
//  FUICustomPasswordSignInViewController.swift
//  EasyGruaCPAR02
//
//  Created by Gabriel Quispe Delgadillo on 26/4/18.
//  Copyright © 2018 Cielabs. All rights reserved.
//

import UIKit
import FirebaseAuthUI

class FUICustomPasswordSignInViewController: FUIPasswordSignInViewController, UITextFieldDelegate {
    var headerShape: HeaderShape!
    var titleLabel: UILabel!
    
    var textFieldUserEmail: ACFloatingTextfield!
    var textFieldUserPassword: ACFloatingTextfield!
    var loginButton: StyledButton!
    var changeEmailButton: StyledButtonAlternative!
    var eyePasswordButton: UIButton!
    var forgotPasswordButton: UIButton!
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
        
        let aSelector : Selector = #selector(FUICustomPasswordSignInViewController.dismissKeyboard)
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
            titleLabel.text = getLocalizableString(key: "CPSIController.title")
            titleLabel.font = UIFont.boldSystemFont(ofSize: 28.0)
            titleLabel.textColor = .white
            
            return titleLabel
        }()
        
        //MARK : Setup TextField
        //
        
        textFieldUserEmail = {
            let textFieldUserEmail = ACFloatingTextfield()
            
            textFieldUserEmail.delegate = self
            
            textFieldUserEmail.placeholder = getLocalizableString(key: "CPSIController.email-placeholder")
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
            textFieldUserPassword.placeholder = getLocalizableString(key: "CPSIController.password-placeholder")
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
        
        loginButton = {
            let registerButton = StyledButton()
            
            registerButton.setTitle(getLocalizableString(key: "CPSIController.login"), for: .normal)
            registerButton.addTarget(self, action: #selector(loginClicked), for: .touchUpInside)
            return registerButton
        }()
        
        changeEmailButton = {
            let changeEmailButton = StyledButtonAlternative()
            
            changeEmailButton.setTitle(getLocalizableString(key: "CPSIController.change-email"), for: .normal)
            changeEmailButton.addTarget(self, action: #selector(changeEmailButtonClicked), for: .touchUpInside)
            return changeEmailButton
        }()
        
        eyePasswordButton = {
            let eyesPasswordButton = UIButton()
            eyesPasswordButton.setImage(UIImage(named: "eyesClosed"), for: .normal)
            
            eyesPasswordButton.addTarget(self, action: #selector(showHideAction), for: .touchUpInside)
            eyesPasswordButton.translatesAutoresizingMaskIntoConstraints = false
            
            return eyesPasswordButton
        }()
        
        forgotPasswordButton = {
            let forgotPasswordButton = UIButton()
            forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
            forgotPasswordButton.setTitle(getLocalizableString(key: "CPSIController.forgotPassword"), for: .normal)
            forgotPasswordButton.setTitleColor(UIColor.SanCristobalGreen, for: .normal)
            forgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
            forgotPasswordButton.addTarget(self, action: #selector(onForgotPassword), for: .touchUpInside)
            
            return forgotPasswordButton
        }()
        
        self.view.addSubview(headerShape)
        headerShape.addSubview(loginLogoImg)
        headerShape.addSubview(titleLabel)
        
        self.view.addSubview(textFieldUserEmail)
        self.view.addSubview(textFieldUserPassword)
        self.view.addSubview(loginButton)
        self.view.addSubview(changeEmailButton)
        self.view.addSubview(eyePasswordButton)
        self.view.addSubview(forgotPasswordButton)
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": textFieldUserEmail]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]-8-[v1(25)]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": textFieldUserPassword, "v1": eyePasswordButton]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": headerShape]))
        headerShape.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-24-[v0(48)]-12-[v1]-30-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": loginLogoImg, "v1": titleLabel]))
        headerShape.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[v0]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["superview": headerShape, "v0": loginLogoImg]))
        headerShape.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[v0]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["superview": headerShape, "v0": titleLabel]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": loginButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": changeEmailButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": forgotPasswordButton]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-36-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": textFieldUserEmail, "v1": eyePasswordButton]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0(160)]-24-[v3(52)]-16-[v4(52)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": headerShape, "v3": textFieldUserEmail, "v4": textFieldUserPassword]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v4(46)]-16-[v5(46)]-16-[v6]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v4": loginButton, "v5": changeEmailButton, "v6": forgotPasswordButton]))
    }
    
    @objc func dismissKeyboard(){
        if textFieldUserEmail.isFirstResponder {
            _ = textFieldUserEmail.resignFirstResponder()
        } else if textFieldUserPassword.isFirstResponder {
            _ = textFieldUserPassword.resignFirstResponder()
        }
    }
    
    @objc func changeEmailButtonClicked() {
        self.onBack()
    }
    
    @objc func loginClicked() {
        self.onNext()
    }
    
    
    func onNext() {
        if let email = textFieldUserEmail.text, let password = textFieldUserPassword.text {
            self.signIn(withDefaultValue: email, andPassword: password)
        }
    }
    
    
    func onCancel(_ sender: AnyObject) {
        self.cancelAuthorization()
    }
    
    func onBack(_ sender: AnyObject) {
        self.onBack()
    }
    
    @objc func onForgotPassword() {
        if let email = textFieldUserEmail.text {
            self.forgotPassword(forEmail: email)
        }
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
            let password = textFieldUserPassword.text{
            
            //nextButton.isEnabled = !email.isEmpty && !password.isEmpty && !username.isEmpty
            self.didChangeEmail(email, andPassword: password)
        }
    }
    
    
    // MARK: - UITextFieldDelegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldUserEmail {
            _ = textFieldUserPassword.becomeFirstResponder()
        } else if textField == textFieldUserPassword {
            self.onNext()
        }
        
        return false
    }
    
}

