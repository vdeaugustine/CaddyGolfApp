//
//  Extensions.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/31/21.
//

import Foundation
import UIKit

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}

// We are going to add some extensions to the UIView class so that we don't have to be so verbose when getting certain values of our UIViews
extension UIView {
    public var width: CGFloat {
        return frame.size.width
    }

    public var height: CGFloat {
        return frame.size.height
    }

    public var top: CGFloat {
        return frame.origin.y
    }

    public var bottom: CGFloat {
        return frame.size.height + frame.origin.y
    }

    public var left: CGFloat {
        return frame.origin.x
    }

    public var right: CGFloat {
        return frame.size.width + frame.origin.x
    }

    public var centerX: CGFloat {
        return left + (width / 2)
    }

    public var centerY: CGFloat {
        return top + (height / 2)
    }

    func dropShadow(scale: Bool = true) {
//        layer.masksToBounds = false
//        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 5

        func customShadowPath(viewLayer layer: CALayer,
                              shadowHeight: CGFloat) -> UIBezierPath {
            let layerX = layer.bounds.origin.x
            let layerY = layer.bounds.origin.y
            let layerWidth = layer.bounds.size.width
            let layerHeight = layer.bounds.size.height

            let path = UIBezierPath()
            path.move(to: CGPoint.zero)

            path.addLine(to: CGPoint(x: layerX + layerWidth,
                                     y: layerY))
            path.addLine(to: CGPoint(x: layerX + layerWidth,
                                     y: layerHeight))

            path.addCurve(to: CGPoint(x: 0,
                                      y: layerHeight),
                          controlPoint1: CGPoint(x: layerX + layerWidth,
                                                 y: layerHeight),
                          controlPoint2: CGPoint(x: layerX,
                                                 y: layerHeight))

            return path
        }

        layer.shadowPath = customShadowPath(viewLayer: layer, shadowHeight: 5).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

//    }
}

public extension UIView {
    func showAnimation(_ completionBlock: @escaping () -> Void) {
        isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                           self?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       }) { _ in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                               self?.transform = CGAffineTransform(scaleX: 1, y: 1)
                           }) { [weak self] _ in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }
}


