//
//  CritterListingViewController.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-04-25.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import Foundation
import UIKit

final class CritterListingViewController: UIViewController, CritterPickerDelegate {
    
    let critterPicker = CritterPicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.9794296622, green: 0.9611505866, blue: 0.882307291, alpha: 1)
        
        view.addSubview(critterPicker)
        critterPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            critterPicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            critterPicker.heightAnchor.constraint(equalToConstant: 200),
            critterPicker.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            critterPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        critterPicker.delegate = self
    }
    
    func critterPicked(picked: CritterType) {
        switch picked {
            case .Insects:
                print("Picked Insects")
            case .Fish:
                print("Picked Fish")
        }
    }
}
