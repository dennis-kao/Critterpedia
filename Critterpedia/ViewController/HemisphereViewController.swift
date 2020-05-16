//
//  HemisphereViewController.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-04-23.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import UIKit

final class HemisphereViewController: UIViewController {
    
    fileprivate let whichHemisphereLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: NSLocalizedString("Hemisphere", comment: "Which hemisphere?"), attributes: [NSAttributedString.Key.kern: 1.66])
        label.font = UIFont(name: "FinkHeavy", size: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    fileprivate let hemispherePicker = HemispherePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hemispherePicker.delegate = self
        
        self.view.backgroundColor = #colorLiteral(red: 0.9794296622, green: 0.9611505866, blue: 0.882307291, alpha: 1)
        
        self.title = ""
        self.navigationController?.navigationBar.tintColor = .black
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
    }
}

extension HemisphereViewController: HemispherePickerDelegate {
    func hemispherePicked(hemisphere: Hemisphere) {
        let viewController = CritterListingViewController()
        viewController.modalPresentationStyle = .fullScreen
        viewController.hemisphere = hemisphere
        self.navigationController?.show(viewController, sender: self)
    }
}
