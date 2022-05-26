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

    private lazy var circleView: StrokesCircleView = {
        let c = StrokesCircleView()
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()

    private lazy var progressCircleView: StrokesCircleView = {
        let c = StrokesCircleView(color: .white, fillPercentage: CGFloat.random(in: 0.0 ... 1.0))
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
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
        container.addSubview(circleView)
        container.addSubview(progressCircleView)
        container.addSubview(clubNameLabel)
        container.addSubview(clubDistanceLabel)
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),

            circleView.topAnchor.constraint(equalTo: container.topAnchor, constant: 5),
            circleView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -5),
            circleView.widthAnchor.constraint(equalTo: circleView.heightAnchor),
            circleView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 5),

            progressCircleView.topAnchor.constraint(equalTo: circleView.topAnchor),
            progressCircleView.leadingAnchor.constraint(equalTo: circleView.leadingAnchor),
            progressCircleView.trailingAnchor.constraint(equalTo: circleView.trailingAnchor),
            progressCircleView.bottomAnchor.constraint(equalTo: circleView.bottomAnchor),

            clubNameLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 20),
            clubNameLabel.trailingAnchor.constraint(equalTo: container.centerXAnchor, constant: 70),
            clubNameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            clubNameLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),

            clubDistanceLabel.leadingAnchor.constraint(equalTo: clubNameLabel.trailingAnchor, constant: 5),
            clubDistanceLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            clubDistanceLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            clubDistanceLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
        ])
    }
}
