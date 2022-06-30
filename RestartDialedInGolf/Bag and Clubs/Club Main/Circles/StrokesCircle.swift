//
//  StrokesCircle.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/18/22.
//

import SwiftUI

struct StrokesCircle: View {
    @State var progressValue: Float = 0.0
    var strokes: CGFloat
    var goalStrokes: CGFloat
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ZStack {
                    Circle()
                        .trim(from: 1.0 - CGFloat(strokes / goalStrokes), to: 1.0)
                        .stroke(lineWidth: 5)
                        .foregroundColor(.blue)
                        .rotationEffect(.degrees(-90))
                    
                    Text("\(Int(strokes))")
                        .font(.system(size: geometry.size.height > geometry.size.width ? geometry.size.width * 0.4 : geometry.size.height * 0.4))
                }
            }
        }
    }
}
