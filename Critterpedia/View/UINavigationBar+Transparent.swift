//
//  NavigationBar+Transparent.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-04-27.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    func transparent() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}
