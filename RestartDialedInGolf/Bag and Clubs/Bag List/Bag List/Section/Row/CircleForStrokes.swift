//
//  CircleForStrokes.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 7/8/22.
//

import SwiftUI


/// Draws a circle that is x % completed where the x is determined by var strokes / 25
struct CircleForStrokes: Shape {
    
    var strokes: Double = 23
    func path(in rect: CGRect) -> Path {
        var p = Path()

        p.addArc(center: CGPoint(x: 25, y: 25),
                 radius: 24,
                 startAngle: .degrees(270),
                 endAngle: .degrees(Double(270) - Double(360) * (strokes / 25)),
                 clockwise: true)

        return p.strokedPath(.init(lineWidth: 3))
    }
}

struct CircleForStrokes_Previews: PreviewProvider {
    static var previews: some View {
        CircleForStrokes()
    }
}
