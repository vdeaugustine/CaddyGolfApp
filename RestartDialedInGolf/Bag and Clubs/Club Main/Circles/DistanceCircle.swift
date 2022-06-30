//
//  DistanceCircle.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/18/22.
//

import SwiftUI

struct DistanceCircle: View {
    var distance: Int
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle().strokeBorder(.blue, lineWidth: 5)
                Text("\(distance)")
                    .font(.system(size: geometry.size.height > geometry.size.width ? geometry.size.width * 0.4 : geometry.size.height * 0.4))
            }
        }
    }
}
