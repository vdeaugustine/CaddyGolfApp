//
//  StrokesCircleView.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 5/25/22.
//

import UIKit

class StrokesCircleView: UIView {

    var color: UIColor = .systemBlue
    var lineWidth: CGFloat = 3.0
    var fillPercentage: CGFloat = 1.0
    
    init(color: UIColor = .systemBlue, lineWidth: CGFloat = 3.0, fillPercentage: CGFloat = 1.0) {
        self.color = color
        self.lineWidth = lineWidth
        self.fillPercentage = fillPercentage
        
        super.init(frame: .zero)
        self.backgroundColor = .clear
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
        
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        // Get the Graphics Context
        if let context = UIGraphicsGetCurrentContext() {
            
            // Set the circle outerline-width
            context.setLineWidth(lineWidth);
            
            // Set the circle outerline-colour
            color.set()
            
            // Create Circle
            let center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
            let radius = (frame.size.width - 10)/2
            let endAnglePercentage = fillPercentage
            let multiplier = (endAnglePercentage != 1.0 ? (1.0 - endAnglePercentage) : 1)
            let endAngle = .pi * 2 * multiplier
            print("Multiplier is ", multiplier)
            let startAngle: CGFloat = -.pi / 2
            print("fill \(fillPercentage) which gives end angle of \(endAngle)" )
            context.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle + startAngle, clockwise: false)
            
                
            // Draw
            context.strokePath()
        }
    }

}
