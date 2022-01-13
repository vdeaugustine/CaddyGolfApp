//
//  LayingOutViewsFunctions.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/12/22.
//

import Foundation
import UIKit


func putView(thisView: UIView, containerView: UIView, leftPadding: CGFloat = 0, rightPadding: CGFloat = 0, topPadding: CGFloat = 0, bottomPadding: CGFloat = 0) {
    containerView.addSubview(thisView)
    thisView.frame =  CGRect(x: leftPadding,
                             y: topPadding,
                             width: containerView.width - leftPadding - rightPadding,
                             height: containerView.height - topPadding - bottomPadding)
}




