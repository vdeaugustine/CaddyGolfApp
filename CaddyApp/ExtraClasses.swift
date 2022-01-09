//
//  ExtraClasses.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/8/22.
//

import Foundation
import UIKit
class TransparentButton: UIButton {
    
    /// A transparent background that will take the shape of it's superView. All you have to do is initialize this class and the init() method should take care of setting everything up
    /// - Parameters:
    ///   - targetForButton: a selector that determines which function to call when button is tapped
    ///   - superView: the view the button will go inside of and take the shape of
    init(superView: UIView) {
        super.init(frame: superView.frame)
        self.backgroundColor = .clear
        self.frame = CGRect(x: 0, y: 0, width: super.frame.width, height: super.frame.height)
        
        superView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            self.widthAnchor.constraint(equalToConstant: superView.width),
            self.heightAnchor.constraint(equalToConstant: superView.height),
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            self.topAnchor.constraint(equalTo: superView.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
