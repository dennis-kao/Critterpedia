//
//  CritterDetailViewController.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-05-10.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import UIKit

class CritterDetailViewController: UIViewController {
    
    let critter: Critter
    
    init(critter: Critter) {
        self.critter = critter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
