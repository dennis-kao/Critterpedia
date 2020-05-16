//
//  CalendarCollectionViewCell.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-05-10.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "FinkHeavy", size: 30)
        label.textColor = #colorLiteral(red: 0.7921568627, green: 0.7764705882, blue: 0.6980392157, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 0
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
        isUserInteractionEnabled = false
        backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9607843137, blue: 0.8901960784, alpha: 1)
        
        addSubview(monthLabel)
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            monthLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.85),
            monthLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            monthLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            monthLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func setAvailableMonth() {
        monthLabel.textColor = .black
        monthLabel.layer.masksToBounds = true
        monthLabel.layer.cornerRadius = 6
        monthLabel.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8352941176, blue: 0.3294117647, alpha: 1)
    }
    
    func setCurrentMonth() {
        let borderColor = #colorLiteral(red: 0.8352941176, green: 0.3882352941, blue: 0.2901960784, alpha: 1)
        
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 4
        
        let _ = addExternalBorder(borderWidth: 2, borderColor: borderColor)
    }
}
