//
//  LoginLogoImageView.swift
//  EasyGruaCPAR02
//
//  Created by Gabriel Quispe Delgadillo on 26/4/18.
//  Copyright © 2018 Cielabs. All rights reserved.
//

import UIKit

class LoginLogoImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.image = UIImage(named: "loginLogo")
        self.contentMode = .scaleAspectFit
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
        
    }
    
    convenience init(){
        self.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

