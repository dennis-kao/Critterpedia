//
//  CritterDetailViewController.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-05-10.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import UIKit

final class CritterDetailViewController: UIViewController {
    
    fileprivate let critter: Critter
    
    fileprivate let critterDetail = CritterDetailView()
    
    init(critter: Critter) {
        self.critter = critter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9794296622, green: 0.9611505866, blue: 0.882307291, alpha: 1)
        
        critterDetail.titleView.critterLabel.text = critter.name
        fetchCritterImage(critter: critter)
        
        view.addSubview(critterDetail)
        critterDetail.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            critterDetail.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -10),
            critterDetail.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            critterDetail.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            critterDetail.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    fileprivate func fetchCritterImage(critter: Critter) {
        DispatchQueue.global(qos: .background).async {
            let image = UIImage(named: "\(critter.imageName).png", in: Bundle(for: type(of: self)), with: nil)
            DispatchQueue.main.async {
                self.critterDetail.imageView.image = image
            }
        }
    }
}
