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

    func constrainEqualToSuperView() {
        guard let superview = superview else {
            return
        }
        let constraints: [NSLayoutConstraint] = [
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func doTheseConstraints(_ theseConstraintsWithConstants: [(ConstraintTypes, CGFloat?)], to relativeView: UIView) {
        var listOfConstraints = [NSLayoutConstraint]()
        for item in theseConstraintsWithConstants {
            switch item.0 {
            case .topAnchor:
                listOfConstraints.append(topAnchor.constraint(equalTo: relativeView.topAnchor, constant: item.1 ?? 0))
            case .bottomAnchor:
                listOfConstraints.append(bottomAnchor.constraint(equalTo: relativeView.bottomAnchor, constant: item.1 ?? 0))
            case .leadingAnchor:
                listOfConstraints.append(leadingAnchor.constraint(equalTo: relativeView.leadingAnchor, constant: item.1 ?? 0))
            case .trailingAnchor:
                listOfConstraints.append(trailingAnchor.constraint(equalTo: relativeView.trailingAnchor, constant: item.1 ?? 0))
            case .centerX:
                listOfConstraints.append(centerXAnchor.constraint(equalTo: relativeView.centerXAnchor, constant: item.1 ?? 0))
            case .centerY:
                listOfConstraints.append(centerYAnchor.constraint(equalTo: relativeView.centerYAnchor, constant: item.1 ?? 0))
            }
        }

        NSLayoutConstraint.activate(listOfConstraints)
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

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}



