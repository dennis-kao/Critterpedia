//
//  CritterPicker.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-04-25.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import Foundation
import UIKit

class CritterPicker: UIControl {
    
    fileprivate let fillColor: UIColor = .white
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isOpaque = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let circleGap: CGFloat = bounds.width * 0.05
        let circleCenter1 = CGPoint(x: bounds.width / 4 + circleGap, y: bounds.height / 2)
        let circleCenter2 = CGPoint(x: 3 * bounds.width / 4 - circleGap, y: bounds.height / 2)
        
        let radius: CGFloat = max(bounds.width, bounds.height) / 4
                
        let path1 = UIBezierPath(arcCenter: circleCenter1,
            radius: radius,
        startAngle: 0,
          endAngle: 360,
         clockwise: true)
        
        let path2 = UIBezierPath(arcCenter: circleCenter2,
            radius: radius,
        startAngle: 0,
          endAngle: 360,
         clockwise: true)
        
        fillColor.setFill()
        path1.fill()
        path2.fill()
    }
}
