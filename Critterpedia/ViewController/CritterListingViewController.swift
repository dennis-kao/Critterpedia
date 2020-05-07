//
//  CritterListingViewController.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-04-25.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import Foundation
import UIKit

final class CritterListingViewController: UIViewController {
    
    fileprivate let critterPicker = CritterPicker()
    fileprivate let insectCritters = CritterParser.loadJson(filename: "Insects")
    fileprivate let fishCritters = CritterParser.loadJson(filename: "Fish")

    fileprivate let tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100
        table.layer.borderColor = #colorLiteral(red: 0.6156862745, green: 0.5843137255, blue: 0.4156862745, alpha: 1)
        table.layer.borderWidth = 1
        table.backgroundColor = #colorLiteral(red: 0.9794296622, green: 0.9611505866, blue: 0.882307291, alpha: 1)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        critterPicker.delegate = self
        
        view.backgroundColor = #colorLiteral(red: 0.9794296622, green: 0.9611505866, blue: 0.882307291, alpha: 1)
        
        view.addSubview(critterPicker)
        critterPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            critterPicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            critterPicker.heightAnchor.constraint(equalToConstant: 200),
            critterPicker.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            critterPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: critterPicker.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CritterTableViewCell.self, forCellReuseIdentifier: String(describing: CritterTableViewCell.self))
    }
    
    func fetchCritterImage(critter: Critter, indexPath: IndexPath) {
        DispatchQueue.global(qos: .background).async {
            let image = UIImage(named: "\(critter.imageName).png", in: Bundle(for: type(of: self)), with: nil)
                                    
            DispatchQueue.main.async {
                // is the cell visible on the tableView
                if let cell = self.tableView.cellForRow(at: indexPath) as? CritterTableViewCell {
                    cell.critterImage.image = image
                }
            }
        }
    }
}

extension CritterListingViewController: CritterPickerDelegate {
    
    func critterPicked(picked: CritterType) {
        tableView.reloadData()
    }
}

extension CritterListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let insectCritters = insectCritters, critterPicker.selectedCritter == .Insects {
            return insectCritters.count
        } else if let fishCritters = fishCritters, critterPicker.selectedCritter == .Fish {
                   return fishCritters.count
        } else {
            fatalError("Unknown critter type selected for UITableView")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CritterTableViewCell.self), for: indexPath) as! CritterTableViewCell
        
        if let insectCritters = insectCritters, critterPicker.selectedCritter == .Insects {
            cell.nameLabel.text = insectCritters[indexPath.item].name
            fetchCritterImage(critter: insectCritters[indexPath.item], indexPath: indexPath)
        } else if let fishCritters = fishCritters, critterPicker.selectedCritter == .Fish {
            cell.nameLabel.text = fishCritters[indexPath.item].name
            fetchCritterImage(critter: fishCritters[indexPath.item], indexPath: indexPath)
        }
        
        return cell
    }
}
