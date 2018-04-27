//
//  FUICustomPasswordVerificationViewController.swift
//  EasyGruaCPAR02
//
//  Created by Gabriel Quispe Delgadillo on 26/4/18.
//  Copyright © 2018 Cielabs. All rights reserved.
//

import UIKit
import FirebaseAuthUI
import FirebaseAuth

class FUICustomPasswordVerificationViewController: FUIPasswordVerificationViewController, UITextFieldDelegate {
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    
    var userEmail: String
    
    var infoLabel: UILabel!
    var passwordTextField: UITextField!
    var nextButton: UIBarButtonItem!
    var loginLogoImg: LoginLogoImageView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, authUI: FUIAuth, email: String?, newCredential: AuthCredential) {
        userEmail = email ??  ""
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil, authUI: authUI, email: email, newCredential: newCredential)
        
        infoLabel.text = "You’ve already used \(userEmail). Enter your password for that account to sign in."
    }
    
    required init?(coder aDecoder: NSCoder) {
        userEmail = ""
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //override action of default 'Next' button to use custom layout elements'
        self.navigationItem.rightBarButtonItem?.target = self
        self.navigationItem.rightBarButtonItem?.action = #selector(onNext)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //update state of all UI elements (e g disable 'Next' buttons)
        self.updateTextFieldValue(nil)
    }
    
    func onForgotPassword(_ sender: AnyObject) {
        self.forgotPassword()
    }
    
    @objc func onNext(_ sender: AnyObject?) {
        if let password = passwordTextField.text {
            self.verifyPassword(password)
        }
    }
    
    func onCancel(_ sender: AnyObject) {
        self.cancelAuthorization()
    }
    
    func onBack(_ sender: AnyObject) {
        self.onBack()
    }
    
    func onViewSelected(_ sender: AnyObject) {
        passwordTextField.resignFirstResponder()
    }
    
    // MARK: - UITextFieldDelegate methods
    
    func updateTextFieldValue(_ sender: AnyObject?) {
        if let password = passwordTextField.text {
            nextButton.isEnabled = !password.isEmpty
            self.didChangePassword(password)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            self.onNext(nil)
        }
        
        return false
    }
}



