//
//  CritterListingViewController.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-04-25.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import UIKit
import SHSearchBar
import GoogleMobileAds

final class CritterListingViewController: UIViewController {
    
    fileprivate var insectCritters = CritterParser.loadJson(filename: "Insects")
    fileprivate var fishCritters = CritterParser.loadJson(filename: "Fish")
    fileprivate var filteredCritters: [Critter] = []
    
    var hemisphere: Hemisphere? = nil
    
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
    fileprivate var bannerAd: GADBannerView = {
        let banner = GADBannerView(frame: .zero)
        // prod id: ca-app-pub-4364291013766259/7607752155
        // test id: ca-app-pub-3940256099942544/2934735716
        banner.adUnitID = "ca-app-pub-4364291013766259/7607752155"
        banner.isAutoloadEnabled = true
        return banner
    }()
    
    fileprivate let critterPickerMaxHeight: CGFloat = 200
    fileprivate let critterPickerMinHeight: CGFloat = 130
    fileprivate lazy var pickerHeightAnchor: NSLayoutConstraint = critterPicker.heightAnchor.constraint(equalToConstant: critterPickerMaxHeight)
    
    fileprivate var filterOption: Critter.FilterOptions? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        title = ""
        view.backgroundColor = #colorLiteral(red: 0.9794296622, green: 0.9611505866, blue: 0.882307291, alpha: 1)
        
        critterPicker.delegate = self
        searchButtonBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CritterTableViewCell.self, forCellReuseIdentifier: String(describing: CritterTableViewCell.self))
        
        bannerAd.rootViewController = self
        bannerAd.delegate = self
        
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
        
        setupBannerAd()
    }
    
    fileprivate func setupBannerAd() {
        
        // remove this line of code for production!
        // iphone 11 pro: 2aef27f5c3f4ea47515161fc958dd562
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "2aef27f5c3f4ea47515161fc958dd562" ]
        
        view.addSubview(bannerAd)
        bannerAd.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerAd.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bannerAd.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        // Step 2 - Determine the view width to use for the ad width.
        let frame = { () -> CGRect in
          // Here safe area is taken into account, hence the view frame is used
          // after the view has been laid out.
          if #available(iOS 11.0, *) {
            return view.frame.inset(by: view.safeAreaInsets)
          } else {
            return view.frame
          }
        }()
        let viewWidth = frame.size.width

        // Step 3 - Get Adaptive GADAdSize and set the ad view.
        // Here the current interface orientation is used. If the ad is being preloaded
        // for a future orientation change or different orientation, the function for the
        // relevant orientation should be used.
        bannerAd.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
    }
    
    fileprivate func getSelectedCritter() -> [Critter]? {

        switch (critterPicker.selectedCritter) {
            case .Fish:
                return fishCritters
            case .Insect:
                return insectCritters
        }
    }
    
    fileprivate func sortCritters(sort: (Critter, Critter) -> Bool) {
        filterOption = nil
        searchButtonBar.searchBar.cancelSearch()
        
        switch (critterPicker.selectedCritter) {
            case .Fish:
                fishCritters?.sort(by: sort)
            case .Insect:
                insectCritters?.sort(by: sort)
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
                switch (critterPicker.selectedCritter) {
                   case .Fish:
                       return fishCritters![indexPath.item]
                   case .Insect:
                       return insectCritters![indexPath.item]
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
                switch (critterPicker.selectedCritter) {
                   case .Fish:
                       return fishCritters![indexPath.item]
                   case .Insect:
                       return insectCritters![indexPath.item]
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

        let sortAlphabetical = UIAlertAction(title: "Show all (A - Z)", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.sortCritters(sort: {$0.name < $1.name})
        })

        let sortReverseAlphabetical = UIAlertAction(title: "Show all (Z - A)", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.sortCritters(sort: {$0.name > $1.name})
        })

        let availableThisMonth = UIAlertAction(title: "Show available this month", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.filterCrittersOn(.Month)
        })
        
        let availableNow = UIAlertAction(title: "Show available now (\(getTimeString()))", style: .default, handler: { (alert: UIAlertAction!) -> Void in
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

extension CritterListingViewController: GADBannerViewDelegate {
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
                
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
          bannerView.alpha = 1
        })
    }

    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
        didFailToReceiveAdWithError error: GADRequestError) {
      print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("adViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("adViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("adViewDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
      print("adViewWillLeaveApplication")
    }
}
