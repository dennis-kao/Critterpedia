//
//  HemisphereViewController.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-04-23.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import Foundation
import UIKit

final class HemisphereViewController: UIViewController {
    
    fileprivate let whichHemisphereLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Hemisphere", comment: "Which hemisphere?")
        label.font = UIFont(name: "FinkHeavy", size: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1;
        label.minimumScaleFactor = 0.7;
        label.adjustsFontSizeToFitWidth = true;
        return label
    }()
    
    fileprivate let hemispherePicker = HemispherePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.9794296622, green: 0.9611505866, blue: 0.882307291, alpha: 1)
        
        self.navigationController?.navigationBar.transparent()
        
        view.addSubview(whichHemisphereLabel)
        whichHemisphereLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            whichHemisphereLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            whichHemisphereLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            whichHemisphereLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        view.addSubview(hemispherePicker)
        hemispherePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hemispherePicker.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            hemispherePicker.widthAnchor.constraint(equalToConstant: 312),
            hemispherePicker.heightAnchor.constraint(equalToConstant: 130),
            hemispherePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        hemispherePicker.addTargets(sender: self, northAction: #selector(goToCritterListing), southAction:  #selector(goToCritterListing), event: .touchUpInside)
    }
    
    @objc func goToCritterListing() {
        let viewController = CritterListingViewController()
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.show(viewController, sender: self)
    }
}
