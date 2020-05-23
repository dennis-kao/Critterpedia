//
//  SplashViewController.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-04-22.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import UIKit

final class SplashViewController: UIViewController {
    
    fileprivate let leafBackground: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "SplashScreenBackground.png"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    fileprivate let getStartedButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.8431372549, green: 0.8666666667, blue: 0.5333333333, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "FinkHeavy", size: 24)
        button.setAttributedTitle(NSAttributedString(string: NSLocalizedString("Go", comment: "Proceed to the next screen"), attributes: [NSAttributedString.Key.kern: -0.26, NSAttributedString.Key.foregroundColor: UIColor.black.cgColor]), for: .normal)
        button.startAnimatingPressActions()
        return button
    }()
    fileprivate let critterpediaLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: NSLocalizedString("App", comment: "The name of the app"), attributes: [NSAttributedString.Key.kern: 2.77])
        label.font = UIFont(name: "FinkHeavy", size: 50)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1;
        label.minimumScaleFactor = 0.7;
        label.adjustsFontSizeToFitWidth = true;
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.9794296622, green: 0.9611505866, blue: 0.882307291, alpha: 1)
        
        // background
        self.view.addSubview(leafBackground)
        leafBackground.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leafBackground.heightAnchor.constraint(equalTo: view.heightAnchor),
            leafBackground.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        //title
        self.view.addSubview(critterpediaLabel)
        critterpediaLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            critterpediaLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            critterpediaLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            critterpediaLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            critterpediaLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        //button
        self.view.addSubview(getStartedButton)
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            getStartedButton.heightAnchor.constraint(equalToConstant: 43),
            getStartedButton.widthAnchor.constraint(equalToConstant: 157),
            getStartedButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        getStartedButton.addTarget(self, action: #selector(goToHemispherePicker), for: .touchUpInside)
    }
        
    @objc func goToHemispherePicker() {
        let navController = UINavigationController(rootViewController: HemisphereViewController())
        navController.modalPresentationStyle = .fullScreen
        navController.modalTransitionStyle = .flipHorizontal
        self.present(navController, animated: true, completion: nil)
    }
}
