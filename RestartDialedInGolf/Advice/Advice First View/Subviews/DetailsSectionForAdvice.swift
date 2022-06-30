//
//  DetailsSectionForAdvice.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/29/22.
//

import SwiftUI

struct DetailsSectionForAdvice: View {
    var body: some View {
        Section("Details") {
            VStack {
                DistanceToPinView()
                AccuracyOrDistanceRow()
                BallPositionRow()
            }
            .padding([.top, .bottom], 5)
        }
    }
}
