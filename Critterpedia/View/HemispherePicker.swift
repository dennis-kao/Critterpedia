//
//  HemispherePicker.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-04-23.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import UIKit

enum Hemisphere {
    case Northern
    case Southern
}

protocol HemispherePickerDelegate {
    func hemispherePicked(hemisphere: Hemisphere)
}

final class HemispherePicker: UIStackView {
    
    fileprivate let northernHemisphereButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: NSLocalizedString("North", comment: "North hemisphere"), attributes: [NSAttributedString.Key.kern: 1.66, NSAttributedString.Key.foregroundColor: UIColor.black.cgColor]), for: .normal)
        button.titleLabel?.font = UIFont(name: "FinkHeavy", size: 24)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.8823529412, blue: 0.6352941176, alpha: 1)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 2;
        button.titleLabel?.minimumScaleFactor = 0.7;
        button.titleLabel?.adjustsFontSizeToFitWidth = true;
        button.startAnimatingPressActions()
        return button
    }()
    
    fileprivate let southernHemisphereButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: NSLocalizedString("South", comment: "South hemisphere"), attributes: [NSAttributedString.Key.kern: 1.66, NSAttributedString.Key.foregroundColor: UIColor.black.cgColor]), for: .normal)
        button.titleLabel?.font = UIFont(name: "FinkHeavy", size: 24)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.8823529412, blue: 0.6352941176, alpha: 1)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 2;
        button.titleLabel?.minimumScaleFactor = 0.7;
        button.titleLabel?.adjustsFontSizeToFitWidth = true;
        button.startAnimatingPressActions()
        return button
    }()
    
    var delegate: HemispherePickerDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addArrangedSubview(northernHemisphereButton)
        self.addArrangedSubview(southernHemisphereButton)
        self.spacing = 20
        self.axis = .horizontal
        self.distribution = .fillEqually
        
        northernHemisphereButton.addTarget(self, action: #selector(hemispherePicked(sender:)), for: .touchUpInside)
        southernHemisphereButton.addTarget(self, action: #selector(hemispherePicked(sender:)), for: .touchUpInside)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    @objc fileprivate func hemispherePicked(sender: UIButton) {
        if sender == northernHemisphereButton {
            self.delegate?.hemispherePicked(hemisphere: .Northern)
        } else if sender == southernHemisphereButton {
            self.delegate?.hemispherePicked(hemisphere: .Southern)
        } else {
            fatalError("Unknown button called hemispherePicked")
        }
    }
}
