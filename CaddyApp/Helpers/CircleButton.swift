//
//  CircleButton.swift
//  DialedInRedesign
//
//  Created by Vincent DeAugustine on 5/11/22.
//

import UIKit

class CircleButton: UIButton {
    var labelText: String
    
    
    init(labelText: String? = nil, width: CGFloat, mainColor: UIColor, borderColor: UIColor, action: Selector) {
        if let labelText = labelText {
            self.labelText = labelText
        } else {
            self.labelText = ""
        }
        var frame: CGRect = .zero
        frame.size = CGSize(width: width, height: width)
        super.init(frame: frame)
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 3
        self.addTarget(self.superview?.superclass, action: action, for: .touchUpInside)
        self.layer.cornerRadius = width / 2
        self.backgroundColor = mainColor
    }
    
    required init?(coder: NSCoder) {
        labelText = ""
        super.init(coder: coder)
    }
}
