//
//  SwingTypeBox.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/3/22.
//

import Foundation
import UIKit

class SwingTypeBox {
    var mainContainer: UIView
    let header: UIView
    let headerLabel: UIView
    var mainTextLabel: UILabel {
        willSet {
            print("Swing TYPE: \(swingType.rawValue). NEW VAL: \(newValue)")
            print("GLobal Swing Type: \(currentSwingType.rawValue)")
        }
        didSet {
            print("Swing TYPE: \(swingType.rawValue). OLD VAL: \(oldValue)")
            print("GLobal Swing Type: \(currentSwingType.rawValue)")
        }
    }

    let swingType: swingTypeState
//    var leftNeighborView: UIView?
//    var rightNeighborView: UIView?
//    var topNeighborView: UIView?
//    var padFromSides: CGFloat?

    init(type: swingTypeState) {
        swingType = type

        let labelText: String

        let yardageNum: Int

        switch type {
        case .fullSwing:
            labelText = "Full Swing"
            yardageNum = currentClub.fullDistance
        case .maxSwing:
            labelText = "Max Swing"
            yardageNum = currentClub.maxDistance
        case .threeFourths:
            labelText = "3/4 Swing"
            yardageNum = currentClub.threeFourthsDistance
        }

        mainContainer = {
            let theView = UIView()
            theView.translatesAutoresizingMaskIntoConstraints = true
            theView.layer.cornerRadius = globalCornerRadius
            //            view.backgroundColor = .red
            theView.backgroundColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 255 / 255)
            theView.isUserInteractionEnabled = true
            return theView
        }()

        header = {
            let theView = UIView()
            theView.translatesAutoresizingMaskIntoConstraints = true
            theView.layer.cornerRadius = globalCornerRadius
            //    view.backgroundColor = .red
            theView.backgroundColor = UIColor(red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 255 / 255)
            theView.isUserInteractionEnabled = true
            theView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

            return theView
        }()

        headerLabel = {
            let theView = UILabel()
            theView.font = UIFont(name: "Helvetica-Bold", size: 18)
            theView.adjustsFontSizeToFitWidth = true
            theView.text = labelText
            //    label.heightAnchor.constraint(equalToConstant: 49.0)
            //        label.translatesAutoresizingMaskIntoConstraints = true
            theView.textAlignment = .center
            return theView
        }()

        mainTextLabel = {
            let theView = UILabel()
            theView.font = UIFont(name: "Helvetica-BoldOblique", size: 80)
            theView.adjustsFontSizeToFitWidth = true
            theView.text = "\(yardageNum)"
            //    label.heightAnchor.constraint(equalToConstant: 49.0)
            //        label.translatesAutoresizingMaskIntoConstraints = true
            theView.textAlignment = .center
            //        label.translatesAutoresizingMaskIntoConstraints = false
            return theView
        }()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupFrames(padFromSides: CGFloat = 10, leftNeighbor: UIView? = nil, rightNeighbor: UIView? = nil, topNeighbor: UIView? = nil) {
        guard let mainContSuper = mainContainer.superview else {
            fatalError()
        }

        let widthOfSwingTypeBoxes = (mainContSuper.frame.width - padFromSides * 4) / 3
        let heightOfSwingTypeBoxes: CGFloat = 110
        guard let topNeighbor = topNeighbor else {
            return
        }

        if let leftNeighbor = leftNeighbor {
            mainContainer.frame = CGRect(x: leftNeighbor.right + padFromSides,
                                         y: topNeighbor.bottom + padFromSides,
                                         width: widthOfSwingTypeBoxes,
                                         height: heightOfSwingTypeBoxes)
        } else {
            mainContainer.frame = CGRect(x: padFromSides,
                                         y: topNeighbor.bottom + padFromSides,
                                         width: widthOfSwingTypeBoxes,
                                         height: heightOfSwingTypeBoxes)
        }

        print("main container bounds", mainContainer.bounds)
        mainContainer.dropShadow()
        header.frame = CGRect(x: 0,
                              y: 0,
                              width: mainContainer.width,
                              height: mainContainer.height / 3)

        headerLabel.frame = CGRect(x: 0,
                                   y: 0,
                                   width: header.width,
                                   height: header.height)

        mainTextLabel.frame = CGRect(x: -2,
                                     y: header.bottom + 18,
                                     width: mainContainer.width,
                                     height: mainContainer.height / 3)
    }

    func layoutViews() {
        mainContainer.addSubview(header)
        header.addSubview(headerLabel)
        mainContainer.addSubview(mainTextLabel)
    }

    /// Changes the mainTextLabel for the SwingTypeBox
    func updateYardage() {
//        yardageNumberLabel = currentClub
        switch swingType {
        case .fullSwing:
            mainTextLabel.text = "\(currentClub.fullDistance)"
        case .maxSwing:
            mainTextLabel.text = "\(currentClub.maxDistance)"
        case .threeFourths:
            mainTextLabel.text = "\(currentClub.threeFourthsDistance)"
        }
    }
}
