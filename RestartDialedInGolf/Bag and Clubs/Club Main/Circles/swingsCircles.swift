//
//  swingsCircles.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/18/22.
//

import SwiftUI

struct swingsCircles: View {
    @EnvironmentObject var modelData: ModelData
    var club: Club
    @State private var showingAverage = false
    var usedYards: Int {
//        if modelClub.getSwings().count < 1 { return modelClub.getDistance() }
        return showingAverage ? modelClub.getAverageDistance() : Int(modelClub.getDistance())
    }

    var modelClub: Club {
        return modelData.bag.clubs.first(where: { $0 == club })!
    }

    var body: some View {
        HStack {
            VStack {
                Button {
                    showingAverage.toggle()

                } label: {
                    VStack {
                        DistanceCircle(distance: usedYards)
                            .frame(width: 75, height: 75)
                        Text(showingAverage ? "Average Yards" : "Entered Yards")
                            .minimumScaleFactor(0.01)
                    }
                    .padding(.trailing, 50)
                }.tint(.white)
            }

            Button {
            } label: {
                VStack {
                    StrokesCircle(strokes: Double(modelClub.getSwings().count), goalStrokes: 50)
                        .frame(width: 75, height: 75)

                    Text("Strokes")
                }
                .padding(.leading, 50)
            }
            .tint(.white)
        }
        .padding()
    }
}
