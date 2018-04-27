//
//  StyledButtonAlternative.swift
//  EasyGruaCPAR02
//
//  Created by Gabriel Quispe Delgadillo on 26/4/18.
//  Copyright © 2018 Cielabs. All rights reserved.
//

import UIKit

class StyledButtonAlternative: UIButton {
    private let nonClickColor = UIColor.SanCristobalGreen
    private let clickColor = UIColor.SanCristobalDarkGreen
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = nonClickColor.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = .white
        self.contentEdgeInsets = UIEdgeInsetsMake(15, 10, 15, 10);
        self.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        self.setTitleColor(nonClickColor, for: .normal)
        self.setTitleColor(clickColor, for: .highlighted)
        self.layer.cornerRadius = 24
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.layer.borderColor = isHighlighted ? clickColor.cgColor : nonClickColor.cgColor
        }
    }
}



