//
//  HemispherePicker.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-04-23.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import UIKit

final class HemispherePicker: UIStackView {
    
    fileprivate let northernHemisphereButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("North", comment: "North hemisphere"), for: .normal)
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
        button.setTitle(NSLocalizedString("South", comment: "South hemisphere"), for: .normal)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addArrangedSubview(northernHemisphereButton)
        self.addArrangedSubview(southernHemisphereButton)
        self.spacing = 20
        self.axis = .horizontal
        self.distribution = .fillEqually
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTargets(sender: Any?, northAction: Selector, southAction: Selector, event: UIControl.Event) {
        northernHemisphereButton.addTarget(sender, action: northAction, for: event)
        southernHemisphereButton.addTarget(sender, action: southAction, for: event)
    }
}
