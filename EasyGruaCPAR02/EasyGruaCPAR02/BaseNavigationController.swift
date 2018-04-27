//
//  BaseNavigationController.swift
//  EasyGruaCPAR02
//
//  Created by Gabriel Quispe Delgadillo on 26/4/18.
//  Copyright © 2018 Cielabs. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.barTintColor = UIColor.SanCristobalGreen
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        self.navigationController?.navigationBar.isTranslucent = false
    }
}

