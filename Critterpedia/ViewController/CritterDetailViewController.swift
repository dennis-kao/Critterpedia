//
//  CritterDetailViewController.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-05-10.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import UIKit

final class CritterDetailViewController: UIViewController {
    
    static let months: [[String]] = [ ["Jan.", "Feb", "Mar.", "Apr."],
                                      ["May", "June", "July", "Aug."],
                                      ["Sept.", "Oct.", "Nov.", "Dec."],]
    
    fileprivate let critter: Critter
    fileprivate let hemisphere: Hemisphere
    fileprivate let critterDetail = CritterDetailView()
    
    fileprivate var edgeInsetPadding: CGFloat = 1
    fileprivate let minimumSpacing: CGFloat = 1
    fileprivate let numberOfSections = 3
    fileprivate let numberOfItemsInSection = 4

    init(critter: Critter, hemisphere: Hemisphere) {
        self.critter = critter
        self.hemisphere = hemisphere
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9794296622, green: 0.9611505866, blue: 0.882307291, alpha: 1)
        
        critterDetail.detailsView.calendarView.delegate = self
        critterDetail.detailsView.calendarView.dataSource = self

        critterDetail.titleView.critterLabel.text = critter.name
        critterDetail.detailsView.activeHours.text = critter.timesText
        critterDetail.detailsView.location.text = critter.location
        critterDetail.detailsView.value.text = "\(critter.price)"

        fetchCritterImage(critter: critter)
        
        view.addSubview(critterDetail)
        critterDetail.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            critterDetail.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -10),
            critterDetail.topAnchor.constraint(equalTo: view.topAnchor, constant: UIApplication.shared.statusBarFrame.size.height),
            critterDetail.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
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

extension CritterDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItemsInSection
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CalendarCollectionViewCell.self), for: indexPath) as? CalendarCollectionViewCell else {
            fatalError("Did not register CalendarCollectionViewCell to the tableView")
        }
        
        let cellMonthNumber = 4 * indexPath.section + indexPath.item + 1

        switch hemisphere {
            case .Northern:
                if critter.northernMonths.contains(cellMonthNumber) {
                    cell.setAvailableMonth()
                }
            case .Southern:
                if critter.southernMonths.contains(cellMonthNumber) {
                    cell.setAvailableMonth()
                }
        }
        
        cell.monthLabel.text = CritterDetailViewController.months[indexPath.section][indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionWidth = collectionView.frame.width - CGFloat(numberOfItemsInSection) * minimumSpacing - CGFloat(edgeInsetPadding)
        let sectionHeight = collectionView.frame.height - CGFloat(numberOfSections) * minimumSpacing - CGFloat(edgeInsetPadding)
        return CGSize(width: sectionWidth / CGFloat(numberOfItemsInSection), height: sectionHeight / CGFloat(numberOfSections))
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: edgeInsetPadding, left: edgeInsetPadding, bottom: edgeInsetPadding, right: edgeInsetPadding)
    }
}
