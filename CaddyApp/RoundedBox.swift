//
//  SwingTypeBox.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/3/22.
//

import Foundation
import UIKit



/// How to use
/// - init
/// - call thisObjectsSuperView.addSubview(mainContainer)
/// - call setupFrames
/// - call layoutViews
/// - call setMainText
/// - call setHeaderText
class RoundedBox {
    var mainContainer: UIView
    let header: UIView
    let headerLabel: UILabel
    let mainTextLabel: UILabel
    var mainText: String?
    var headerText: String?

    init() {
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
            //    label.heightAnchor.constraint(equalToConstant: 49.0)
            //        label.translatesAutoresizingMaskIntoConstraints = true
            theView.textAlignment = .center
            return theView
        }()

        mainTextLabel = {
            let theView = UILabel()
            theView.font = UIFont(name: "Helvetica-BoldOblique", size: 80)
            theView.adjustsFontSizeToFitWidth = true
            theView.text = "0"
            //    label.heightAnchor.constraint(equalToConstant: 49.0)
            //        label.translatesAutoresizingMaskIntoConstraints = true
            theView.textAlignment = .center
            theView.numberOfLines = 0
            //        label.translatesAutoresizingMaskIntoConstraints = false
            return theView
        }()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    /// Call to set up the frames
    /// - Parameter thisFrame: the exact frame you want it to be
    func setupFrames(with thisFrame: CGRect) {
        mainContainer.frame = CGRect(x: thisFrame.minX, y: thisFrame.minY, width: thisFrame.width, height: thisFrame.height)

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

    
    /// Set up frames
    /// - Parameters:
    ///   - padFromSides: distance from sides you want to inset
    ///   - superView: the box will go inside this view
    func setupFrames(padFromSides: CGFloat = 10, nestedIn superView: UIView) {
        let mainContSuper = superView

        let widthOfSwingTypeBoxes = superView.width - (padFromSides * 4)
        let heightOfSwingTypeBoxes: CGFloat = mainContSuper.frame.height - padFromSides * 2

        mainContainer.frame = CGRect(x: padFromSides,
                                     y: padFromSides,
                                     width: widthOfSwingTypeBoxes,
                                     height: heightOfSwingTypeBoxes)

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

    func setMainText(_ text: String) {
        mainText = text
        mainTextLabel.text = mainText
        mainTextLabel.adjustsFontSizeToFitWidth = true
    }

    func setHeaderText(_ text: String) {
        headerText = text
        headerLabel.text = headerText
        headerLabel.adjustsFontSizeToFitWidth = true
    }
}
