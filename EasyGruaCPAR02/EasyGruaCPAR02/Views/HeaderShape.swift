//
//  HeaderShape.swift
//  EasyGruaCPAR02
//
//  Created by Gabriel Quispe Delgadillo on 26/4/18.
//  Copyright © 2018 Cielabs. All rights reserved.
//

import UIKit

class HeaderShape: UIView {
    
    override func draw(_ rect: CGRect) {
        
        let mask = CAShapeLayer()
        mask.frame = self.layer.bounds
        
        let width = self.layer.frame.size.width
        let height = self.layer.frame.size.height
        
        let path = CGMutablePath()
        
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height-(height*0.25)))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        mask.path = path
        
        self.layer.mask = mask
        
        let shape = CAShapeLayer()
        shape.frame = self.bounds
        shape.path = path
        shape.lineWidth = 0
        shape.strokeColor = UIColor.clear.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.backgroundColor = UIColor.SanCristobalGreen.cgColor
        
        self.layer.insertSublayer(shape, at: 0)
        
    }
    
    
}


