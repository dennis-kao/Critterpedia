//
//  CritterTableViewCell.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-05-06.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import UIKit

class CritterTableViewCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "FinkHeavy", size: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        label.layer.borderColor = #colorLiteral(red: 0.862745098, green: 0.8274509804, blue: 0.6470588235, alpha: 1)
        label.layer.borderWidth = 0.5
        return label
    }()
    
    let critterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = nil
        imageView.layer.borderColor = #colorLiteral(red: 0.862745098, green: 0.8274509804, blue: 0.6470588235, alpha: 1)
        imageView.layer.borderWidth = 0.5
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = #colorLiteral(red: 0.9794296622, green: 0.9611505866, blue: 0.882307291, alpha: 1)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalTo: heightAnchor),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor),
        ])
        
        critterImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(critterImage)
        NSLayoutConstraint.activate([
            critterImage.heightAnchor.constraint(equalTo: heightAnchor),
            critterImage.leftAnchor.constraint(equalTo: leftAnchor),
            critterImage.rightAnchor.constraint(equalTo: nameLabel.leftAnchor),
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
