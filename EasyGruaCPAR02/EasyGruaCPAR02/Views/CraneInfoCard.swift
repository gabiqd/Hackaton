//
//  CraneInfoCard.swift
//  EasyGruaCPAR02
//
//  Created by Gabriel Quispe Delgadillo on 27/4/18.
//  Copyright © 2018 Cielabs. All rights reserved.
//

import Foundation
import UIKit

class CraneInfoCard: UIView {
    var nameLabel: UILabel!
    var dniLabel: UILabel!
    var phoneButton: StyledButton!
    var distanceLabel: UILabel!
    var aproxTime: UILabel!
    var topShapeAux: UIView!
    var profileImageView: UIImageView!
    var callPhone = "0"
    var parentViewController: UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 5.0
        self.layer.borderColor  =  UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.2
        self.layer.shadowOpacity = 1.0
        self.layer.shadowColor =  UIColor(red: 225.0/255.0, green: 228.0/255.0, blue: 228.0/255.0, alpha: 1.0).cgColor
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width:5, height: 5)
        self.layer.masksToBounds = true
        
        initViews()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        topShapeAux = {
            let topShapeAux = UIView()
            topShapeAux.translatesAutoresizingMaskIntoConstraints = false
            return topShapeAux
        }()
        
        profileImageView = {
            let profileImageView = UIImageView()
            profileImageView.translatesAutoresizingMaskIntoConstraints = false
            profileImageView.layer.cornerRadius = 36 //full aspect 72
            profileImageView.layer.masksToBounds = true
            profileImageView.contentMode = .scaleAspectFill
            return profileImageView
        }()
        
        nameLabel = {
            let nameLabel = UILabel()
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            nameLabel.textColor = .black
            nameLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
            return nameLabel
        }()
        
        dniLabel = {
            let dniLabel = UILabel()
            dniLabel.translatesAutoresizingMaskIntoConstraints = false
            dniLabel.textColor = .gray
            dniLabel.font = UIFont.systemFont(ofSize: 16.0)
            return dniLabel
        }()
        
        phoneButton = {
            let phoneButton = StyledButton()
            phoneButton.translatesAutoresizingMaskIntoConstraints = false
            phoneButton.titleLabel?.textColor = UIColor.SanCristobalGreen
            phoneButton.addTarget(self, action: #selector(callCrane), for: .touchUpInside)
            phoneButton.titleLabel?.text = "Pedir grúa"
            phoneButton.setTitle("Pedir grúa", for: .normal)
            return phoneButton
        }()
        
        distanceLabel = {
            let distanceLabel = UILabel()
            distanceLabel.translatesAutoresizingMaskIntoConstraints = false
            distanceLabel.font = UIFont.systemFont(ofSize: 16.0)
            distanceLabel.textColor = .gray
            distanceLabel.textAlignment = .center
            return distanceLabel
        }()
        
        aproxTime = {
            let aproxTime = UILabel()
            aproxTime.translatesAutoresizingMaskIntoConstraints = false
            aproxTime.font = UIFont.systemFont(ofSize: 16.0)
            aproxTime.textColor = .gray
            aproxTime.textAlignment = .center
            return aproxTime
        }()
    }
    
    func setUpConstraints() {
        self.addSubview(phoneButton)
        self.addSubview(distanceLabel)
        self.addSubview(aproxTime)
        self.addSubview(topShapeAux)
        
        topShapeAux.addSubview(dniLabel)
        topShapeAux.addSubview(nameLabel)
        topShapeAux.addSubview(profileImageView)
        
        topShapeAux.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0(72)]-16-[v1]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImageView, "v1": nameLabel]))
        
        let centerYConst = NSLayoutConstraint(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: topShapeAux, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(item: profileImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 72.0)
        profileImageView.addConstraint(heightConstraint)
        NSLayoutConstraint.activate([centerYConst])
        
        topShapeAux.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0]-8-[v1]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel, "v1": dniLabel]))
        topShapeAux.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-104-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dniLabel]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-16-[v1]-16-[v2]-24-[v3]-24-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": topShapeAux, "v1": distanceLabel, "v2": aproxTime, "v3": phoneButton]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": topShapeAux]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": distanceLabel]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": aproxTime]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-32-[v0]-32-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": phoneButton]))
    }
    
    @objc func callCrane() {
        if phoneButton.titleLabel?.text == "Pedir grúa" {
            phoneButton.titleLabel?.text =  "Llamar grúa"
            phoneButton.setTitle("Llamar grúa", for: .normal)
            presentAlert(title: "Grúa pedida", message: "La grúa ya fue notificada. Espera en el lugar el tiempo estimado", confirmStyle: false, viewController: parentViewController)
        }else{
            if let url = URL(string: "tel://\(callPhone)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    func presentAlert(title: String?, message: String, confirmStyle: Bool, viewController: UIViewController?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if confirmStyle {
            let alertCancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            alertController.addAction(alertCancelAction)
            let alertAceptAction = UIAlertAction(
                title: "Aceptar",
                style: .destructive) { (action) in
                    
            }
            alertController.addAction(alertAceptAction)
        }
        else{
            let alertAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alertController.addAction(alertAction)
        }
        
        viewController?.present(alertController, animated: true, completion: nil)
    }
}
