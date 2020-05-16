//
//  DetailsView.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-05-10.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import UIKit

class DetailsView: UIView {
            
    fileprivate lazy var seasonalityLabel: UILabel = setupLabel()
    fileprivate lazy var activeHoursLabel: UILabel = setupLabel()
    fileprivate lazy var locationLabel: UILabel = setupLabel()
    fileprivate lazy var valueLabel: UILabel = setupLabel()
    
    fileprivate let locationValueStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        return stackView
    }()
    fileprivate let locationView: UIView = {
        let view = UIView()
        view.layer.borderColor = #colorLiteral(red: 0.6156862745, green: 0.5843137255, blue: 0.4156862745, alpha: 1)
        view.layer.borderWidth = 1
        return view
    }()
    fileprivate let valueView: UIView = {
        let view = UIView()
        view.layer.borderColor = #colorLiteral(red: 0.6156862745, green: 0.5843137255, blue: 0.4156862745, alpha: 1)
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var activeHours: UILabel = setupValueLabel()
    lazy var location: UILabel = {
        let label = setupValueLabel()
        label.numberOfLines = 2
        return label
    }()
    lazy var value: UILabel = setupValueLabel()
    
    fileprivate let labelHeight: CGFloat = 36

    let calendarView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CalendarCollectionViewCell.self))
        collectionView.isScrollEnabled = false
        collectionView.layer.borderWidth = 2
        collectionView.layer.borderColor = #colorLiteral(red: 0.6156862745, green: 0.5843137255, blue: 0.4156862745, alpha: 1)
        collectionView.backgroundColor = #colorLiteral(red: 0.6156862745, green: 0.5843137255, blue: 0.4156862745, alpha: 1)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.6156862745, green: 0.5843137255, blue: 0.4156862745, alpha: 1)
        
        seasonalityLabel.text = NSLocalizedString("Seasonality", comment: "Months in which a Critter appears")
        activeHoursLabel.text = NSLocalizedString("ActiveHours", comment: "Hours in which a critter appears")
        locationLabel.text = NSLocalizedString("Location", comment: "Where a critter appears")
        valueLabel.text = NSLocalizedString("Bells", comment: "The in game currency")
        
        addSubview(seasonalityLabel)
        seasonalityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            seasonalityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            seasonalityLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            seasonalityLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35),
            seasonalityLabel.heightAnchor.constraint(equalToConstant: labelHeight),
        ])
        
        addSubview(calendarView)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            calendarView.leftAnchor.constraint(equalTo: seasonalityLabel.leftAnchor),
            calendarView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            calendarView.topAnchor.constraint(equalTo: seasonalityLabel.bottomAnchor, constant: 10),
        ])
        
        addSubview(activeHoursLabel)
        activeHoursLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activeHoursLabel.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 15),
            activeHoursLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            activeHoursLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.40),
            activeHoursLabel.heightAnchor.constraint(equalToConstant: labelHeight),
        ])
        
        addSubview(activeHours)
        activeHours.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activeHours.centerYAnchor.constraint(equalTo: activeHoursLabel.centerYAnchor),
            activeHours.leftAnchor.constraint(equalTo: activeHoursLabel.rightAnchor, constant: 10),
            activeHours.rightAnchor.constraint(equalTo: rightAnchor, constant: 10),
            activeHours.heightAnchor.constraint(equalTo: activeHoursLabel.heightAnchor),
        ])

        locationValueStackView.addArrangedSubview(locationView)
        locationValueStackView.addArrangedSubview(valueView)

        addSubview(locationValueStackView)
        locationValueStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationValueStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            locationValueStackView.leftAnchor.constraint(equalTo: leftAnchor),
            locationValueStackView.rightAnchor.constraint(equalTo: rightAnchor),
            locationValueStackView.topAnchor.constraint(equalTo: activeHoursLabel.bottomAnchor, constant: 10),
        ])
        
        locationView.translatesAutoresizingMaskIntoConstraints = false
        
        locationView.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            locationLabel.centerYAnchor.constraint(equalTo: locationView.centerYAnchor),
            locationLabel.leftAnchor.constraint(equalTo: locationView.leftAnchor, constant: 10),
            locationLabel.widthAnchor.constraint(equalTo: locationView.widthAnchor, multiplier: 0.4),
        ])
        
        locationView.addSubview(location)
        location.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            location.centerYAnchor.constraint(equalTo: locationLabel.centerYAnchor),
            location.leftAnchor.constraint(equalTo: locationLabel.rightAnchor, constant: 10),
            location.rightAnchor.constraint(equalTo: locationView.rightAnchor, constant: -10),
        ])
        
        valueView.translatesAutoresizingMaskIntoConstraints = false

        valueView.addSubview(valueLabel)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            valueLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            valueLabel.centerYAnchor.constraint(equalTo: valueView.centerYAnchor),
            valueLabel.leftAnchor.constraint(equalTo: valueView.leftAnchor, constant: 10),
            valueLabel.widthAnchor.constraint(equalTo: valueView.widthAnchor, multiplier: 0.4),
        ])
        
        valueView.addSubview(value)
        value.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            value.centerYAnchor.constraint(equalTo: valueLabel.centerYAnchor),
            value.leftAnchor.constraint(equalTo: valueLabel.rightAnchor, constant: 10),
            value.rightAnchor.constraint(equalTo: valueView.rightAnchor, constant: -10),
        ])
    }
    
    fileprivate func setupLabel() -> UILabel {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.8823529412, blue: 0.6352941176, alpha: 1)
        label.layer.masksToBounds = true
        label.font = UIFont(name: "FinkHeavy", size: 35)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.3
        label.adjustsFontSizeToFitWidth = true
        return label
    }
    
    fileprivate func setupValueLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "FinkHeavy", size: 28)
        label.textColor = #colorLiteral(red: 0.2666666667, green: 0.262745098, blue: 0.2392156863, alpha: 1)
        label.textAlignment = .left
        label.minimumScaleFactor = 0.1
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        seasonalityLabel.layer.cornerRadius = 6
        activeHoursLabel.layer.cornerRadius = 6
        locationLabel.layer.cornerRadius = 6
        valueLabel.layer.cornerRadius = 6
    }
}
