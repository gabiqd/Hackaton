//
//  PerfilViewController.swift
//  EasyGruaCPAR02
//
//  Created by Gabriel Quispe Delgadillo on 26/4/18.
//  Copyright © 2018 Cielabs. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuthUI
import CoreFoundation

class PerfilViewController: UIViewController {
    var logOutButton: StyledButton!
    var reviewButton: StyledButtonAlternative!
    var profileImageView: UIImageView!
    var headerView: UIView!
    var separatorLine: Line!
    var nameLabel: UILabel!
    var phoneLabel: UILabel!
    var emailLabel: UILabel!
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        currentUser = Auth.auth().currentUser
        
        headerView = {
            let headerView = UIView()
            headerView.translatesAutoresizingMaskIntoConstraints = false
            headerView.backgroundColor = UIColor.SanCristobalGreen
            return headerView
        }()
        
        profileImageView = {
            let profileImageView = UIImageView()
            profileImageView.translatesAutoresizingMaskIntoConstraints = false
            
            guard let profileURL = self.currentUser?.photoURL else{
                profileImageView.image = UIImage(named: "userPictureDefault")
                profileImageView.contentMode = .scaleAspectFit
                return profileImageView
            }
            profileImageView.downloadedFrom(url: profileURL)
            
            return profileImageView
        }()
        
        separatorLine = {
            let separatorLine = Line()
            separatorLine.backgroundColor = UIColor.SanCristobalDarkGreen
            separatorLine.translatesAutoresizingMaskIntoConstraints = false
            return separatorLine
        }()
        
        nameLabel = {
            let nameLabel = UILabel()
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
            nameLabel.textColor = UIColor.SanCristobalGreen
            
            if currentUser != nil, let displayName = currentUser.displayName {
                nameLabel.text = displayName
            }else{
                nameLabel.text = "-"
            }
            
            return nameLabel
        }()
        
        phoneLabel = {
            let phoneLabel = UILabel()
            phoneLabel.translatesAutoresizingMaskIntoConstraints = false
            phoneLabel.font = UIFont.systemFont(ofSize: 16.0)
            
            if currentUser != nil, let phoneNumber = currentUser.phoneNumber {
                phoneLabel.text = phoneNumber
            }else{
                phoneLabel.text = "-"
            }
            
            phoneLabel.textColor = UIColor.black
            return phoneLabel
        }()
        
        emailLabel = {
            let emailLabel = UILabel()
            emailLabel.translatesAutoresizingMaskIntoConstraints = false
            emailLabel.font = UIFont.systemFont(ofSize: 16.0)
            if currentUser != nil, let email = currentUser.email {
                emailLabel.text = email
            }else{
                emailLabel.text = "-"
            }
            
            emailLabel.textColor = UIColor.black
            return emailLabel
        }()
        
        reviewButton = {
            let reviewButton = StyledButtonAlternative()
            reviewButton.setTitle(getLocalizableString(key: "PfileController.ask-review"), for: .normal)
            reviewButton.addTarget(self, action: #selector(sendToReview), for: .touchUpInside)
            return reviewButton
        }()
        
        logOutButton = {
            let nextStyledButton = StyledButton()
            
            nextStyledButton.setTitle(getLocalizableString(key: "PfileController.log-out"), for: .normal)
            nextStyledButton.addTarget(self, action: #selector(logOutClicked), for: .touchUpInside)
            return nextStyledButton
        }()
        
        self.view.addSubview(headerView)
        self.view.addSubview(profileImageView)
        self.view.addSubview(separatorLine)
        self.view.addSubview(nameLabel)
        self.view.addSubview(emailLabel)
        self.view.addSubview(phoneLabel)
        self.view.addSubview(reviewButton)
        self.view.addSubview(logOutButton)
        
        
        let centerXConst = NSLayoutConstraint(item: profileImageView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(item: profileImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0)
        profileImageView.addConstraint(widthConstraint)
        NSLayoutConstraint.activate([centerXConst])
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": reviewButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]-50-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": logOutButton]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0(100)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":headerView]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": headerView]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-72-[v0]-72-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": separatorLine]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[v0(100)]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["superview": view, "v0": nameLabel]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[v0(100)]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["superview": view, "v0": emailLabel]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[v0(100)]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["superview": view, "v0": phoneLabel]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[v0(100)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":profileImageView]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-136-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":profileImageView, "v1": nameLabel, "v2": separatorLine, "v3": emailLabel, "v4": phoneLabel]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-176-[v0]-8-[v1(1)]-16-[v2]-16-[v3]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel, "v1": separatorLine, "v2": emailLabel, "v3": phoneLabel]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v1(46)]-8-[v0(46)]-64-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": logOutButton, "v1": reviewButton]))
        
    }
    
    @objc func logOutClicked() {
        let authUI = FUIAuth.defaultAuthUI()
        
        do {
            try authUI!.signOut()
        } catch {
            print("Can't Sign Out")
        }
        
    }
    
    @objc func sendToReview() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            let appSupportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
            let appID = appSupportURL.appendingPathComponent("\(bundleIdentifier)").appendingPathComponent("Documents")
            
            guard let url = URL(string: "itms-apps://itunes.apple.com/us/app/itunes-u/id\(appID)?ls=1&mt=8&action=write-review") else {return}
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}



