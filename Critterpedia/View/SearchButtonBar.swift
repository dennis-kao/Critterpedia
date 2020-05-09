//
//  SearchButtonBar.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-05-09.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import Foundation
import UIKit

class SearchButtonBar: UIView {
    
    fileprivate let searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.8823529412, blue: 0.6352941176, alpha: 1)
        button.setImage(#imageLiteral(resourceName: "SearchIcon.png"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        button.layer.cornerRadius = 20
        return button
    }()
    
    fileprivate let sortButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.8823529412, blue: 0.6352941176, alpha: 1)
        button.setImage(#imageLiteral(resourceName: "SortButton.png"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        button.layer.cornerRadius = 20
        return button
    }()

    fileprivate var searchBar: UISearchBar
    
    init(searchBar: UISearchBar) {
        self.searchBar = searchBar
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        backgroundColor = #colorLiteral(red: 0.9794296622, green: 0.9611505866, blue: 0.882307291, alpha: 1)
        
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sortButton)
        NSLayoutConstraint.activate([
            sortButton.heightAnchor.constraint(equalToConstant: 40),
            sortButton.widthAnchor.constraint(equalToConstant: 40),
            sortButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            sortButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -35),
        ])
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchButton)
        NSLayoutConstraint.activate([
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchButton.rightAnchor.constraint(equalTo: sortButton.leftAnchor, constant: -13),
        ])
    }
}
