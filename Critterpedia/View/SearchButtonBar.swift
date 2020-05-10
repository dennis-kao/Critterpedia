//
//  SearchButtonBar.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-05-09.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import UIKit
import SHSearchBar

protocol ButtonBarDelegate: SHSearchBarDelegate {
    func searchButtonTapped(isBarActive: Bool)
    func sortButtonTapped(sender: UIButton)
}

final class SearchButtonBar: UIView {
    
    fileprivate var isSearchBarEmpty: Bool {
      return searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchBar.isActive && !isSearchBarEmpty
    }
    
    fileprivate let searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.8823529412, blue: 0.6352941176, alpha: 1)
        button.setImage(#imageLiteral(resourceName: "Search Icon"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        button.startAnimatingPressActions()
        return button
    }()
    
    fileprivate let sortButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.8823529412, blue: 0.6352941176, alpha: 1)
        button.setImage(#imageLiteral(resourceName: "Group"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        button.startAnimatingPressActions()
        return button
    }()
    
    let searchBar: SHSearchBar = {
        var config: SHSearchBarConfig = SHSearchBarConfig()
        config.rasterSize = 11
        config.textContentType = "Search for Critters using their names"
        config.textAttributes = [.foregroundColor: UIColor.gray]
        config.useCancelButton = false
        config.cancelButtonTitle = ""

        let bar = SHSearchBar(config: config)
        bar.updateBackgroundImage(withRadius: 6, corners: [.allCorners], color: UIColor.white)
        return bar
    }()
    
    fileprivate lazy var searchBarLeftAnchor: NSLayoutConstraint = searchBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 15)
    fileprivate lazy var searchBarWidthZero: NSLayoutConstraint = searchBar.widthAnchor.constraint(equalToConstant: 0)
    
    var delegate: ButtonBarDelegate? = nil {
        didSet {
            searchBar.delegate = delegate
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchButton.layer.cornerRadius = searchButton.frame.height / 2
        sortButton.layer.cornerRadius = sortButton.frame.height / 2
    }
    
    fileprivate func setupView() {
        
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        sortButton.addTarget(self, action: #selector(sortButtonTapped(sender:)), for: .touchUpInside)

        backgroundColor = #colorLiteral(red: 0.9794296622, green: 0.9611505866, blue: 0.882307291, alpha: 1)
        
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sortButton)
        NSLayoutConstraint.activate([
            sortButton.heightAnchor.constraint(equalToConstant: 40),
            sortButton.widthAnchor.constraint(equalTo: sortButton.heightAnchor),
            sortButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            sortButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -35),
        ])
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchButton)
        NSLayoutConstraint.activate([
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            searchButton.widthAnchor.constraint(equalTo: searchButton.heightAnchor),
            searchButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchButton.rightAnchor.constraint(equalTo: sortButton.leftAnchor, constant: -13),
        ])

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.heightAnchor.constraint(equalTo: heightAnchor),
            searchBar.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchBar.rightAnchor.constraint(equalTo: searchButton.leftAnchor, constant: -15),
            searchBarWidthZero, //start off with search bar hidden
        ])
    }
    
    @objc func searchButtonTapped() {
        
        if searchBarWidthZero.isActive { // the search bar is visible
            searchBar.placeholder = NSLocalizedString("SearchCritters", comment: "Search bar text to filter on Critter names")
            
            // order of constraints matters, will cause auto-layout to break otherwise
            searchBarWidthZero.isActive = !searchBarWidthZero.isActive
            searchBarLeftAnchor.isActive = !searchBarLeftAnchor.isActive
        } else { // search bar is hiding
            
            // need to zero out bar text. width of bar text becomes the minimum width of the bar for some reason
            searchBar.placeholder = ""
            self.searchBar.text = ""
            
            searchBarLeftAnchor.isActive = !searchBarLeftAnchor.isActive
        }
        
        UIView.animate(withDuration: 0.7,
            animations: {
                self.layoutIfNeeded()
            }, completion: { (completed) in
                if (!self.searchBarLeftAnchor.isActive) {
                    // setting search bar width to zero at the end is necessary to allow the growing and shrinking animation to take place
                    // setting left constraint does not make the search bar disappear completely, there are some non-zero fixed margin widths
                    self.searchBarWidthZero.isActive = !self.searchBarWidthZero.isActive
                }
                self.delegate?.searchButtonTapped(isBarActive: self.searchBarLeftAnchor.isActive)
            }
        )
    }
    
    @objc func sortButtonTapped(sender: UIButton) {
        delegate?.sortButtonTapped(sender: sender)
    }
}
