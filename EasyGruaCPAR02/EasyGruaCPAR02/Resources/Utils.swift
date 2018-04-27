//
//  Utils.swift
//  EasyGruaCPAR02
//
//  Created by Gabriel Quispe Delgadillo on 26/4/18.
//  Copyright © 2018 Cielabs. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    static func getLocalizableString(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}

extension UIViewController {
    func getLocalizableString(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    func setNavigationLogo(viewcontroller: UIViewController) {
        let image : UIImage = UIImage(named: "loginLogo")!
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        
        let titleView = UIView.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.frame = titleView.bounds
        titleView.addSubview(imageView)
        viewcontroller.navigationItem.titleView = titleView
    }
    
    func presentAlert(title: String?, message: String, confirmStyle: Bool){
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
        
        present(alertController, animated: true, completion: nil)
    }
}

extension UIView {
    func getLocalizableString(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
                
                self.layer.cornerRadius = 10
                self.clipsToBounds = true
                
                self.layer.borderWidth = 3.0
                self.layer.borderColor = UIColor.white.cgColor
                
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

extension UIColor {
    static let SanCristobalDarkGreen = UIColor(red: 0.0/255.0, green: 130.0/255.0, blue: 71.0/255.0, alpha: 1.0)
    static let SanCristobalGreen = UIColor(red:0.15, green:0.68, blue:0.38, alpha:1.0)
}


