//
//  TitleView.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-05-10.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import UIKit

final class TitleView: UIView {
    
    let critterLabel: UILabel = {
        let label = UILabel()
        label.layer.borderColor =  #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 1)
        label.layer.borderWidth = 4
        label.layer.cornerRadius = 4
        label.font = UIFont(name: "FinkHeavy", size: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .init(width: -3, height: 3)
        layer.shadowRadius = 2
        transform = transform.rotated(by: CGFloat(-3 * .pi / 180.0))
        
        critterLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(critterLabel)
        NSLayoutConstraint.activate([
            critterLabel.heightAnchor.constraint(equalTo: heightAnchor, constant: -8),
            critterLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -8),
            critterLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            critterLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
