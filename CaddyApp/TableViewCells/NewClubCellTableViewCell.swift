//
//  NewClubCellTableViewCell.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 5/24/22.
//

import UIKit

class NewClubCellTableViewCell: UITableViewCell {
    var club: ClubObject!
    var swingType: swingTypeState!

    private var container: UIView = {
        let thisView = UIView()
        thisView.translatesAutoresizingMaskIntoConstraints = false
        thisView.backgroundColor = .systemGray4
        thisView.accessibilityIdentifier = "***CELL CONTAINER VIEW***"
        thisView.layer.cornerRadius = globalCornerRadius
        return thisView
    }()

    private lazy var clubNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.text = club.name
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "***Club Name Label***"
        return label
    }()

    private lazy var clubDistanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        switch swingType {
        case .fullSwing:
            label.text = "\(club.fullDistance) yards"
        case .threeFourths:
            label.text = "\(club.fullDistance) yards"
        case .maxSwing:
            label.text = "\(club.fullDistance) yards"
        default:
            break
        }
        label.textAlignment = .right
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "***DistanceLabelForCell***"
        return label
    }()

    override func layoutSubviews() {
        contentView.addSubview(container)
        container.addSubview(clubNameLabel)
        container.addSubview(clubDistanceLabel)
        NSLayoutConstraint.activate([
            
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            
            clubNameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            clubNameLabel.trailingAnchor.constraint(equalTo: container.centerXAnchor),
            clubNameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            clubNameLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),

            clubDistanceLabel.leadingAnchor.constraint(equalTo: container.centerXAnchor, constant: 5),
            clubDistanceLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            clubDistanceLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            clubDistanceLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
        ])
    }
}
