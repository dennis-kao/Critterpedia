//
//  CritterListingViewController.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-04-25.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import UIKit
import SHSearchBar

final class CritterListingViewController: UIViewController {

    fileprivate var bugCritters = CritterParser.loadJson(filename: "bugs")
    fileprivate var fishCritters = CritterParser.loadJson(filename: "fish")
    fileprivate var seaCritters = CritterParser.loadJson(filename: "sea")
    fileprivate var filteredCritters: [Critter] = []

    var hemisphere: Hemisphere?

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

    fileprivate let critterPickerMaxHeight: CGFloat = 210
    fileprivate let critterPickerMinHeight: CGFloat = 170
    fileprivate lazy var pickerHeightAnchor: NSLayoutConstraint = critterPicker.heightAnchor.constraint(equalToConstant: critterPickerMaxHeight)

    fileprivate var filterOption: Critter.FilterOptions?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = ""
        view.backgroundColor = #colorLiteral(red: 0.9794296622, green: 0.9611505866, blue: 0.882307291, alpha: 1)

        critterPicker.delegate = self
        searchButtonBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CritterTableViewCell.self, forCellReuseIdentifier: String(describing: CritterTableViewCell.self))

        view.addSubview(critterPicker)
        critterPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            critterPicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            critterPicker.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            critterPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        pickerHeightAnchor = critterPicker.heightAnchor.constraint(equalToConstant: critterPickerMaxHeight)
        pickerHeightAnchor.isActive = true

        view.addSubview(searchButtonBar)
        searchButtonBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButtonBar.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            searchButtonBar.topAnchor.constraint(equalTo: critterPicker.bottomAnchor),
            searchButtonBar.heightAnchor.constraint(equalToConstant: 40)
        ])

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchButtonBar.bottomAnchor, constant: 10 ),
            tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    fileprivate func getSelectedCritter() -> [Critter]? {

        switch critterPicker.selectedCritter {
            case .Fish:
                return fishCritters
            case .Insect:
                return bugCritters
            case .Sea:
                return seaCritters
        }
    }

    fileprivate func sortCritters(sort: (Critter, Critter) -> Bool) {
        filterOption = nil
        searchButtonBar.searchBar.cancelSearch()

        switch critterPicker.selectedCritter {
            case .Fish:
                fishCritters?.sort(by: sort)
            case .Insect:
                bugCritters?.sort(by: sort)
            case .Sea:
                seaCritters?.sort(by: sort)
        }

        tableView.reloadData()
    }

    fileprivate func fetchCritterIcon(critter: Critter, indexPath: IndexPath) {
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

    fileprivate func filterCrittersOn(_ filterOption: Critter.FilterOptions) {
        func filterCritters(_ filter: (Critter) -> Bool) {

            guard let selectedCritter = getSelectedCritter() else {
                return
            }

            filteredCritters = selectedCritter.filter(filter)

            tableView.reloadData()
        }

        self.filterOption = filterOption

        if filterOption != .Name && searchButtonBar.isFiltering {
            searchButtonBar.searchBar.cancelSearch()
        }

        switch filterOption {
            case .Name:
                // empty string should show all critters instead of setting filter criteria to none and showing none
                if searchButtonBar.searchBar.text == nil || searchButtonBar.searchBar.text == "" {
                    self.filterOption = nil
                    tableView.reloadData()
                }
                filterCritters({$0.name.lowercased().contains(searchButtonBar.searchBar.text!.lowercased())})
            case .Month:
                let monthNum = Calendar.current.component(.month, from: Date())
                switch hemisphere! {
                    case .Northern:
                        filterCritters({$0.northernMonths.contains(monthNum)})
                    case .Southern:
                        filterCritters({$0.southernMonths.contains(monthNum)})
                }
            case .MonthHour:
                let monthNum = Calendar.current.component(.month, from: Date())
                let hourNum = Calendar.current.component(.hour, from: Date())
                switch hemisphere! {
                    case .Northern:
                        filterCritters({$0.northernMonths.contains(monthNum) && $0.times.contains(hourNum)})
                    case .Southern:
                        filterCritters({$0.southernMonths.contains(monthNum) && $0.times.contains(hourNum)})
                }
        }
    }
}

extension CritterListingViewController: CritterPickerDelegate {

    func critterPicked(picked: Critter.Category) {

        guard let filterOption = self.filterOption else {
            tableView.reloadData()
            return
        }

        filterCrittersOn(filterOption)
    }
}

extension CritterListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if filterOption != nil {
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
        let critter: Critter = {
            if filterOption != nil {
                return filteredCritters[indexPath.item]
            } else {
                switch critterPicker.selectedCritter {
                   case .Fish:
                       return fishCritters![indexPath.item]
                   case .Insect:
                       return bugCritters![indexPath.item]
                   case .Sea:
                        return seaCritters![indexPath.item]
                }
            }
        }()

        cell.nameLabel.text = critter.name
        fetchCritterIcon(critter: critter, indexPath: indexPath)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let critter: Critter = {
            if filterOption != nil {
                return filteredCritters[indexPath.item]
            } else {
                switch critterPicker.selectedCritter {
                   case .Fish:
                       return fishCritters![indexPath.item]
                   case .Insect:
                       return bugCritters![indexPath.item]
                    case .Sea:
                        return seaCritters![indexPath.item]
                }
            }
        }()

        let viewController = CritterDetailViewController(critter: critter, hemisphere: hemisphere!)
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.show(viewController, sender: self)
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

    func sortButtonTapped(sender: UIButton) {

        func getTimeString() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: Date())
        }

        let alertController = UIAlertController(title: nil, message: "View Critters", preferredStyle: .actionSheet)

        let sortAlphabetical = UIAlertAction(title: "Show all (A - Z)", style: .default, handler: { (_: UIAlertAction!) in
            self.sortCritters(sort: {$0.name < $1.name})
        })

        let sortReverseAlphabetical = UIAlertAction(title: "Show all (Z - A)", style: .default, handler: { (_: UIAlertAction!) in
            self.sortCritters(sort: {$0.name > $1.name})
        })

        let availableThisMonth = UIAlertAction(title: "Show available this month", style: .default, handler: { (_: UIAlertAction!) in
            self.filterCrittersOn(.Month)
        })

        let availableNow = UIAlertAction(title: "Show available now (\(getTimeString()))", style: .default, handler: { (_: UIAlertAction!) in
          self.filterCrittersOn(.MonthHour)
        })

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(sortAlphabetical)
        alertController.addAction(sortReverseAlphabetical)
        alertController.addAction(availableThisMonth)
        alertController.addAction(availableNow)
        alertController.addAction(cancel)

        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = CGRect(x: sender.bounds.midX, y: sender.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = [.up]
        }

        self.present(alertController, animated: true, completion: nil)
    }

    func searchBar(_ searchBar: SHSearchBar, textDidChange text: String) {
        filterCrittersOn(.Name)
    }

    func searchButtonTapped(isBarActive: Bool) {
        if !isBarActive {
            filterOption = nil
            tableView.reloadData()
        }
    }
}
