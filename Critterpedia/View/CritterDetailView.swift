//
//  CritterDetailView.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-05-10.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import UIKit

final class CritterDetailView: UIView {

    let titleView = TitleView()
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    let detailsView = DetailsView()

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

        titleView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            titleView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            titleView.heightAnchor.constraint(equalToConstant: 55),
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 40),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.30),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        let minDetailsViewHeightAnchor = detailsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300)
        minDetailsViewHeightAnchor.priority = UILayoutPriority(rawValue: 1000)
        let detailsViewHeightAnchor = detailsView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40)
        detailsViewHeightAnchor.priority = UILayoutPriority(rawValue: 750)

        detailsView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(detailsView)
        NSLayoutConstraint.activate([
            minDetailsViewHeightAnchor,
            detailsViewHeightAnchor,
            detailsView.widthAnchor.constraint(equalTo: widthAnchor),
            detailsView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
