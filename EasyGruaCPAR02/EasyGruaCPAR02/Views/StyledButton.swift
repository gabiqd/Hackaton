//
//  StyledButton.swift
//  EasyGruaCPAR02
//
//  Created by Gabriel Quispe Delgadillo on 26/4/18.
//  Copyright © 2018 Cielabs. All rights reserved.
//

import UIKit

class StyledButton: UIButton {
    private let nonClickColor = UIColor.SanCristobalGreen
    private let clickColor = UIColor.SanCristobalDarkGreen
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = nonClickColor
        self.contentEdgeInsets = UIEdgeInsetsMake(15, 10, 15, 10);
        self.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        self.layer.cornerRadius = 24
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? clickColor : nonClickColor
        }
    }
}


