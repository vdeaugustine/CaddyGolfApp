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
    var modelClub: Club {
        return modelData.bag.clubs.first(where: {$0 == club})!
    }
    var body: some View {
        HStack {
            VStack {
                DistanceCircle(distance: Int(club.getDistance()))
                    .frame(width: 75, height: 75)
                Text("Average Yards")
            }
            .padding(.trailing, 50)
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
