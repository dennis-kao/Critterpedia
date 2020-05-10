//
//  CritterListingViewController.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-04-25.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import Foundation
import UIKit
import SHSearchBar

final class CritterListingViewController: UIViewController {
    
    fileprivate let insectCritters = CritterParser.loadJson(filename: "Insects")
    fileprivate let fishCritters = CritterParser.loadJson(filename: "Fish")
    fileprivate var filteredCritters: [Critter] = []
    
    fileprivate let critterPicker = CritterPicker()
    fileprivate lazy var searchButtonBar = SearchButtonBar()
    fileprivate let tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100
        table.layer.borderColor = #colorLiteral(red: 0.6156862745, green: 0.5843137255, blue: 0.4156862745, alpha: 1)
        table.layer.borderWidth = 1
        table.backgroundColor = #colorLiteral(red: 0.9794296622, green: 0.9611505866, blue: 0.882307291, alpha: 1)
        return table
    }()
    
    fileprivate var isSearchBarEmpty: Bool {
      return searchButtonBar.searchBar.text?.isEmpty ?? true
    }
    fileprivate var isFiltering: Bool {
        return searchButtonBar.searchBar.isActive && !isSearchBarEmpty
    }
    
    fileprivate let critterPickerMaxHeight: CGFloat = 200
    fileprivate let critterPickerMinHeight: CGFloat = 130
    fileprivate lazy var pickerHeightAnchor: NSLayoutConstraint = critterPicker.heightAnchor.constraint(equalToConstant: critterPickerMaxHeight)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.9794296622, green: 0.9611505866, blue: 0.882307291, alpha: 1)
        
        critterPicker.delegate = self
        searchButtonBar.searchButtonDelegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CritterTableViewCell.self, forCellReuseIdentifier: String(describing: CritterTableViewCell.self))
                        
        view.addSubview(critterPicker)
        critterPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            critterPicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            critterPicker.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            critterPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        pickerHeightAnchor = critterPicker.heightAnchor.constraint(equalToConstant: critterPickerMaxHeight)
        pickerHeightAnchor.isActive = true
        
        view.addSubview(searchButtonBar)
        searchButtonBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButtonBar.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            searchButtonBar.topAnchor.constraint(equalTo: critterPicker.bottomAnchor),
            searchButtonBar.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchButtonBar.bottomAnchor, constant: 10 ),
            tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    fileprivate func getSelectedCritter() -> [Critter]? {

        switch (critterPicker.selectedCritter) {
            case .Fish:
                return fishCritters
            case .Insect:
                return insectCritters
        }
    }
    
    fileprivate func fetchCritterImage(critter: Critter, indexPath: IndexPath) {
        DispatchQueue.global(qos: .background).async {
            let image = UIImage(named: "\(critter.iconName).png", in: Bundle(for: type(of: self)), with: nil)
                                    
            DispatchQueue.main.async {
                // is the cell visible on the tableView
                if let cell = self.tableView.cellForRow(at: indexPath) as? CritterTableViewCell {
                    cell.critterImage.image = image
                }
            }
        }
    }
    
    fileprivate func filterContentForSearchText(_ searchText: String, category: Critter.Category? = nil) {
        
        guard let selectedCritter = getSelectedCritter() else {
            return
        }

        filteredCritters = selectedCritter.filter { (critter: Critter) -> Bool in
            return critter.name.lowercased().contains(searchText.lowercased())
        }
      
        tableView.reloadData()
    }
    
}

extension CritterListingViewController: CritterPickerDelegate {
    
    func critterPicked(picked: Critter.Category) {
        if isFiltering {
            filterContentForSearchText(searchButtonBar.searchBar.text!)
        } else {
            tableView.reloadData()
        }
    }
}

extension CritterListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredCritters.count
        }
        
        guard let selectedCritter = getSelectedCritter() else {
            return 0
        }
        
        return selectedCritter.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CritterTableViewCell.self), for: indexPath) as! CritterTableViewCell
        var critter: Critter
        
        if isFiltering {
            critter = filteredCritters[indexPath.item]
        } else {
            guard let selectedCritters = getSelectedCritter() else {
                return cell
            }
            
            critter = selectedCritters[indexPath.item]
        }
        
        cell.nameLabel.text = critter.name
        fetchCritterImage(critter: critter, indexPath: indexPath)

        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = scrollView.contentOffset.y
        let newHeaderViewHeight: CGFloat = pickerHeightAnchor.constant - y

        if newHeaderViewHeight > critterPickerMaxHeight {
            pickerHeightAnchor.constant = critterPickerMaxHeight
        } else if newHeaderViewHeight < critterPickerMinHeight {
            pickerHeightAnchor.constant = critterPickerMinHeight
        } else {
            pickerHeightAnchor.constant = newHeaderViewHeight
            scrollView.contentOffset.y = 0 // block scroll view
        }
    }
}

extension CritterListingViewController: ButtonBarDelegate {
    
    func searchBar(_ searchBar: SHSearchBar, textDidChange text: String) {
        filterContentForSearchText(text)
    }

    func searchButtonTapped(isBarActive: Bool) {
        if !isBarActive {
            tableView.reloadData()
        }
    }
}
